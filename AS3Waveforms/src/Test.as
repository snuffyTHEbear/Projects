package
{
	import com.arcticcode.greenFlames.xPreloader.XPreloader;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Test extends Sprite
	{
		private var _wr:WaveformRecorderCore;
		
		public function Test()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);	
		}
		
		private function init(e:Event):void
		{
			removeEventListener(e.type, init);
			
			_wr = new WaveformRecorderCore();
			trace(_wr.modelSoundString);
			_wr.modelSoundString = "anger";
			addChild(_wr);
		}
	}
}