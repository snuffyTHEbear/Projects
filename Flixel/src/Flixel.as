package
{
	import org.flixel.FlxGame;
	
	[SWF(width = 640, height = 480, backgroundColor = 0x000000)]
	public class Flixel extends FlxGame
	{
		public function Flixel()
		{
			super(320, 240, PlayState, 1);
		}
	}
}