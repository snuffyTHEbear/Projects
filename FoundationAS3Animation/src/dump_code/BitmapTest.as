package{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class BitmapTest extends Sprite{
		private var myBitmapData:BitmapData;
		private var myBitmap:Bitmap;
		public function BitmapTest(){
			init();
		}
		private function init():void{
			myBitmapData = new BitmapData(100, 100, false, 0xff6633);
			myBitmap = new Bitmap(myBitmapData);
			addChild(myBitmap);
			myBitmap.x = stage.stageWidth / 2;
			myBitmap.y = stage.stageHeight / 2;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void{
		}
	}
}