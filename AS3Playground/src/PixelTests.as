package
{
	import flash.display.Bitmap;

	public class PixelTests
	{
		public var iterations:uint = 20;
		public var description:String = "Testing pixel methods";
		private var _bm:Bitmap;
		
		public function PixelTests(image:Bitmap)
		{
			_bm = image;
		}
		public function setPixelTest():void
		{
			for(var y:uint = 0; y < _bm.height; y++)
			{
				for(var x:uint = 0; x < _bm.width; x++)
				{
					var pixel:uint = _bm.bitmapData.getPixel(x, y);
					_bm.bitmapData.setPixel(x, y, (pixel & 0xFF) << 16 | (pixel & 0xFF) << 8 | (pixel & 0xFF));
				}
			}
		}
		
		public function setPixelOptimized():void
		{
			var w:int = _bm.width;
			var h:int = _bm.height;
			_bm.bitmapData.lock();			
			for(var y:uint = 0; y < h; ++y)
			{
				for(var x:uint = 0; x < w; ++x)
				{
					var pixel:uint = _bm.bitmapData.getPixel(x, y);
					_bm.bitmapData.setPixel(x, y, (pixel & 0xFF) << 16 | (pixel & 0xFF) << 8 | (pixel & 0xFF));
				}
			}
			_bm.bitmapData.unlock();
		}
		
		public function setVectorTest():void
		{
			var pv:Vector.<uint> = _bm.bitmapData.getVector(_bm.bitmapData.rect);
			var len:int = pv.length;
			
			for(var i:uint = 0; i < len; ++i)
			{
				var val:uint = pv[uint(i)] & 0xFF;
				pv[uint(i)] = val << 16 | val << 8 | val;
			}
			
			_bm.bitmapData.setVector(_bm.bitmapData.rect, pv);
		}

		public function get bm():Bitmap
		{
			return _bm;
		}

	}
}