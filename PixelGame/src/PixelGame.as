package
{
	import core.player.human.PixelChar;
	import core.utils.Physics;
	import core.world.level.BaseLevel;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	[SWF(width=640, height=480, backgroundColor = 0x000000)]
	public class PixelGame extends Sprite
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;
		private var _level:BaseLevel;
		private var _char:PixelChar_1;
		private var _keysDown:Vector.<uint> = new Vector.<uint>();
		
		public function PixelGame()
		{			
			setupWorld();
			setupChar();
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		private function setupChar():void
		{
			_char = new PixelChar_1();
			_char.move(centreX, centreY);
			_char.floorY = _level.floorY;
			addChild(_char);
		}
		private function setupWorld():void
		{
			_level = new BaseLevel(stage.stageWidth, stage.stageHeight);
			addChild(_level);
		}
		private function onKeyDown(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.LEFT && !_char.jumping && _keysDown.indexOf(Keyboard.RIGHT) == -1)
			{
				_char.vx = -(Physics.DEFAULT_WALK_SPEED);
				if(_keysDown.indexOf(e.keyCode) != 0)
				{
					_char.frame = PixelChar.WALK;
					_keysDown.push(e.keyCode);
				}
			}
			else if(e.keyCode == Keyboard.RIGHT && !_char.jumping && _keysDown.indexOf(Keyboard.LEFT) == -1)
			{
				_char.vx = Physics.DEFAULT_WALK_SPEED;
				if(_keysDown.indexOf(e.keyCode) != 0)
				{
					_char.frame = PixelChar.WALK;
					_keysDown.push(e.keyCode);
				}
			}
			if(e.keyCode == Keyboard.UP && !_char.jumping)
			{
				if(_keysDown.indexOf(e.keyCode) != 0)
				{
					_char.vy = Physics.DEFAULT_JUMP_SPEED;
					_char.frame = PixelChar.JUMP;
					_keysDown.push(e.keyCode);
				}
			}
		}
		private function onKeyUp(e:KeyboardEvent):void
		{
			trace(_keysDown,_keysDown.length);
			if(e.keyCode == Keyboard.UP)
			{
				_char.vy = 0;
			}
			if(e.keyCode == Keyboard.LEFT || e.keyCode == Keyboard.RIGHT)
			{
				_char.vx = 0;
				_char.frame = PixelChar.STAND;
			}
			
			_keysDown.splice(_keysDown.indexOf(e.keyCode), 1);
			trace(_keysDown,_keysDown.length);
		}
		private function onEnterFrame(e:Event):void
		{
			_char.applyVelocity();
			_char.applyGravity(Physics.DEFAULT_GRAVITY);
			_level.checkFloor(_char as PixelChar);
			_level.checkWalls(_char as PixelChar);
		}
	}
}