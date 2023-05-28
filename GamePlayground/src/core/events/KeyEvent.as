package core.events
{
	import flash.events.Event;

	public class KeyEvent extends Event
	{
		public static const KEY_DOWN:String = "keyDown";
		public static const KEY_UP:String = "keyUp";
		public var key:uint;
		
		public function KeyEvent(type:String, $key:uint)
		{
			super(type, bubbles, cancelable);
			key = $key;
		}
		
	}
}