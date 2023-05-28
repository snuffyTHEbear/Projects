package Chapter1
{
	import flash.display.CapsStyle;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public class DrawingGradientLines extends Sprite
	{
		private var _color:uint;
		private var _currentShape:Shape;
		private var _startPosition:Point;
		
		public function DrawingGradientLines()
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
			var thickness:Number = 40;
			var colors:Array = [_color, _color];
			var alphas:Array = [1, 0];
			var ratios:Array = [127, 127];
			
			var currentPosition:Point = new Point(stage.mouseX, stage.mouseY);
			var xDist:Number = (currentPosition.x - _startPosition.x);
			var yDist:Number = (currentPosition.y - _startPosition.y);
			var angle:Number = Math.atan2(yDist, xDist);
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(thickness, thickness, angle);
			_currentShape.graphics.clear();
			_currentShape.graphics.lineStyle(thickness, 0, 1, false, null, CapsStyle.SQUARE);
			_currentShape.graphics.lineGradientStyle(GradientType.LINEAR, colors, alphas, ratios, matrix, SpreadMethod.REPEAT);
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