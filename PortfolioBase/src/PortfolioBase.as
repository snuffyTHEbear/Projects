package
{
	import com.arcticcode.greenFlames.xPreloader.XPreloader;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	
	[SWF(backgroundColor=0xF8F8F8)]
	
	public class PortfolioBase extends Sprite
	{
		private var swfLoader:XPreloader;
		private var content:Sprite;
		private var perc:Number = 0;
		private var preloader:circlesPreloader;
		
		public function PortfolioBase()
		{
			stage.scaleMode = "noScale";
			stage.align = "topLeft";
			
			preloader = new circlesPreloader();
			preloader.percText.text = "";
			preloader.x = stage.stageWidth * 0.5;
			preloader.y = stage.stageHeight * 0.5;
			addChild(preloader);
			
			swfLoader = new XPreloader("http://arctic-code.com/portfolio/Portfolio.swf", "swf", false);
			swfLoader.addEventListener(IOErrorEvent.IO_ERROR, loadError);
			swfLoader.addEventListener(ProgressEvent.PROGRESS, loadProgress);
			swfLoader.addEventListener(Event.COMPLETE, loadComplete);
			swfLoader.load();
		}
		private function loadError(e:IOErrorEvent):void{trace(e.text)}
		private function loadProgress(e:ProgressEvent):void
		{
			perc = Math.ceil(e.bytesLoaded / e.bytesTotal * 100);
			preloader.percText.text = perc.toString();
			preloader.gotoAndStop(perc);
		}
		private function loadComplete(e:Event):void
		{
			content = swfLoader.content as Sprite;
			
			swfLoader.removeEventListener(Event.COMPLETE, loadComplete);
			swfLoader.removeEventListener(IOErrorEvent.IO_ERROR, loadError);
			swfLoader.removeEventListener(ProgressEvent.PROGRESS, loadProgress);
			swfLoader = null;
		}
		private function init():void
		{
			addChild(content);
			trace("Complete");
			Object(content).init(stage.stageWidth , stage.stageHeight);
		}
	}
}