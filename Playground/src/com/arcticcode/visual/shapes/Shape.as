package com.arcticcode.visual.shapes
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	public class Shape extends Sprite
	{
		private var g:Graphics;
		
		public var _object:Object = {};
		
		public var colour:uint = 0xFFFFFF;
		
		public function Shape()
		{
			g = super.graphics;
			draw();
		}
		
		public function draw():void
		{
			g.clear();
			g.beginFill(colour);
			//g.drawRoundRect(-5, -2.5, 7, 5, 5, 5);
			//g.drawRoundRect(-2, -3, 4, 5, 4, 4);
			g.drawCircle(0, 0, 3);
			//g.drawRect(-2, -2, 4, 4);
			g.endFill();
		}
	}
}