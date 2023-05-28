package org.tutorials
{
	import org.flixel.FlxGame;
	import org.tutorials.states.PlayState;
	
	public class HelloWorld extends FlxGame
	{
		public function HelloWorld(width:Number, height:Number)
		{
			super(width, height, PlayState, 2);
			
		}
	}
}