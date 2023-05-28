package 
{
	import flash.events.Event;
	
	import org.papervision3d.lights.PointLight3D;
	import org.papervision3d.materials.shadematerials.FlatShadeMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.view.BasicView;
	
	[SWF(width=640, height = 480)]
	public class PVHypeCorona extends BasicView
	{
		private var w:Number = stage.stageWidth;
		
		private var h:Number = stage.stageHeight;
		
		private var centreX:Number = w * 0.5;
		
		private var centreY:Number = h * 0.5;
		
		private var _coronaContainer:DisplayObject3D;
		
		private var _defaultMat:FlatShadeMaterial;
		
		private var _light:PointLight3D;
		
		public function PVHypeCorona()
		{
			super(w, h, true, false);
			
			init();
		}
		
		private function init():void
		{
			_light = new PointLight3D();
			_defaultMat = new FlatShadeMaterial(_light);
			_coronaContainer = new DisplayObject3D("cont");
			scene.addChild(_coronaContainer);
		}
		
		private function createCorona():void
		{
		
		}
		
		override protected function onRenderTick(event:Event = null):void
		{
			renderer.renderScene(scene, camera, viewport);
		}
	}
}