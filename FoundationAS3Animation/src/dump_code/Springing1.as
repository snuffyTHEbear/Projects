package{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	
	public class Springing1 extends Sprite{
		
		private var ball:CreateCircle;
		private var spring:Number = 0.1;
		private var targetX:Number = stage.stageWidth / 2;
		private var targetY:Number = stage.stageHeight / 2;
		private var vx:Number = 0;
		private var vy:Number = 0;
		private var gravity:Number = 5;
		private var friction:Number = 0.95;
		
		public function Springing1(){
			init();
		}
		private function init():void{
			ball = new CreateCircle();
			addChild(ball);
			ball.y = stage.stageHeight / 2;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		private function onMouseDown(event:MouseEvent):void{
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			ball.startDrag();
		}
		private function onMouseUp(event:MouseEvent):void{
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			ball.stopDrag();
			addEventListener(Event.ENTER_FRAME, onEnterFrame);	
		}
		private function onEnterFrame(event:Event):void{
			//var dx:Number = targetX - ball.x;
			//var dy:Number = targetY - ball.y;
			var dx:Number = mouseX - ball.x;
			var dy:Number = mouseY - ball.y;
			var ax:Number = dx * spring;
			var ay:Number = dy * spring;
			vx += ax;
			vy += ay;
			vy += gravity;
			vx *= friction;
			vy *= friction;
			ball.x += vx;
			ball.y += vy;
			graphics.clear();
			graphics.lineStyle(1, 0x000000);
			graphics.moveTo(ball.x, ball.y);
			graphics.lineTo(mouseX, mouseY);
		}
	}
}