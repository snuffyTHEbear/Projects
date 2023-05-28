package org.tutorials.states
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.tutorials.characters.Hero;
	import org.tutorials.world.Floor;
	
	public class PlayState extends FlxState
	{
		public function PlayState()
		{			
			var floor:Floor = new Floor(0,0);
			floor.y += screen.height - floor.height;
			add(floor);
			
			var hero:Hero = new Hero(0,0);
			hero.y = floor.y - hero.height;
			add(hero);
		}
	}
}