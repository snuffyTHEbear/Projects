package{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	
	public class Acceleration2 extends Sprite{
		
		private var ball:CreateCircle;
		private var gravity:Number = 0.01;
		private var vx:Number = 0;
		private var vy:Number = 0;
		private var ax:Number = 0;
		private var ay:Number = 0;
		
		public function Acceleration2(){
			init();
		}
		private function init():void{
			ball = new CreateCircle();
			addChild(ball);
			ball.x = stage.stageWidth / 2;
			ball.y = stage.stageHeight / 2;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		private function onKeyDown(event:KeyboardEvent):void{
			switch(event.keyCode)
			{
				case Keyboard.LEFT:
				ax = -0.2;
				break;
				
				case Keyboard.RIGHT:
				ax = 0.2;
				break;
				
				case Keyboard.UP:
				ay = -0.2;
				break;
				
				case Keyboard.DOWN:
				ay = 0.2;
				break;
				
				default:
				break;
			}
		}
		private function onKeyUp(event:KeyboardEvent):void{
			ax = 0;
			ay = 0;
		}
		private function onEnterFrame(event:Event):void{
			vx += ax;
			vy += ay;
			vy += gravity;
			ball.x += vx;
			ball.y += vy;
		}
	}
}