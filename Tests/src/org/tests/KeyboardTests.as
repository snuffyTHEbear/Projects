package org.tests
{
	import com.arcticcode.greenFlames.keyboard.KeyComboManager;
	import com.arcticcode.greenFlames.keyboard.events.KeyComboEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.ui.Keyboard;
	
	public class KeyboardTests extends Sprite
	{
		private var _comboManager:KeyComboManager;
		
		private const UP:uint = Keyboard.UP;
		private const DOWN:uint = Keyboard.DOWN;
		private const LEFT:uint = Keyboard.LEFT;
		private const RIGHT:uint = Keyboard.RIGHT;
		
		public function KeyboardTests()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(e.type, init);
			
			_comboManager = new KeyComboManager(this.parent.stage);
			_comboManager.addKeys(UP, DOWN);
			_comboManager.addEventListener(KeyComboEvent.COMBO_ENTERED, comboEntered_Handler);
		}
		
		private function comboEntered_Handler(e:KeyComboEvent):void
		{
			trace(e);
		}
	}
}