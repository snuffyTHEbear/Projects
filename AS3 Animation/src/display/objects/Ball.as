package display.objects
{
	import flash.display.Sprite;
	
	public class Ball extends Sprite
	{
		private var _vx:Number = 0;
		private var _vy:Number = 0;
		private var _isDragging:Boolean = false;
		private var _radius:Number;
		public function Ball(radius:Number = 30)
		{
			_radius = radius;
			draw();
		}
		
		private function draw():void
		{
			graphics.beginFill(0);
			graphics.drawCircle(0,0,_radius);
			graphics.endFill();
		}
		
		public function get radius():Number
		{
			return _radius;
		}

		public function set radius(value:Number):void
		{
			_radius = value;
		}

		public function get isDragging():Boolean
		{
			return _isDragging;
		}

		public function set isDragging(value:Boolean):void
		{
			_isDragging = value;
		}

		public function move(x:Number, y:Number):void
		{
			this.y = y;
			this.x = x;
		}
		
		public function applyVelocity():void
		{
			this.x += _vx;
			this.y += _vy;
		}

		public function get vy():Number
		{
			return _vy;
		}

		public function set vy(value:Number):void
		{
			_vy = value;
		}

		public function get vx():Number
		{
			return _vx;
		}

		public function set vx(value:Number):void
		{
			_vx = value;
		}

	}
}