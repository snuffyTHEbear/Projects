package core.events
{
	import flash.events.Event;

	public class CharacterEvent extends Event
	{
		public static const CHAR_LEFT:String = "charLeft";
		public static const CHAR_RIGHT:String = "charRight";
		public static const CHARACTER_EVENT:String = "characterEvent";
		
		public var val:String;
		
		public function CharacterEvent($val:String)
		{
			super(CHARACTER_EVENT);
			val = $val;
		}
	}
}