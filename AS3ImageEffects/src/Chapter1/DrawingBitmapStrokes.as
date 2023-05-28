package Chapter1
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class DrawingBitmapStrokes extends Sprite
	{
		public function DrawingBitmapStrokes()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void
		{
			removeEventListener(e.type, init);
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, stageMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, stageMouseUp);
		}
		
		private function createBrushStroke():void
		{
			var radius:uint = 10;//Math.random() * 10 + 2;
			var diameter:uint = 20;//radius * 2;
			var shape:Shape = new Shape();
			shape.graphics.beginFill(Math.random() * 0xFFFFFF);
			shape.graphics.drawCircle(radius, radius, radius);
			shape.graphics.endFill();
			
			var brushStroke:BitmapData = new BitmapData(diameter, diameter, true, 0x00000000);
			brushStroke.draw(shape);
			graphics.lineStyle(diameter);
			graphics.lineBitmapStyle(brushStroke);
		}
		
		private function stageMouseDown(e:MouseEvent):void
		{
			createBrushStroke();
			graphics.moveTo(stage.mouseX, stage.mouseY);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stageMouseMove);
		}
		private function stageMouseMove(e:MouseEvent):void
		{
			graphics.lineTo(stage.mouseX, stage.mouseY);
			e.updateAfterEvent();
		}
		private function stageMouseUp(e:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, stageMouseMove);
		}
	}
}