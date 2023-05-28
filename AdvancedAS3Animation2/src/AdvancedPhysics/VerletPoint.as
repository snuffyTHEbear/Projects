package AdvancedPhysics
{
	import flash.display.Graphics;
	import flash.geom.Rectangle;

	public class VerletPoint
	{
		public var x:Number;
		public var y:Number;
		
		public var val:Number = 5;
		private var inc:Boolean = true;
		
		private var _oldX:Number;
		private var _oldY:Number;
		
		private var _type:String;
		
		public static const LOCKED:String = "locked";
		public static const FREE:String = "free";
		
		public function VerletPoint(x:Number, y:Number, type:String = VerletPoint.FREE)
		{
			setPosition(x, y);
			_type = type;
		}

		public function get type():String
		{
			return _type;
		}

		public function set type(v:String):void
		{
			_type = v;
		}

		public function update():void
		{
			var tempX:Number = x;
			var tempY:Number = y;
			//trace(Math.abs(vx) < 0.05 && Math.abs(vy) < 0.05)
			/*if(Math.abs(vx) > 0.05)*/x += vx;
			/*if(Math.abs(vy) > 0.05)*/y += vy;
			_oldX = tempX;
			_oldY = tempY;
		}
		public function setPosition(x:Number, y:Number):void
		{
			this.x = _oldX = x;
			this.y = _oldY = y;
		}
		public function constrain(rect:Rectangle):void
		{
			x = Math.max(rect.left, Math.min(rect.right, x));
			y = Math.max(rect.top, Math.min(rect.bottom, y));
		}
		public function set vx(value:Number):void
		{
			_oldX = x - value;
		}
		public function get vx():Number
		{
			return x - _oldX;
		}
		public function set vy(value:Number):void
		{
			_oldY = y - value;
		}
		public function get vy():Number
		{
			return y - _oldY;
		}
		public function render(g:Graphics):void
		{
			if(val == 255){val = 255;inc = false;}else if(val == 0){val = 0;inc = true;}
			inc ? val++ : val--;
			g.beginFill(0);
			g.drawCircle(x, y, 1);
			g.endFill();
		}
	}
}