package{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	
	public class MouseMoveDrag extends Sprite{
		
		private var ball:CreateCircle;
		
		public function MouseMoveDrag(){
			init();
		}
		private function init():void{
			ball = new CreateCircle();
			ball.x = 100;
			ball.y = 100;
			addChild(ball);
			ball.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		private function onMouseDown(event:MouseEvent):void{
			stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
		}
		private function onStageMouseMove(event:MouseEvent):void{
			ball.x = mouseX;
			ball.y = mouseY;
		}
		private function onStageMouseUp(event:MouseEvent):void{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
		}
	}
}