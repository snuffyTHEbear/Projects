package core.geom
{
	import core.characters.Character;
	
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	
	public class Bounds extends EventDispatcher
	{
		private var _bounds:Rectangle;
		
		public function Bounds(bounds:Rectangle)
		{
			_bounds = bounds;
		}
		public function get bounds():Rectangle
		{
			return _bounds;
		}
		public function set bounds(val:Rectangle):void
		{
			_bounds = val;
		}
		public function checkBoundsBounce(object:Character,velocity:Object):void
		{
			if(object.x > _bounds.right - object.width/2)
			{
				object.x = _bounds.right - object.width/2;
				object.velX = 0;
			}
			else if(object.x < _bounds.left + object.width/2)
			{
				object.x = _bounds.left + object.width/2;
				object.velX = 0;
			}
			if(object.y > _bounds.bottom)
			{
				object.y = _bounds.bottom;
				velocity.vy *= -1;
			}
			else if(object.y < _bounds.top + object.height)
			{
				object.y = _bounds.top + object.height;
				velocity.vy *= -1;
			}
		}
	}
}