package core.utils
{
	public class Physics
	{
		public static const DEFAULT_FRICTION:Number = 0.8;
		public static const DEFAULT_SPRING:Number = 0.1;
		public static const DEFAULT_GRAVITY:Number = 5;
		public static const DEFAULT_WIND_RESISTANCE:Number = 0.6;
		public static const DEFAULT_WALK_SPEED:Number = 6;
		public static const DEFAULT_JUMP_SPEED:Number = -25;
		
		public static function spring(value:Number, target:Number, spring:Number = 0.1):Number
		{
			return (target - value) * spring;
		}
		private function springObject(x:Number, y:Number, tx:Number, ty:Number, vx:Number, vy:Number, friction:Number = 0.8):void
		{
			vx += spring(x, tx);
			vy += spring(y, ty);
			vx *= friction;
			vy *= friction;
			x += vx;
			y += vy;
		}
		public static function ease(value:Number, target:Number, ease:Number = 0.2):Number
		{
			return (target - value) * ease;
		}
	}
}