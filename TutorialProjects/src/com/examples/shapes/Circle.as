package com.examples.shapes
{
	import flash.display.Shape;

	public class Circle extends Shape
	{
		private var _color:uint;
		
		public function Circle(color:uint=0x000000)
		{
			_color = color;
			draw();
		}
		public function draw():void
		{
			this.graphics.clear();
			this.graphics.beginFill(_color, 1);
			this.graphics.drawCircle(0, 0, 30);
			this.graphics.endFill();
		}
		public function get color():uint
		{
			return _color; 
		}
		public function set color(val:uint):void
		{
			_color = val;
		}
	}
}