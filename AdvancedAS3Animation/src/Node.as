package
{
	public class Node
	{
		private var _x:int;
		private var _y:int;
		private var _f:Number;
		private var _g:Number;
		private var _h:Number;
		private var _walkable:Boolean = true;
		private var _parent:Node;
		private var _costMultiplier:Number = 1.0;
		
		public function Node(x:int, y:int)
		{
			_x = x;
			_y = y;
		}
		public function get x():int
		{
			return _x;
		}
		public function set x(val:int):void
		{
			_x = val;
		}
		public function get y():int
		{
			return _y;
		}
		public function set y(val:int):void
		{
			_y = val;
		}
		public function get f():Number
		{
			return _f;
		}
		public function set f(val:Number):void
		{
			_f = val;
		}
		public function get g():Number
		{
			return _g;
		}
		public function set g(val:Number):void
		{
			_g = val;
		}
		public function get h():Number
		{
			return _h;
		}
		public function set h(val:Number):void
		{
			_h = val;
		}
		public function set walkable(val:Boolean):void
		{
			_walkable = val;
		}
		public function get walkable():Boolean
		{
			return _walkable;
		}
		public function set parent(val:Node):void
		{
			_parent = val;
		}
		public function get parent():Node
		{
			return _parent;
		}
		public function get costMultiplier():Number
		{
			return _costMultiplier;
		}
		public function set costMultiplier(val:Number):void
		{
			_costMultiplier = val;
		}
	}
}