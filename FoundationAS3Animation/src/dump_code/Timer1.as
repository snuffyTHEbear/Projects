package{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	
	public class Timer1 extends Sprite{
		private var ball:CreateCircle;
		private var timer:Timer;
		public function Timer1(){
			init();
		}
		private function init():void{
			stage.frameRate = 10;
			ball = new CreateCircle();
			ball.y = stage.stageHeight / 2;
			ball.vx = 1;
			addChild(ball);
			timer = new Timer(20);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
		}
		private function onTimer(event:TimerEvent):void
		{
			ball.x += ball.vx;
			event.updateAfterEvent();
		}
	}
}