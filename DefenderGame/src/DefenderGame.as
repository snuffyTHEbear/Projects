package
{
	import flash.display.Sprite;
	
	import org.arcticcode.flixelprimer.PlayState;
	import org.flixel.FlxGame;
	
	[SWF(width = 640, height = 480, backgroundColor = 0xABCC7D)]
	[Frame(factoryClass = "Preloader")]
	
	public class DefenderGame extends FlxGame
	{
		public function DefenderGame()
		{
			super(640, 480, PlayState, 1);
		}
	}
}