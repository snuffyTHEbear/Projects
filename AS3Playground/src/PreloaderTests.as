package
{
	import com.arcticcode.greenFlames.xPreloader.XPreloader;
	import com.arcticcode.greenFlames.xPreloader.XVisualProgress;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	public class PreloaderTests extends Sprite
	{
		private var _loader:XPreloader;
		
		private var _loaderVis:XVisualProgress;
		
		public function PreloaderTests()
		{
			_loader = new XPreloader("http://arctic-code.com/Audio/Apps/TH_GNT/01_Deathstep_[Battle_Drum_Machine_Mix].mp3", XPreloader.AUTO_RECOGNISE, false);
			_loaderVis = new XVisualProgress(XVisualProgress.CIRCLE_LINE, true, "Arctic-Code", 0xcc0000, 0x000000, false);
			_loader.addEventListener(Event.COMPLETE, loaderComplete);
			_loader.addEventListener(ProgressEvent.PROGRESS, loaderProgress);
			addChild(_loaderVis);
			_loaderVis.move(stage.stageWidth * 0.5, stage.stageHeight * 0.5);
			_loader.load();
		}
		
		private function loaderProgress(e:ProgressEvent):void
		{
			_loaderVis.update(e);
		}
		
		private function loaderComplete(e:Event):void
		{
			_loader.loadURL("http://arctic-code.com/Audio/Apps/TH_GNT/12_Deathstep_VIP_.mp3");
		}
	}
}