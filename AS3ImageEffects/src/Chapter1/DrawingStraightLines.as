package Chapter1
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class DrawingStraightLines extends Sprite
	{
		private var _color:uint;
		private var _currentShape:Shape;
		private var _startPosition:Point;
		
		public function DrawingStraightLines()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void
		{
			removeEventListener(e.type, arguments.callee);
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, stageMouseDown_Handler);
			stage.addEventListener(MouseEvent.MOUSE_UP, stageMouseUp_Handler);
		}
		private function drawLine():void
		{
			_currentShape.graphics.clear();
			_currentShape.graphics.lineStyle(3, _color);
			_currentShape.graphics.moveTo(_startPosition.x, _startPosition.y);
			_currentShape.graphics.lineTo(stage.mouseX, stage.mouseY);
		}
		private function stageMouseDown_Handler(e:MouseEvent):void
		{
			_color = Math.random() * 0xFFFFFF;
			_currentShape = new Shape();
			addChild(_currentShape);
			_startPosition = new Point(stage.mouseX, stage.mouseY);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stageMouseMove_Handler);
		}
		
		private function stageMouseUp_Handler(e:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, stageMouseMove_Handler);
		}
		private function stageMouseMove_Handler(e:MouseEvent):void
		{
			drawLine();
			e.updateAfterEvent();
		}
	}
}