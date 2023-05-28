package
{
	import com.arcticcode.greenFlames.display.DisplayUtils;
	import com.arcticcode.greenFlames.graphics.CreateRect;
	import com.arcticcode.greenFlames.xPreloader.XPreloader;
	import com.bit101.components.PushButton;
	import com.bit101.components.Text;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	[SWF(width=200, height = 350, backgroundColor = 0xffffff)]
	public class AvatarLoader extends Sprite
	{
		private var bmd:BitmapData;
		
		private var b:Bitmap;
		
		private var input:Text;
		
		private var loadBtn:PushButton;
		
		private var centreX:Number = stage.stageWidth * 0.5;
		
		private var centreY:Number = stage.stageHeight * 0.5;
		
		private var urlB:String = "http://avatar.xboxlive.com/avatar/";
		
		private var gamertag:String = "snuffyTHEbear";
		
		private var urlE:String = "/avatar-body.png";
		
		private var loader:XPreloader;
		
		private var url:String = "";
		
		private var bar:CreateRect = new CreateRect(0, 10, true, false, 0xCCCCCC, 0.85, true);
		
		public function AvatarLoader()
		{
			init();
		}
		
		private function init():void
		{
			input = new Text(this, 5, 5, gamertag);
			input.setSize(155, 20);
			loadBtn = new PushButton(this, input.width + 10, 5, "Load", onLoad);
			loadBtn.setSize(30, 16);
			
			DisplayUtils.doCentreOne(bar, centreX, centreY);
			bar.visible = false;
			addChild(bar);
			
			url = urlB + gamertag + urlE;
			loader = new XPreloader(url, XPreloader.IMAGE, false);
			loader.addEventListener(Event.COMPLETE, onLoaded);
			loader.addEventListener(ProgressEvent.PROGRESS, onProgress);
			loader.load();
		}
		
		private function onLoad(e:Event):void
		{
			bar.visible = true;
			removeChild(b);
			b = null;
			gamertag = input.text;
			url = urlB + gamertag + urlE;
			loader.loadURL(url, XPreloader.IMAGE, true);
		}
		
		private function onLoaded(e:Event):void
		{
			bar.visible = false;
			bar.width = 0;
			b = loader.content;
			addChild(b);
			b.x = centreX - b.width / 2;
			b.y = 350 - b.height;
		}
		
		private function onProgress(e:ProgressEvent):void
		{
			bar.width = e.bytesLoaded / e.bytesTotal * 100;
		}
	}
}