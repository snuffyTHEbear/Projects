package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	
	public class Velocity1 extends Sprite
	{
		private var ball:CreateCircle;
		private var vx:Number = 5;
		private var vy:Number = 5;
		
		public function Velocity1()
		{
			init();
		}
		private function init():void{
			ball = new CreateCircle(0x4356ff);
			addChild(ball);
			ball.x = 50;
			ball.y = 100;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void{
			ball.x += vx;
			ball.y += vy;
		}

	}
}