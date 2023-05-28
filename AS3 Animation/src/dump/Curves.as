package{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Curves extends Sprite{
		//Start Points 'moveTo'
		private var x0:Number = 0;
		private var y0:Number = 200;
		//Control points
		private var x1:Number;
		private var y1:Number;
		//End points
		private var x2:Number = 500;
		private var y2:Number = 200;
		
		public function Curves(){
			init();
		}
		private function init():void{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		private function onMouseMove(event:MouseEvent):void{
			/*Curving half way to the control point
			x1 = mouseX;
			y1 = mouseY;
			*/
			//Curving through the control point
			x1 = mouseX * 2 - (x0 + x2) / 2;
			y1 = mouseY * 2 - (y0 + y2) / 2;
			trace(y1);
			graphics.clear();
			graphics.lineStyle(1);
			graphics.moveTo(x0, y0);
			graphics.curveTo(x1, y1, x2, y2);
		}
	}
}