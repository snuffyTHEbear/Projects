package core.player.human
{
	import flash.display.MovieClip;
	
	public class PixelChar extends MovieClip
	{
		public static const STAND:String = "stand";
		public static const WALK:String = "walk";
		public static const JUMP:String = "jump";
		public static const LAND:String = "land";
		public static const EAT:String = "eat";
		public static const EXPLODE:String = "explode";
		public static const BLEND:String = "blend";
		
		private var _frame:String = "";
		private var _jumping:Boolean = false;
		private var _vx:Number = 0;
		private var _vy:Number = 0;
		private var _floorY:Number = 0;
		
		public function PixelChar()
		{
			super();
		}
		
		public function set frame(label:String):void
		{
			_frame = label;
			if(_frame == JUMP)
			{
				_jumping = true;
			}
			this.gotoAndPlay(_frame);
		}
		
		public function get frame():String
		{
			return _frame;
		}
		
		public function move(x:Number, y:Number):void
		{
			super.x = x;
			super.y = y;
		}
		public function applyGravity(g:Number, reverse:Boolean = false):void
		{
			reverse ? vy -= g : vy += g;
		}
		public function applyFriction(f:Number):void
		{
			vx *= f;
			vy *= f;
		}
		
		public function applyVelocity():void
		{
			x += _vx;
			y += _vy;
		}
		
		public function get vy():Number
		{
			return _vy;
		}
		
		public function set vy(v:Number):void
		{
			_vy = v;
		}
		
		public function get vx():Number
		{
			return _vx;
		}
		
		public function set vx(v:Number):void
		{
			_vx = v;
		}

		public function get jumping():Boolean
		{
			return _jumping;
		}

		public function set jumping(value:Boolean):void
		{
			_jumping = value;
		}

		public function get floorY():Number
		{
			return _floorY;
		}

		public function set floorY(value:Number):void
		{
			_floorY = value;
		}
	}
}