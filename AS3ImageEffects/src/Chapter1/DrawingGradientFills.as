package Chapter1
{
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	
	public class DrawingGradientFills extends Sprite
	{
		private var _angle:Number = 0;
		
		public function DrawingGradientFills()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			drawBackground();
		}
		
		private function drawBackground():void
		{
			var colors:Array = [0xFFFF00, 0xFF0000, 0x000000];
			var alphas:Array = [0.3, 0.5, 1.0];
			var ratios:Array = [50, 100, 255];
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(200, 200, 0, stage.mouseX - 100, stage.mouseY - 100);
			graphics.clear();
			graphics.beginGradientFill(GradientType.RADIAL, colors, alphas, ratios, matrix, SpreadMethod.PAD);
			graphics.lineTo(stage.stageWidth, 0);
			graphics.lineTo(stage.stageWidth, stage.stageHeight);
			graphics.lineTo(0, stage.stageHeight);
			graphics.lineTo(0, 0);
			graphics.endFill();
		}
		private function mouseMove(e:MouseEvent):void
		{
			e.updateAfterEvent();
			drawBackground();
		}
	}
}