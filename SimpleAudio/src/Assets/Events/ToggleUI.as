package Assets.Events
{
	public class ToggleUI
	{
		public static const TOGGLE_CONTROL:String = "toggleControl";
		public var _control:String;
		public function ToggleUI(control:String)
		{
			super(TOGGLE_CONTROL);
			this._control = control;
		}

	}
}