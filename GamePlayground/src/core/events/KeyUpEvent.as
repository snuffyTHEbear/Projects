package core.events
{
	import flash.events.Event;

	public class KeyUpEvent extends Event
	{
		public static const KEY_UP:String = "keyDown";
		public var key:uint;
		
		public function KeyUpEvent($key:uint)
		{
			super(KEY_UP);
			key = $key;
		}
		
	}
}