package{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class RotatePixels extends Sprite{
		
		private var vr:Number = .05;
		private var canvas:BitmapData;
		private var radius:Number = 10;
		private var bmp:Bitmap;
		private var _color:uint;
		private var num:Number = 0;
		
		public function RotatePixels(){
			init();
		}
		private function init():void{
			canvas = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0x00000000);
			bmp = new Bitmap(canvas);
			addChild(bmp);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void{
			_color = Math.random()*0xffffff + 0xff000000;
			vr+=.05
			num+=0.1;
			var angle:Number = (vr) * .001;
			var cos:Number = Math.cos(angle)*num;
			var sin:Number = Math.sin(angle)*num;
			var x1:Number = vr + num * sin - cos;
			var y1:Number = vr + num * cos + sin;
			var x2:Number = cos * x1 - sin * y1;
			var y2:Number = cos * y1 + sin * x1;
			canvas.setPixel32(x2,y2, _color);
		}
	}
}