package {
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.utils.ByteArray;
	
	import org.libspark.flartoolkit.core.FLARCode;
	import org.libspark.flartoolkit.core.param.FLARParam;
	import org.libspark.flartoolkit.core.raster.rgb.FLARRgbRaster_BitmapData;
	import org.libspark.flartoolkit.core.transmat.FLARTransMatResult;
	import org.libspark.flartoolkit.detector.FLARSingleMarkerDetector;
	import org.libspark.flartoolkit.pv3d.FLARBaseNode;
	import org.libspark.flartoolkit.pv3d.FLARCamera3D;
	import org.papervision3d.lights.PointLight3D;
	import org.papervision3d.materials.shadematerials.FlatShadeMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.primitives.Cube;
	import org.papervision3d.render.BasicRenderEngine;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.Viewport3D;
	
	[SWF(width=640,height=480,frameRate=30,backgroundColor=0xffffff)]
	public class FLARDemo extends Sprite
	{
		[Embed(source="pat1.pat", mimeType="application/octet-stream")]
		private var _pattern:Class;
		
		[Embed(source="camera_para.dat", mimeType="application/octet-stream")]
		private var _params:Class;
		
		private var fparams:FLARParam;
		private var mpattern:FLARCode;
		private var vid:Video;
		private var cam:Camera;
		private var bmd:BitmapData;
		private var raster:FLARRgbRaster_BitmapData;
		private var detector:FLARSingleMarkerDetector;
		private var scene:Scene3D;
		private var camera:FLARCamera3D;
		private var cont:FLARBaseNode;
		private var vp:Viewport3D;
		private var bre:BasicRenderEngine;
		private var trans:FLARTransMatResult;
		
		public function FLARDemo()
		{
			setUpFLAR();
			setUpCamera();
			setUpBitmap();
			setUpPV3D();
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		private function setUpFLAR():void
		{
			fparams = new FLARParam();
			fparams.loadARParam(new _params() as ByteArray);
			
			mpattern = new FLARCode(16,16);
			mpattern.loadARPatt(new _pattern());	
		}
		private function setUpCamera():void
		{
			vid = new Video(640,480);
			cam = Camera.getCamera();
			cam.setMode(640,480,30);
			vid.attachCamera(cam);
			addChild(vid);
		}
		private function setUpBitmap():void
		{
			bmd = new BitmapData(640,480);
			bmd.draw(vid);
			
			raster = new FLARRgbRaster_BitmapData(bmd);
			detector = new FLARSingleMarkerDetector(fparams,mpattern,80);
		}
		private function setUpPV3D():void
		{
			scene = new Scene3D();
			camera = new FLARCamera3D(fparams);
			cont = new FLARBaseNode();
			scene.addChild(cont);
			
			var pl:PointLight3D = new PointLight3D();
			pl.x = 1000;
			pl.y = 1000;
			pl.z = -1000;
			
			var ml:MaterialsList = new MaterialsList({all:new FlatShadeMaterial(pl)});
			
			var cube1:Cube = new Cube(ml,30,30,30);
			var cube2:Cube = new Cube(ml,30,30,30);
			cube2.z = 50;
			var cube3:Cube = new Cube(ml,30,30,30);
			cube3.z = 100;
			
			cont.addChild(cube1);
			cont.addChild(cube2);
			cont.addChild(cube3);
			
			bre = new BasicRenderEngine();
			trans = new FLARTransMatResult();
			
			vp = new Viewport3D();
			addChild(vp);
		}
		private function loop(e:Event):void
		{
			bmd.draw(vid);
			try
			{
				if(detector.detectMarkerLite(raster,80) && detector.getConfidence() > 0.5)
				{
					detector.getTransformMatrix(trans);
					cont.setTransformMatrix(trans);
					bre.renderScene(scene,camera,vp);
				}
			}
			catch(e:Error)
			{
				
			}
		}
	}
}
