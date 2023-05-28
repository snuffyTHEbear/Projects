package tutorials
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class BitmapDecoding extends Sprite
	{
		private var _fr:FileReference;
		
		public function BitmapDecoding(stage:Stage)
		{
			stage.addEventListener(MouseEvent.CLICK, stageClick);
		}
		private function stageClick(e:MouseEvent):void
		{
			_fr = new FileReference();
			_fr.addEventListener(Event.SELECT, onSelect);
			_fr.addEventListener(Event.COMPLETE, onComplete);
			_fr.browse();
		}
		private function onSelect(e:Event):void
		{
			_fr.load();
		}
		private function onComplete(e:Event):void
		{
			var ba:ByteArray = _fr.data;
			ba.endian = Endian.LITTLE_ENDIAN;
			ba.position = 10;
			
			var pixelOffset:uint = ba.readUnsignedInt();
			
			ba.position += 4;
			
			var width:int = ba.readInt();
			var height:int = ba.readInt();
			
			ba.position = pixelOffset;
			var padding:int = (width * 3) % 4;
			
			var bmd:BitmapData = new BitmapData(width, height, false);
			
			for(var y:int = height - 1; y >= 0; --y)
			{
				for(var x:int = 0; x < width; ++x)
				{
					bmd.setPixel(x, y, ba.readUnsignedByte() | 
										 ba.readUnsignedByte() << 8 | 
										ba.readUnsignedByte() << 16);
				}
				ba.position += padding;
			}
			
			addChild(new Bitmap(bmd));
			this.x = this.stage.stageWidth * 0.5 - this.width * 0.5;
			this.y = this.stage.stageHeight * 0.5 - this.height* 0.5;
		}
	}
}