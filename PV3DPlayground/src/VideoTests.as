package
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.net.NetStream;
	
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.primitives.Cube;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.view.BasicView;
	
	[SWF(width=640,height=480,backgroundColor=0x000000)]
	public class VideoTests extends BasicView
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;	
		private var floor:Plane;
		private var cube:Cube;
		
		private var wireFrameMaterial:WireframeMaterial;
		private var bitmapMaterial:BitmapMaterial;
		private var matList:MaterialsList = new MaterialsList();
		private var sides:Array = new Array("top", "left", "back", "bottom", "right", "front");
		
		private var video:Video;
		private var stream:NetStream;
		
		public function VideoTests()
		{
			super(640,480,true,true,"Target");
			
			video = new Video(320,240);
			var cam:Camera = Camera.getCamera();
			
			video.attachCamera(cam);
			//addChild(video);
			
			init();
		}
		private function init():void
		{
			wireFrameMaterial = new WireframeMaterial(0xcc0000,100,1);
			//floor = new Plane(wireFrameMaterial,500,500,4,4);
			//scene.addChild(floor,"Floor");
			
			for(var i:uint=0;i<5;i++)
			{
				matList.addMaterial(wireFrameMaterial, sides[i]);
			}
			
			bitmapMaterial = new BitmapMaterial(new BitmapData(320,240,true));
			bitmapMaterial.smooth = true;
			bitmapMaterial.doubleSided = true;
			matList.addMaterial(bitmapMaterial, sides[5]);
			
			cube = new Cube(matList,640,10,480,4,4,1);
			scene.addChild(cube,"Cube");
			
			addEventListener(Event.ENTER_FRAME, onRenderTick);
		}
		override protected function onRenderTick(event:Event=null):void
		{
			bitmapMaterial.bitmap.draw(video);
			
			cube.rotationX += (mouseY - centreY) * .03;
			cube.rotationY -= (mouseX - centreX) * .03;
			
			renderer.renderScene(scene, camera, viewport);
		}
	}
}