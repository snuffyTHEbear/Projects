package Assets.Events
{
	import flash.events.Event;
	
	public class ListPopulatedEvent extends Event
	{
		public static const LIST_POPULATED:String = "listPopulated";
		public function ListPopulatedEvent()
		{
			super(LIST_POPULATED);
		}
	}
}