package
{
	import com.arcticcode.greenFlames.audio.AudioPlayer;
	import com.arcticcode.greenFlames.audio.ScrubSeekBar;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class AudioScrubTests extends Sprite
	{
		private var _url:String = "http://arctic-code.com/dump/JI.mp3";
		
		public function AudioScrubTests()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(e.type, init);
			
			addChild(new AudioPlayer(_url, 300, 10));
		}
	}
}