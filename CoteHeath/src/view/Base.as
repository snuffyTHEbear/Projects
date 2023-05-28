package view
{
	import flash.events.Event;
	
	import org.papervision3d.view.BasicView;
	
	public class Base extends BasicView
	{
		private var _renderCallback:Function;
		
		public function Base(viewportWidth:Number=640, viewportHeight:Number=480, scaleToStage:Boolean=true, interactive:Boolean=false, cameraType:String="Target")
		{
			super(viewportWidth, viewportHeight, scaleToStage, interactive, cameraType);
			
			init();
		}
		private function init():void
		{			
			startRendering();
		}
		override protected function onRenderTick(event:Event=null) : void
		{			
			if(_renderCallback != null)_renderCallback();
			renderer.renderScene(scene, camera, viewport);
		}
		public function addModel(model:BasicPrimitive):void
		{
			scene.addChild(model);
		}

		public function set renderCallback(value:Function):void
		{
			_renderCallback = value;
		}

	}
}