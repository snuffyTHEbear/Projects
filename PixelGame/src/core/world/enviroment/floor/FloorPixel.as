package core.world.enviroment.floor
{
	import flash.display.MovieClip;
	
	public class FloorPixel extends MovieClip
	{
		public function FloorPixel()
		{
			super();
		}
		public function move(x:Number, y:Number):void
		{
			super.x = x;
			super.y = y;
		}
	}
}