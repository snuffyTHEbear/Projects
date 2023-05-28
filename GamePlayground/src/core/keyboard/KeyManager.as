package core.keyboard
{
	import core.events.KeyEvent;
	import core.events.KeyUpEvent;
	import core.world.World;
	
	import flash.events.EventDispatcher;

	public class KeyManager extends EventDispatcher
	{
		private var _world:World;
		private var _keyboardUtils:KeyboardUtils;
		private var _target:Object;

		public function KeyManager(world:World, target:Object)
		{
			_world = world;
			_target = target;
			_keyboardUtils = new KeyboardUtils(_world);
			_keyboardUtils.addEventListener(KeyEvent.KEY_DOWN, keyboardUtilsKeyEvent_Handler);
			_keyboardUtils.addEventListener(KeyEvent.KEY_UP, keyboardUtilsKeyEvent_Handler);
			//_keyboardUtils.addEventListener(KeyDownEvent.KEY_DOWN, keyboardUtilsKeyDown_Handler);
			//_keyboardUtils.addEventListener(KeyUpEvent.KEY_UP, keyboardUtilsKeyUp_Handler);
		}

		public function get target():Object
		{
			return _target;
		}

		public function set target(val:Object):void
		{
			_target = val;
		}

		public function keyboardUtilsKeyEvent_Handler(e:KeyEvent):void
		{
			switch (e.key)
			{
				case KeyboardUtils.A:
					try
					{
						_target.handleAKey();
					}
					catch (e:Error)
					{
						trace(e.message)
					}
					break;

				case KeyboardUtils.D:
					try
					{
						_target.handleDKey();
					}
					catch (e:Error)
					{
						trace(e.message)
					}
					break;

				case KeyboardUtils.DOWN:
					try
					{
						_target.handleDownKey();
					}
					catch (e:Error)
					{
						trace(e.message)
					}
					break;

				case KeyboardUtils.ENTER:
					try
					{
						_target.handleEnterKey();
					}
					catch (e:Error)
					{
						trace(e.message)
					}
					break;

				case KeyboardUtils.LEFT:
					try
					{
						_target.handleLeftKey();
					}
					catch (e:Error)
					{
						trace(e.message)
					}
					break;

				case KeyboardUtils.RIGHT:
					try
					{
						_target.handleRightKey();
					}
					catch (e:Error)
					{
						trace(e.message)
					}
					break;

				case KeyboardUtils.S:
					try
					{
						_target.handleSKey();
					}
					catch (e:Error)
					{
						trace(e.message)
					}
					break;

				case KeyboardUtils.SHIFT:
					try
					{
						_target.handleShiftKey();
					}
					catch (e:Error)
					{
						trace(e.message)
					}
					break;

				case KeyboardUtils.SPACE:
					try
					{
						_target.handleSpaceKey();
					}
					catch (e:Error)
					{
						trace(e.message)
					}
					break;

				case KeyboardUtils.UP:
					try
					{
						_target.handleUpKey();
					}
					catch (e:Error)
					{
						trace(e.message)
					}
					break;

				case KeyboardUtils.W:
					try
					{
						_target.handleWKey();
					}
					catch (e:Error)
					{
						trace(e.message)
					}
					break;
			}
		}

		public function keyboardUtilsKeyUp_Handler(e:KeyUpEvent):void
		{
			switch (e.key)
			{
				case KeyboardUtils.A:
					try
					{
						_target.handleAKey();
					}
					catch (e:Error)
					{
						trace(e.message)
					}
					break;

				case KeyboardUtils.D:
					try
					{
						_target.handleDKey();
					}
					catch (e:Error)
					{
						trace(e.message)
					}
					break;

				case KeyboardUtils.DOWN:
					try
					{
						_target.handleDownKey();
					}
					catch (e:Error)
					{
						trace(e.message)
					}
					break;

				case KeyboardUtils.ENTER:
					try
					{
						_target.handleEnterKey();
					}
					catch (e:Error)
					{
						trace(e.message)
					}
					break;

				case KeyboardUtils.LEFT:
					try
					{
						_target.handleLeftKey();
					}
					catch (e:Error)
					{
						trace(e.message)
					}
					break;

				case KeyboardUtils.RIGHT:
					try
					{
						_target.handleRightKey();
					}
					catch (e:Error)
					{
						trace(e.message)
					}
					break;

				case KeyboardUtils.S:
					try
					{
						_target.handleSKey();
					}
					catch (e:Error)
					{
						trace(e.message)
					}
					break;

				case KeyboardUtils.SHIFT:
					try
					{
						_target.handleShiftKey();
					}
					catch (e:Error)
					{
						trace(e.message)
					}
					break;

				case KeyboardUtils.SPACE:
					try
					{
						_target.handleSpaceKey();
					}
					catch (e:Error)
					{
						trace(e.message)
					}
					break;

				case KeyboardUtils.UP:
					try
					{
						_target.handleUpKey();
					}
					catch (e:Error)
					{
						trace(e.message)
					}
					break;

				case KeyboardUtils.W:
					try
					{
						_target.handleWKey();
					}
					catch (e:Error)
					{
						trace(e.message)
					}
					break;
			}
		}
	}
}