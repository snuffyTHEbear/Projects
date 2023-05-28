package core.keyboard
{
	import core.events.KeyEvent;
	import core.world.World;
	
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	
	public class KeyboardUtils extends EventDispatcher
	{
		public static const W:uint = 87;
		public static const A:uint = 65;
		public static const S:uint = 83;
		public static const D:uint = 68;
		public static const DOWN:uint = 40;
		public static const UP:uint = 38;
		public static const LEFT:uint = 37;
		public static const RIGHT:uint = 39;
		public static const SPACE:uint = 32;
		public static const SHIFT:uint = 16;
		public static const ENTER:uint = 13;
		
		public function KeyboardUtils(world:World)
		{
			world.stage.addEventListener(KeyboardEvent.KEY_DOWN, worldKeyDown_Handler);
		}
		
		private function worldKeyDown_Handler(e:KeyboardEvent):void
		{
			this.dispatchEvent(new KeyEvent("keyDown",e.keyCode));
			EventDispatcher(e.target.stage).removeEventListener(KeyboardEvent.KEY_DOWN, worldKeyDown_Handler);
			EventDispatcher(e.target.stage).addEventListener(KeyboardEvent.KEY_UP, worldKeyUp_Handler);
		}
		private function worldKeyUp_Handler(e:KeyboardEvent):void
		{
			this.dispatchEvent(new KeyEvent("keyUp",e.keyCode));
			EventDispatcher(e.target.stage).addEventListener(KeyboardEvent.KEY_DOWN, worldKeyDown_Handler);
			EventDispatcher(e.target.stage).removeEventListener(KeyboardEvent.KEY_UP, worldKeyUp_Handler);
		}
	}
}