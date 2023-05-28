package Assets.PlayerCore.Audio.ID3
{
	import flash.events.Event;
	
	public class OnID3Event extends Event
	{
		public static const ID3_COLLECTED:String = "id3Collected";
		public var _artist:String;
		public var _track:String;
		public var _album:String;
		public function OnID3Event(artist:String,track:String,album:String)
		{
			super(ID3_COLLECTED);
			_album = album;
			_track = track
			_artist = artist;
		}

	}
}