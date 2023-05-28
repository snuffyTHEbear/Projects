package Chapter1
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class DrawingShapes extends Sprite
	{
		public function DrawingShapes()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void
		{
			removeEventListener(e.type, arguments.callee);
			
			draw();
		}
		private function draw():void
		{
			var halfWidth:Number = stage.stageWidth * 0.5;
			var halfHeight:Number = stage.stageHeight * 0.5;
			var quarterWidth:Number = halfWidth * 0.5;
			var quarterHeight:Number = halfHeight * 0.5;
			
			graphics.beginFill(0xFF0000);
			graphics.drawCircle(quarterWidth, quarterHeight, Math.min(quarterWidth, quarterHeight));
			graphics.endFill();
			
			graphics.beginFill(0x0000FF);
			graphics.drawEllipse(halfWidth, 0, halfWidth, halfHeight);
			graphics.endFill();
			
			graphics.beginFill(0x00FF00);
			graphics.drawRect(0, halfHeight, halfWidth, halfHeight);
			graphics.endFill();
			
			graphics.beginFill(0xFF00FF);
			graphics.drawRoundRect(halfWidth, halfHeight, halfWidth, halfHeight, 70, 70);
			graphics.endFill();
		}
	}
}