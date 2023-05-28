package Assets.Events
{
	import flash.events.Event;
	import flash.filesystem.File;
	
	public class AddToPlaylist extends Event
	{
		public static const ADD_ITEM:String = "addItem";
		public var _file:File;
		public function AddToPlaylist(file:File)
		{
			super(ADD_ITEM);
			_file = file;
		}
	}
}