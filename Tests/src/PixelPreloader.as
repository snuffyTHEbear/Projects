package
{
	import com.arcticcode.greenFlames.preloader.ContentLoadedEvent;
	import com.arcticcode.greenFlames.preloader.Preloader;
	import com.arcticcode.greenFlames.preloader.loaderTypes.LoadProgressEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	[SWF(width=600,height=400,backgroundColor=0xFFFFFF)]
	public class PixelPreloader extends Sprite
	{
		private var b:Bitmap;
		private var bmd:BitmapData
		private var url:String = "http://farm4.static.flickr.com/3175/2948198468_a5acb52d6d_d.jpg";
		private var loader:Preloader;
		private var seed:Number;
		private var pixelCount:int=0;
		private var _p:Number;
		
		public function PixelPreloader()
		{
			init();
		}
		private function init():void
		{
			bmd = new BitmapData(300,25,false,0xFFFFFF);
			b = new Bitmap(bmd);
			b.x = stage.stageWidth * 0.5 - b.width * 0.5;
			b.y = stage.stageHeight * 0.5 - b.height * 0.5;
			addChild(b);
			
			seed = Math.random()*100000;
			
			addEventListener(Event.ENTER_FRAME, dissolve);
			
			loader = new Preloader(url,Preloader.IMAGE,false);
			loader.addEventListener(ContentLoadedEvent.CONTENT_LOADED, onLoaded);
			loader.addEventListener(LoadProgressEvent.LOAD_PROGRESS, onProgress);
			loader.load();
		}
		private function onProgress(e:LoadProgressEvent):void
		{
			//bmd.fillRect(new Rectangle(0,0,(e._bytesLoaded/e._bytesTotal)*bmd.width,bmd.height),0);
			_p = (e._bytesLoaded/e._bytesTotal)*bmd.width;
					
		}
		private function dissolve(e:Event):void
		{
			seed = bmd.pixelDissolve(bmd,new Rectangle(0,0,_p,bmd.height),new Point(),seed,bmd.width/_p*100,0);
			pixelCount += 100;
		}
		private function onLoaded(e:ContentLoadedEvent):void
		{
			var image:Bitmap = e.content as Bitmap;
			//removeChild(b);
			//addChild(image);
		}
	}
}