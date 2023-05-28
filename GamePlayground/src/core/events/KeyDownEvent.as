package core.events
{
	import flash.events.Event;

	public class KeyDownEvent extends Event
	{
		public static const KEY_DOWN:String = "keyDown";
		public var key:uint;
		
		public function KeyDownEvent($key:uint)
		{
			super(KEY_DOWN);
			key = $key;
		}
		
	}
}