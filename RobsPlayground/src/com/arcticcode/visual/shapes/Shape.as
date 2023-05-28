/*==============================================*/
/*   Sasori Daniels - http://arctic-code.com    */
/*==============================================*/
package com.arcticcode.visual.shapes
{
	import flash.display.Graphics;
	import flash.display.Sprite;

	public class Shape extends Sprite
	{
		public function Shape()
		{
			_num = 10;
			g = super.graphics;
			draw();
		}
		public var _object:Object = {};
		public var colour:uint = 0xFFFFFF;
		private var _num:Number;
		private var g:Graphics;

		public function draw():void
		{
			g.clear();
			g.beginFill(colour);
			if (_num < 20)
			{
				g.drawCircle(0, 0, 3);
			}
			else if (_num > 20 && _num < 30)
			{
				g.drawRoundRect(-2, -3, 4, 5, 4, 4);
			}
			else if (_num > 30 && _num < 40)
			{
				g.drawRoundRect(-5, -2.5, 7, 5, 5, 5);
			}
			else if (_num > 40 && _num < 60)
			{
				g.drawRect(-2, -2, 4, 4);
			}
			else if (_num > 60 && _num < 80)
			{
				g.moveTo(-5, -5);
				g.lineTo(5, -5);
				g.lineTo(5, 5);
				g.lineTo(-5, -5);
			}
			g.endFill();
		}
	}
}
