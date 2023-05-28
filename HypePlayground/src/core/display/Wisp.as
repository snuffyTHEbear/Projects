package core.display
{
	import flash.display.Sprite;
	
	public class Wisp extends Sprite
	{
		public function Wisp(fillColour:uint = 0xFFFFFF, fillAlpha:Number = 1.0, radius:Number = 5)
		{
			graphics.beginFill(fillColour, fillAlpha);
			graphics.drawCircle(0, 0, radius);
			graphics.endFill();
		}
	}
}