package com.display
{
	import flash.display.Sprite;
	/**
	 * 
	 * @author Robert Daniels
	 * Creates a simple circle with modifyable properties
	 */	
	public class Circle extends Sprite
	{
		private var _radius:Number;
		private var _colour:uint;
		
		/**
		 * 
		 * @param colour: <code>uint</code> for colour
		 * @param radius: <code>Number</code> for radius
		 * 
		 */		
		public function Circle(colour:uint = 0xcc0000, radius:Number = 30)
		{
			_colour = colour;
			_radius = radius;
			draw();
		}
		
		/**
		 *Redraws the circle 
		 * 
		 */		
		private function draw():void
		{
			graphics.clear();
			graphics.beginFill(_colour);
			graphics.drawCircle(0, 0, _radius);
			graphics.endFill();
		}
		
		/**
		 * 
		 * @return <code>uint</code> returns the colour of the circle
		 * 
		 */		
		public function get colour():uint
		{
			return _colour;
		}
		
		/**
		 * 
		 * @param v: <code>uint</code> sets the colour of the circle
		 * 
		 */		
		public function set colour(v:uint):void
		{
			_colour = v;
			draw();
		}
		
		/**
		 * 
		 * @return: <code>Number</code> returns the radius of the circle 
		 * 
		 */		
		public function get radius():Number
		{
			return _radius;
		}
		
		/**
		 * 
		 * @param v: <code>Number</code> sets the radius of the circle
		 * 
		 */		
		public function set radius(v:Number):void
		{
			_radius = v;
			draw();
		}
		
		public function move(x:Number, y:Number):void
		{
			super.x = x;
			super.y = y;
		}
	}
}