package
{
	import flash.events.Event;
	
	import org.papervision3d.lights.PointLight3D;
	import org.papervision3d.materials.shadematerials.FlatShadeMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.parsers.Collada;
	import org.papervision3d.view.BasicView;
	
	[SWF(width=640,height=480,backgroundColor=0x000000)]
	public class ColladaTests extends BasicView
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;	
		private var collada:Collada;
		public function ColladaTests()
		{
			super(640,480,true,true,"Target");
			init();
		}
		private function init():void
		{
			var matList:MaterialsList = new MaterialsList();
			var light:PointLight3D = new PointLight3D();
			matList.addMaterial(new FlatShadeMaterial(light,0xffffff,0xcc0000),"all");
			collada = new Collada("assets/CUBE.DAE", matList, .2, true);
			scene.addChild(collada);
			
			addEventListener(Event.ENTER_FRAME, onRenderTick);
		}
		override protected function onRenderTick(event:Event=null):void
		{
			renderer.renderScene(scene,camera,viewport);
			collada.rotationX += 1.3;
			collada.rotationY += 1.7;
		}
	}
}