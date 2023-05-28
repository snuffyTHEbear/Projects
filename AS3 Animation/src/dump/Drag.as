package{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	
	public class Drag extends Sprite{
		private var ball:CreateCircle;
		public function Drag(){
			init();
		}
		private function init():void{
			ball = new CreateCircle();
			ball.x = 100;
			ball.y = 100;
			addChild(ball);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		private function onMouseDown(eent:MouseEvent):void{
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			//ball.startDrag();
			ball.startDrag(false, new Rectangle(100, 100, 300, 300));
		}
		private function onMouseUp(event:MouseEvent):void{
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			ball.stopDrag();
		}
	}
}