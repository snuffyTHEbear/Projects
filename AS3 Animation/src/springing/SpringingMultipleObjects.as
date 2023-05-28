package springing
{
	import display.objects.Ball;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class SpringingMultipleObjects extends Sprite
	{
		private var _balls:Vector.<Ball> = new Vector.<Ball>();
		private var _spring:Number = 0.1;
		private var _targetX:Number;
		private var _targetY:Number;
		private var _vx:Number = 0;
		private var _vy:Number = 0;
		private var _friction:Number = 0.8;
		private var _numBalls:uint = 5;
		private var _gravity:Number = 5;
		
		public function SpringingMultipleObjects()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(e.type, init);
			
			var i:uint = 0;
			for(i = 0; i < _numBalls; i++)
			{
				var b:Ball = new Ball(20);
				addChild(b);
				_balls.push(b);
			}
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void
		{
			var i:uint = 0;
			springToTarget(_balls[0], mouseX, mouseY);
			graphics.clear();
			graphics.lineStyle(0);
			graphics.moveTo(_balls[0].x, _balls[i].y);
			for(i = 1; i < _numBalls; i++)
			{
				springToTarget(_balls[i], _balls[i - 1].x, _balls[i - 1].y);
				graphics.lineTo(_balls[i].x, _balls[i].y);
			}
		}
		
		private function springToTarget(obj:Ball, targetX:Number, targetY:Number):void
		{
			var dx:Number = targetX - obj.x;
			var dy:Number = targetY - obj.y;
			var ax:Number = dx * _spring;
			var ay:Number = dy * _spring;
			obj.vx += ax;
			obj.vy += ay;
			obj.vy += _gravity;
			obj.vx *= _friction;
			obj.vy *= _friction;
			obj.x += obj.vx;
			obj.y += obj.vy;
		}
	}
}