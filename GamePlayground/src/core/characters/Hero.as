package core.characters
{
	import core.events.CharacterEvent;
	import core.interfaces.IKeyboardEventListener;
	
	public class Hero extends Character implements IKeyboardEventListener
	{
		public function Hero()
		{
			trace("Hero Created");
		}
		public function handleDKey():void
		{
			this.dispatchEvent(new CharacterEvent(CharacterEvent.CHAR_RIGHT));
		}
		public function handleAKey():void
		{
			this.dispatchEvent(new CharacterEvent(CharacterEvent.CHAR_LEFT));
		}
		public function handleWKey():void
		{
			
		}
		public function handleSKey():void
		{
			
		}
		public function handleRightKey():void
		{
			
		}
		public function handleLeftKey():void
		{
			
		}
		public function handleDownKey():void
		{
			
		}
		public function handleUpKey():void
		{
			
		}
		public function handleShiftKey():void
		{
			
		}
		public function handleEnterKey():void
		{
			
		}
		public function handleSpaceKey():void
		{
			
		}
	}
}