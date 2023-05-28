package Chapter1
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	[SWF(width = 640, height = 480)]
	public class DrawingCurves extends Sprite
	{
		private var _controlPoint:Sprite;
		private var _anchor0:Sprite;
		private var _anchor1:Sprite;
		
		public function DrawingCurves()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_anchor0 = addControlPoint(50, 300);
			_anchor1 = addControlPoint(500, 300);
			_controlPoint = addControlPoint(275, 100);
			drawCurve();
		}
		private function addControlPoint(x:Number, y:Number):Sprite
		{
			var controlPoint:Sprite = new Sprite();
			controlPoint.graphics.lineStyle(20);
			controlPoint.graphics.lineTo(1, 0);
			controlPoint.addEventListener(MouseEvent.MOUSE_DOWN, controlDown);
			controlPoint.addEventListener(MouseEvent.MOUSE_UP, controlUp);
			controlPoint.buttonMode = true;
			controlPoint.x = x;
			controlPoint.y = y;
			addChild(controlPoint);
			return controlPoint;
		}
		private function drawCurve():void
		{
			graphics.clear();graphics.lineStyle(3, 0xFF);graphics.moveTo(_anchor0.x, _anchor0.y);
			graphics.curveTo(_controlPoint.x, _controlPoint.y, _anchor1.x, _anchor1.y);
			graphics.lineStyle(1, 0, 0.5);
			graphics.lineTo(_controlPoint.x, _controlPoint.y);
			graphics.lineTo(_anchor0.x, _anchor0.y);
		}
		private function controlDown(e:MouseEvent):void{e.target.startDrag(); stage.addEventListener(MouseEvent.MOUSE_MOVE, controlMove);}
		private function controlUp(e:MouseEvent):void{e.target.stopDrag(); stage.removeEventListener(MouseEvent.MOUSE_MOVE, controlMove);}
		private function controlMove(e:MouseEvent):void{drawCurve(); e.updateAfterEvent();}
	}
}