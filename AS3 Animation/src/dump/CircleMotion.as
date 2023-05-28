package{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	
	public class CircleMotion extends Sprite{
		
		private var ball:CreateCircle;
		private var angle:Number = 0;
		private var centerX:Number = 200;
		private var centerY:Number = 200;
		private var radius:Number = 30;
		private var speed:Number = .1;
		
		public function CircleMotion(){
			init();
		}
		private function init():void{
			ball = new CreateCircle(0xFF6600);
			addChild(ball);
			ball.x = 0;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		public function onEnterFrame(event:Event):void{
			ball.x = centerX + Math.sin(angle) * radius;
			ball.y = centerY + Math.cos(angle) * radius;
			angle += speed;
		}
	}
}