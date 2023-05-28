package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.render.BasicRenderEngine;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.Viewport3D;
	
	[SWF(width=640,height=480,frameRate=30,backgroundColor=0x000000)]
	public class ColladaTutorial extends Sprite
	{
		private var scene:Scene3D;
		private var vp:Viewport3D;
		private var cam:Camera3D;
		private var bre:BasicRenderEngine;
		
		public function ColladaTutorial()
		{
			setUpPV3D();
			addEventListener(Event.ENTER_FRAME, loop);
		}
		private function setUpPV3D():void
		{
			scene = new Scene3D();
			cam = new Camera3D();
			vp = new Viewport3D();
			bre = new BasicRenderEngine();
			addChild(vp);
		}
		private function loop(e:Event):void
		{
			bre.renderScene(scene,cam,vp);
		}
	}
}