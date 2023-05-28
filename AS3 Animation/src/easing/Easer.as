package easing
{
	import flash.display.DisplayObject;

	public class Easer
	{
		private var _target:DisplayObject;
		private var _ease:Number;
		private var _vx:Number;
		private var _vy:Number;
		
		public function Easer(target:DisplayObject, ease:Number = 0.2)
		{
			_target = target;
			_ease = ease;
			_vx = _vy = 0;
		}
		
		public function update(targetX:Number, targetY:Number):void
		{
			var dx:Number = targetX - _target.x;
			var dy:Number = targetY - _target.y;
			_vx = dx * _ease;
			_vy = dy * _ease;
			_target.x += _vx;
			_target.y += _vy;
		}
	}
}