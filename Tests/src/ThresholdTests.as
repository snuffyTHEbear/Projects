package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;

	public class ThresholdTests extends Sprite
	{
		public function ThresholdTests()
		{
			init();
		}
		private function init():void
		{
			var srcBmp:BitmapData = new BitmapData(stage.stageWidth,
                                       stage.stageHeight,
                                       true, 0xffffffff);
			srcBmp.perlinNoise(200, 100, 2, 1000, false, true, 1, true);
			
			var destBmp:BitmapData = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0xffffffff);
			var image:Bitmap = new Bitmap(destBmp);
			addChild(image);
			destBmp.threshold(srcBmp,             // sourceBitmap
			                  srcBmp.rect,        // sourceRectangle
			                  new Point(  ),        // destPoint
			                  "<",                // operator
			                  0x00880000,         // threshold
			                  0x00000000,         // color
			                  0x00ff0000,         // mask
			                  true);              // copySource
			
			destBmp.applyFilter(destBmp,destBmp.rect,new Point,new DropShadowFilter()); 
		}
	}
}