package org.tutorials.characters
{
	import org.flixel.FlxSprite;
	
	public class Hero extends FlxSprite
	{
		[Embed(source="assets/images/hero.png")]
		private var Hero_Image:Class;
		
		public function Hero(X:Number, Y:Number)
		{
			super(X, Y, Hero_Image);
		}
	}
}