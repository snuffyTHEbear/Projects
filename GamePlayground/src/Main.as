package {
	import core.world.World;
	
	import flash.display.Sprite;
	
	[SWF(width=640,height=480,backgroundColor=0xffffff)]
	public class Main extends Sprite
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;	
		
		private var _world:World;
		private var _hero:Char_A;
		
		public function Main()
		{
			init();
		}
		private function init():void
		{
			_hero = new Char_A();
			_world = new World(_hero, this);
			_world.hero.move(centreX, centreY);
		}
	}
}
