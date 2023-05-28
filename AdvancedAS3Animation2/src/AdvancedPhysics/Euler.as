package AdvancedPhysics
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	public class Euler extends Sprite
	{
		private var _ball:Sprite;
		private var _position:Point;
		private var _velocity:Point;
		private var _gravity:Number = 32;
		private var _bounce:Number = -0.6;
		private var _oldTime:int;
		private var _pixelsPerFoot:Number = 100;
		
		public function Euler()
		{
			init();
		}
		private function init():void
		{
			_ball = new Sprite();
			_ball.graphics.beginFill(0xff0000);
			_ball.graphics.drawCircle(0, 0, 20);
			_ball.graphics.endFill();
			_ball.x = 50;
			_ball.y = 50;
			addChild(_ball);
			
			_velocity = new Point(10, 0);
			_position = new Point(_ball.x / _pixelsPerFoot
									, _ball.y / _pixelsPerFoot);
			
			_oldTime = getTimer();
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			var time:int = getTimer();
			var elapsed:Number = (time - _oldTime) / 1000;
			_oldTime = time;
			
			var accel:Point = acceleration(_position, _velocity);
			_position.x += _velocity.x * elapsed;
			_position.y += _velocity.y * elapsed;
			_velocity.x += accel.x * elapsed;
			_velocity.y += accel.y * elapsed;
			
			//Boundries
			if(_position.y > (stage.stageHeight - 20) / _pixelsPerFoot)
			{
				_position.y = (stage.stageHeight - 20) / _pixelsPerFoot;
				_velocity.y *= _bounce;
			}
			if(_position.x > (stage.stageWidth - 20) / _pixelsPerFoot)
			{
				_position.x = (stage.stageWidth - 20) / _pixelsPerFoot;
				_velocity.x *= _bounce;
			}
			else if(_position.x < 20 / _pixelsPerFoot)
			{
				_position.x = 20 / _pixelsPerFoot;
				_velocity.x *= _bounce;
			}
			
			//Set the position of the ball
			_ball.x = _position.x * _pixelsPerFoot;
			_ball.y = _position.y * _pixelsPerFoot;
		}
		
		private function acceleration(p:Point, v:Point):Point
		{
			return new Point(0, _gravity);
		}
	}
}