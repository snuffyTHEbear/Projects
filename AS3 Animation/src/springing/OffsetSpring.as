package springing
{
	import display.objects.Ball;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class OffsetSpring extends Sprite
	{
		private var _ball:Ball;
		private var _spring:Number = 0.1;
		private var _friction:Number = 0.95;
		private var _springLength:Number = 100;
		
		public function OffsetSpring()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(e.type, init);
			
			_ball = new Ball(20);
			addChild(_ball);
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void
		{
			springTo(_ball, mouseX, mouseY, _springLength);
		}
		
		private function springTo(ballA:Ball, targetX:Number, targetY:Number, springLength:Number):void
		{
			var dx:Number = ballA.x - targetX;
			var dy:Number = ballA.y - targetY;
			var angle:Number = Math.atan2(dy, dx);
			var newX:Number = targetX + Math.cos(angle) * springLength;
			var newY:Number = targetY + Math.sin(angle) * springLength;
			ballA.vx += (newX - ballA.x) * _spring;
			ballA.vy += (newY - ballA.y) * _spring;
			_ball.vx *= _friction;
			_ball.vy *= _friction;
			ballA.applyVelocity();
		}
	}
}