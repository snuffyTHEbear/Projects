package {
	import com.bit101.components.HSlider;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	
	import org.papervision3d.core.geom.TriangleMesh3D;
	import org.papervision3d.core.proto.MaterialObject3D;
	import org.papervision3d.lights.PointLight3D;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.materials.shadematerials.CellMaterial;
	import org.papervision3d.materials.shadematerials.EnvMapMaterial;
	import org.papervision3d.materials.shadematerials.FlatShadeMaterial;
	import org.papervision3d.materials.shadematerials.GouraudMaterial;
	import org.papervision3d.materials.shadematerials.PhongMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.primitives.Sphere;
	import org.papervision3d.view.BasicView;
	
	[SWF(width=640,height=480,backgroundColor=0,frameRate=24)]
	public class Main extends BasicView
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;
		private var light:PointLight3D = new PointLight3D();
		private var instance3D:TriangleMesh3D;
		private var colourA:uint = 0xcc0000;
		private var colourB:uint = 0x000000;
		//
		private var xSlider:HSlider = new HSlider(super.stage,5,5,onSlide);
		private var ySlider:HSlider = new HSlider(super.stage,5,25,onSlide);
		private var zSlider:HSlider = new HSlider(super.stage,5,45,onSlide);
		
		public function Main()
		{
			super(600,400,true,true);
			setUpSliders();
			init();
		}
		
		private function setUpSliders():void
		{
			xSlider.maximum = ySlider.maximum = zSlider.maximum = 2000;
			xSlider.minimum = ySlider.minimum = zSlider.minimum = -2000;
			xSlider.width = ySlider.width = zSlider.width = 600;
			zSlider.value = camera.z;
			xSlider.value = camera.x;
			ySlider.value = camera.y;
		}
		
		private function init():void
		{
			var bmd:BitmapData = new BitmapData(100,100,false,colourA);
			var bmd2:BitmapData = new BitmapData(100,100,false,colourB);
			var w:WireframeMaterial = new WireframeMaterial(colourA,100,2);
			var bmat:BitmapMaterial = new BitmapMaterial(bmd);
			var cellMaterial:CellMaterial = new CellMaterial(light,colourA,colourB,2);
			var flatMaterial:FlatShadeMaterial = new FlatShadeMaterial(light,colourA, colourB,0);
			var phongMaterial:PhongMaterial = new PhongMaterial(light,colourA,colourB,2);
			var envMaterial:EnvMapMaterial = new EnvMapMaterial(light,bmd,bmd2,30);
			var gouraudMaterial:GouraudMaterial = new GouraudMaterial(light,colourA,colourB,0);
			var sides:Array = new Array("top","left","back","bottom","right","front");
			
			var matList:MaterialsList = new MaterialsList();
						
			instance3D = new Sphere(flatMaterial, 300, 36, 24);
			scene.addChild(instance3D);
			
			//singleRender();
			addEventListener(Event.ENTER_FRAME, onRenderTick);
		}
		
		private function createMaterialList(material:MaterialObject3D, materialList:MaterialsList, sides:Array=null):void
		{
			for(var i:uint=0;i<6;i++)
			{
				materialList.addMaterial(material,sides[i]);
			}
		}
		
		private function onSlide(e:Event):void
		{
			camera.z = zSlider.value;
			camera.y = ySlider.value;
			camera.x = xSlider.value;
		}
		
		override protected function onRenderTick(event:Event=null):void
		{
			super.onRenderTick(event);
			instance3D.rotationY -= (mouseX-centreX)*.03;
			instance3D.rotationX -= (mouseY-centreY)*.03;
			/* instance3D.rotationX += 2;
			instance3D.rotationY += 2; */
		}
	}
}
