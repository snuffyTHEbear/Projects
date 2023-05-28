package
{
	import flash.events.Event;
	
	import org.papervision3d.materials.BitmapFileMaterial;
	import org.papervision3d.objects.parsers.MD2;
	import org.papervision3d.objects.primitives.Sphere;
	import org.papervision3d.view.BasicView;
	
	[SWF(width=640,height=600,backgroundColor=0x000000,frameRate=30)]
	public class MD2Test extends BasicView
	{
		private var houseText:BitmapFileMaterial;
		private var houseMD2:MD2;
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;	
		
		public function MD2Test()
		{
			super(640,600,true,true);
			init();
		}
		private function init():void
		{
			camera.zoom = 60;
			
			houseText = new BitmapFileMaterial("MD2House/house_texture.jpg",true);
			houseMD2 = new MD2(false);
			houseMD2.name = "house";
			houseMD2.load("MD2House/quakeHouse.md2",houseText,24,3);
			scene.addChild(houseMD2);
			houseMD2.rotationX = -180;
			/* var sphere:Sphere = new Sphere(houseText,350,12,24);
			sphere.name = "sphere";
			scene.addChild(sphere); */
			
			addEventListener(Event.ENTER_FRAME, onRenderTick);
		}
		override protected function onRenderTick(event:Event=null):void
		{
			super.onRenderTick(event);
			scene.getChildByName("house").rotationX += (centreY - mouseY) * 0.01;
			scene.getChildByName("house").rotationY += (centreX - mouseX) * 0.01;
		}
	}
}