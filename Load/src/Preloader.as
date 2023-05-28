package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.filters.DropShadowFilter;
	
	import mx.events.FlexEvent;
	import mx.preloaders.DownloadProgressBar;

	public class Preloader extends DownloadProgressBar
	{
		private var _preloader:ArcticCodePreloader;
		
		public function Preloader()
		{
			_preloader = new ArcticCodePreloader();
			_preloader.filters = [new DropShadowFilter(4,45,0,0.5)];
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addChild(_preloader);
		}
		
		private function onAdded(e:Event):void
		{
			_preloader.x = stage.stageWidth * 0.5;// - _preloader.width * 0.5;
			_preloader.y = stage.stageHeight * 0.5;// - _preloader.width * 0.5;
		}
		
		public override function set preloader(preloader:Sprite):void
		{
			preloader.addEventListener(ProgressEvent.PROGRESS, onProgress);
			preloader.addEventListener(FlexEvent.INIT_COMPLETE, onInitComplete);
		}
		
		private function onProgress(e:ProgressEvent):void
		{
			_preloader.percentText.text = Math.ceil(e.bytesLoaded / e.bytesTotal * 100).toString();
			//cp.gotoAndStop(Math.ceil(e.bytesLoaded / e.bytesTotal*100));
		}
		
		private function onInitComplete(e:Event):void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}