package core
{
	import core.characters.Hero;
	import core.events.CharacterEvent;
	
	import flash.events.EventDispatcher;

	public class CharacterManager extends EventDispatcher
	{
		private var _hero:Hero;
		private var _enemies:Array;
		private var _keyDown:Boolean;
		private var _keyUp:Boolean;
		private var _keyLeft:Boolean;
		private var _keyRight:Boolean;
		
		public function CharacterManager(hero:Hero, enemies:Array = null)
		{
			_hero = hero;
			_enemies = enemies;
			_hero.addEventListener(CharacterEvent.CHARACTER_EVENT, heroCharacterEvent_Handler);
		}
		public function tick():void
		{
			if(_keyRight)
			{
				_hero.x += _hero.velX;
			}
			else if(_keyLeft)
			{
				_hero.x -= _hero.velX;
			}
		}
		private function heroCharacterEvent_Handler(e:CharacterEvent):void
		{
			trace(e);
			switch(e.val)
			{
				case CharacterEvent.CHAR_LEFT:
				_keyLeft = _keyLeft ? false : true; 
				_keyLeft ? _hero.velX = 1 : _hero.velX = 0;
				break;
				
				case CharacterEvent.CHAR_RIGHT:
				_keyRight = _keyRight ? false :true;
				_keyRight ? _hero.velX = 1 : _hero.velX = 0;
				break;
			}
		}
	}
}