package tutorials 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	public class ByteArrays extends Sprite
	{
		private var ba:ByteArray;
		private var loader:URLLoader;
		private var b:Bitmap;
		private var w:int = 640;
		private var h:int = 480;
		private var start:uint = 2;
		//private var end:uint = ;
		
		public function ByteArrays()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void
		{
			loader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener(Event.COMPLETE, loaded);
			loader.load(new URLRequest("assets/image.jpg"));
			
			b = new Bitmap(new BitmapData(stage.stageWidth, stage.stageHeight));
			addChild(b);
		}
		private function loaded(e:Event):void
		{
			ba = loader.data;
			ba.position = start;
			w = ba.readInt();
			h = ba.readInt();
			trace("Dimensions: " + w, h);
		}
	}
}