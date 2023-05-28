package org.fly3D.geom
{
	
	public class Light
	{
		public var x:Number;
		public var y:Number;
		public var z:Number;
		private var _brightness:Number;
		private var _color:uint;
		
		public function Light(x:Number = -100, y:Number = -100, z:Number = -100, brightness:Number = 1, color:uint = 0xFFFFFF)
		{
			this.x = x;
			this.y = y;
			this.z = z;
			this.brightness = brightness;
		}
		
		public function get brightness():Number
		{
			return _brightness;
		}
		
		public function set brightness(value:Number):void
		{
			_brightness = Math.min(Math.max(value, 0), 1);
		}
		
		public function move(x:Number, y:Number, z:Number):void
		{
			this.x = x;
			this.y = y;
			this.z = z;
		}
		
		public function get color():uint
		{
			return _color;
		}
		
		public function set color(value:uint):void
		{
			_color = value;
		}
	
	}
}