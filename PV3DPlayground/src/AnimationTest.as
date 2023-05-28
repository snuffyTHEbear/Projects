package 
{
	import flash.events.Event;
	
	import org.papervision3d.materials.BitmapFileMaterial;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.parsers.DAE;
	import org.papervision3d.objects.parsers.MD2;
	import org.papervision3d.view.BasicView;

	[SWF(backgroundColor="0x000000", frameRate="24")]
	
	public class AnimationTest extends BasicView
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;	
		private var material:BitmapFileMaterial;
		private var animated_md2:MD2;
		private var animated_dae:DAE;
		
		public function AnimationTest()
		{
			init();
		}
		
		private function init():void
		{
			camera.zoom = 60;
			
			var wireMat:WireframeMaterial = new WireframeMaterial();
			animated_md2 = new MD2(true);
			animated_md2.load("MD2_Animations/Anim_test.md2",wireMat,24,3);
			scene.addChild(animated_md2);
			
			/* var mats:MaterialsList = new MaterialsList();
			mats.addMaterial(wireMat, "all");
			animated_dae = new DAE(true,"",true);
			animated_dae.load("MD2_Animations/Anim_test.DAE",mats);
			scene.addChild(animated_dae); */
			
			addEventListener(Event.ENTER_FRAME, onRenderTick);
		}
		
		override protected function onRenderTick(event:Event=null):void
		{
			renderer.renderScene(scene,camera,viewport);
			
			animated_md2.rotationX -= (centreY - mouseY) * 0.01;
			//animated_dae.rotationY += (centreX - mouseX) * 0.005;
		}
	}
}
