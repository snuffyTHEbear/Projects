////////////////////////////////////////////////////////////////////////////////
//   Robert Daniels - http://arctic-code.com 
////////////////////////////////////////////////////////////////////////////////

package springing
{
	import flash.display.DisplayObject;
	public class Springer
	{
		/**
		 * 
		 * @param target
		 * @param springLength
		 * @param spring
		 * 
		 */				
		public function Springer(target:DisplayObject, springLength:Number = 50, spring:Number = 0.1)
		{
			_target = target;
			_springLength = springLength;
			_spring = spring;
			_vx = _vy = 0;
		}

		private var _spring:Number;
		private var _springLength:Number;
		private var _target:DisplayObject;
		private var _vx:Number;
		private var _vy:Number;
		
		public function get spring():Number
		{
			return _spring;
		}

		public function set spring(value:Number):void
		{
			_spring = value;
		}
		
		public function get springLength():Number
		{
			return _springLength;
		}

		public function set springLength(value:Number):void
		{
			_springLength = value;
		}

		/**
		 * 
		 * @param targetX
		 * @param targetY
		 * @param friction
		 * 
		 */			
		public function update(targetX:Number, targetY:Number, friction:Number = 1.0):void
		{
			var dx:Number = _target.x - targetX;
			var dy:Number = _target.y - targetY;
			var angle:Number = Math.atan2(dy, dx);
			var newX:Number = targetX + Math.cos(angle) * _springLength;
			var newY:Number = targetY + Math.sin(angle) * _springLength;
			_vx += (newX - _target.x) * _spring;
			_vy += (newY - _target.y) * _spring;
			_vx *= friction;
			_vy *= friction;
			_target.x += _vx;
			_target.y += _vy;
		}
	}
}