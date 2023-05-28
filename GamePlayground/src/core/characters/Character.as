package core.characters
{
	import flash.display.Sprite;
	
	public class Character extends Sprite
	{
		private var _velX:Number;
		private var _velY:Number;
		private var _maxSpeed:Number = 7;
		private var _speed:Number = 1;
		
		public function Character()
		{
		}
		public function move(x:Number, y:Number):void
		{
			super.x = x;
			super.y = y;
		}
		public function get velX():Number
		{
			return _velX;
		}
		public function set velX(val:Number):void
		{
			_velX = val;
		}
		public function get velY():Number
		{
			return _velY;
		}
		public function set velY(val:Number):void
		{
			_velY = val;
		}
		public function get speed():Number
		{
			return _speed;
		}
		public function set speed(val:Number):void
		{
			_speed = val;
		}
		public function get maxSpeed():Number
		{
			return _maxSpeed;
		}
		public function set maxSpeed(val:Number):void
		{
			_maxSpeed = val;
		}
	}
}