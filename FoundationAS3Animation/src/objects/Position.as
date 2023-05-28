package objects
{
	public class Position
	{
		private var _x:Number;
		private var _y:Number;
		
		public function Position(x:Number = 0, y:Number = 0)
		{
			_x = x;
			_y = y;
		}

		public function get y():Number
		{
			return _y;
		}

		public function set y(v:Number):void
		{
			_y = v;
		}

		public function get x():Number
		{
			return _x;
		}

		public function set x(v:Number):void
		{
			_x = v;
		}

	}
}