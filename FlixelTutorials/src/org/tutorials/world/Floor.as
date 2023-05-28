package org.tutorials.world
{
	import org.flixel.FlxSprite;
	
	public class Floor extends FlxSprite
	{
		[Embed(source="assets/images/floor.png")]
		private var Floor_Image:Class
		
		public function Floor(X:Number=0, Y:Number=0)
		{
			super(X, Y, Floor_Image);
		}
	}
}