package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	[SWF(width=600,height=400,backgroundColor=0xFFFFFF)]
	public class ImageDissolve extends Sprite
	{
		[Embed(source="/assets/image1.jpg")]
		private var image1:Class;
		
		[Embed(source="/assets/image2.jpg")]
		private var image2:Class;
		
		private var b1:Bitmap;
		private var b2:Bitmap;
		private var seed:Number = 0;
		private var pixelCount:int;
		private var numPixels:Number;
		
		public function ImageDissolve()
		{
			init();
		}
		private function init():void
		{
			b1 = new image1();
			b1.x = stage.stageWidth*0.5-b1.width-5;
			b1.y = stage.stageHeight*0.5 - b1.height*0.5;
			b2 = new image2();
			b2.x = stage.stageWidth*0.5+5;
			b2.y = stage.stageHeight*0.5 - b2.height*0.5;
			addChild(b1);
			addChild(b2);
			
			seed = Math.random()*100000;
			numPixels = b1.bitmapData.width * b1.bitmapData.height / 100;
			addEventListener(Event.ENTER_FRAME,dissolve);
		}
		private function dissolve(e:Event):void
		{
			seed = b1.bitmapData.pixelDissolve(b2.bitmapData,b2.bitmapData.rect,new Point(),seed,numPixels);
			pixelCount += numPixels;
			if(pixelCount > b1.bitmapData.width * b1.bitmapData.height)
			{
				removeEventListener(Event.ENTER_FRAME, dissolve);
			}
		}
	}
}