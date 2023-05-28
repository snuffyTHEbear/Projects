package Assets.Events
{
	import flash.events.Event;
	
	public class ControlEvent extends Event
	{
		public static const CONTROL_TYPE:String = "controlType";
		public var _command:String;
		
		public function ControlEvent(command:String)
		{
			super(CONTROL_TYPE);
			this._command = command;
		}
	}
}