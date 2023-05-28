package
{
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	public class PlayState extends FlxState
	{
		private var _text:FlxText;
		
		public function PlayState()
		{
			super();
			_text = new FlxText(0, 0, 100, 20, "Hello World", 0xffffffff);
			this.add(_text);
		}
		override public function update() : void
		{
			super.update();
		}
	}
}