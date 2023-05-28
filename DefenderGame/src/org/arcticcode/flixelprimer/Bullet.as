package org.arcticcode.flixelprimer
{
	import org.flixel.FlxSprite;
	
	public class Bullet extends FlxSprite
	{
		public function Bullet(x:Number, y:Number)
		{
			super(x, y);
			createGraphic(16, 4, 0xFF597137);
			velocity.x = 1000;
		}
	}
}