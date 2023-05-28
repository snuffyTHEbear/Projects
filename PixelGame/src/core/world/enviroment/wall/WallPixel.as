package core.world.enviroment.wall
{
	import flash.display.MovieClip;
	
	public class WallPixel extends MovieClip
	{
		public function WallPixel()
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