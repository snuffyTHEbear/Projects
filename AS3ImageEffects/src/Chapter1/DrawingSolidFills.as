package Chapter1
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class DrawingSolidFills extends Sprite
	{
		public function DrawingSolidFills()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void
		{
			removeEventListener(e.type, arguments.callee);
			
			stage.addEventListener(MouseEvent.CLICK, stageMouseClick_Handler);
		}
		private function drawBackground():void
		{
			graphics.clear();
			graphics.beginFill(Math.random() * 0xFFFFFF);
			graphics.lineTo(stage.stageWidth, 0);
			graphics.lineTo(stage.stageWidth, stage.stageHeight);
			graphics.lineTo(0, stage.stageHeight);
			graphics.lineTo(0, 0);
			graphics.endFill();
		}
		private function stageMouseClick_Handler(e:MouseEvent):void
		{
			drawBackground();
		}
	}
}