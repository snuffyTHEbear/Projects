package core.objects
{
	import com.arcticcode.greenFlames.events.RobustEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	[Event(name="complete", type="flash.events.Event")]
	[Event(name="eventFire", type="com.arcticcode.events.RobustEvent")]
	
	public class BaseObject extends EventDispatcher
	{
		public function BaseObject()
		{
			init();
		}
		private function init():void
		{
			dispatchEvent(new Event(Event.COMPLETE));
			dispatchEvent(new RobustEvent({val:"init"}));
		}	
	}
}