package core.world
{
	import core.CharacterManager;
	import core.characters.Character;
	import core.characters.Hero;
	import core.keyboard.KeyManager;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class World extends Sprite
	{
		private var _hero:Hero;
		private var _enemies:Array;
		private var _useTimer:Boolean;
		private var _parent:Sprite;
		private var _tickTimer:Timer;
		private var _keyManager:KeyManager;
		private var _characterManager:CharacterManager;
		
		public function World(hero:Hero, parent:Sprite=null, useTimer:Boolean=true)
		{
			_parent = parent;
			_hero = hero;
			init();
		}
		private function init():void
		{
			if(_parent!=null){this._parent.addChild(this);}
			addCharacter(_hero);
			if(_useTimer)
			{
				_tickTimer = new Timer(this.stage.frameRate / 1000);
				_tickTimer.addEventListener(TimerEvent.TIMER, tickTimerTimer_Handler);
			}	
			else
			{
				addEventListener(Event.ENTER_FRAME, thisEnterFrame_Handler);
			}
			_keyManager = new KeyManager(this, _hero);
			_characterManager = new CharacterManager(_hero);
		}
		public function addCharacter(char:Character):DisplayObject
		{
			return this.addChild(char);
		}
		public function removeCharacter(char:Character):DisplayObject
		{
			return this.removeChild(char);
		}
		private function thisEnterFrame_Handler(e:Event):void
		{
			tick();
		}
		private function tickTimerTimer_Handler(e:TimerEvent):void
		{
			tick();
			e.updateAfterEvent();
		}
		public function tick():void
		{
			_characterManager.tick();
		}
		public function addListener(eventType:String, listener:EventDispatcher, handler:Function):void
		{
			listener.addEventListener(eventType, handler);
		}
		public function removeListener(eventType:String, listener:EventDispatcher, handler:Function):void
		{
			listener.removeEventListener(eventType, handler);
		}
		public function get hero():Hero
		{
			return _hero;
		}
		public function set hero(hero:Hero):void
		{
			_hero = hero;
		}
		public function get enemies():Array
		{
			return _enemies;
		}
		public function set enemies(val:Array):void
		{
			_enemies = val;
		}
		public function get useTimer():Boolean
		{
			return _useTimer;
		}
		public function set useTimer(val:Boolean):void
		{
			_useTimer = val;
		}
	}
}