package Assets.PlayerCore.Audio.ID3
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.ID3Info;
	import flash.media.Sound;
	
	public class GetID3Info extends Sprite
	{
		private var _sound:Sound;
		private var _artistInfo:String;
		private var _trackInfo:String;
		private var _albumInfo:String;
		public function GetID3Info()
		{
			
		}
		public function getID3(sound:Sound):void
		{
			this._sound = sound;
			var id3Info:ID3Info = _sound.id3;
			if(id3Info.artist==null||id3Info.artist=="")
			{
				_artistInfo = "Artist information not available";
			}
			else
			{
				_artistInfo = id3Info.artist;
			}
			if(id3Info.songName==null||id3Info.songName=="")
			{
				_trackInfo="Track information not available";
			}
			else
			{
				_trackInfo = id3Info.songName;
			}
			if(id3Info.album==null||id3Info.album=="")
			{
				_albumInfo = "Album information not available";
			}
			else
			{
				_albumInfo = id3Info.album;
			}
			var maxLength:uint = 68;
			//Check Lengths
			if(_artistInfo.length>maxLength)
			_artistInfo = _artistInfo.substr(0,maxLength);
			if(_trackInfo.length>maxLength)
			_trackInfo = _trackInfo.substr(0,maxLength);
			if(_albumInfo.length>maxLength)
			_albumInfo = _albumInfo.substr(0,maxLength);
						
			dispatchEvent(new OnID3Event(_artistInfo,_trackInfo,_albumInfo));
		}
	}
}