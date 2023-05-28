package AdvancedCollisionDetection
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import org.osmf.utils.BinarySearch;
	
	import spark.primitives.Rect;
	
	public class BitmapCompare extends Sprite
	{
		public function BitmapCompare()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(e.type, init);
			
			graphics.lineStyle(0);
			var i:uint, len:uint = 100;
			for(i=0;i<len;i++)
			{
				graphics.lineTo(Math.random() * stage.stageWidth, Math.random() * stage.stageHeight);
			}
			
			var bmd1:BitmapData = new BitmapData(300, 200, false, 0xffffff);
			bmd1.fillRect(new Rectangle(100, 50, 100, 100), 0xcc0000);
			var b1:Bitmap = addChild(new Bitmap(bmd1)) as Bitmap;
			
			var bmd2:BitmapData = new BitmapData(300, 200, true, 0x00FFFFFF);
			bmd2.fillRect(new Rectangle(100, 50, 100, 100), 0xffcc0000);
			var b2:Bitmap = addChild(new Bitmap(bmd2)) as Bitmap;
			
			b2.y = 200;
		}
	}
}