package{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	public class WavesDrawingAPI extends Sprite{
		
		private var angle:Number = 0;
		private var centerY:Number = 200;
		private var range:Number = 50;
		private var xSpeed:Number = 1;
		private var ySpeed:Number = .05;
		private var xPos:Number;
		private var yPos:Number;
		private var b:Bitmap;
		private var bmd:BitmapData;
		private var _color:uint = 0xffffff;
		
		public function WavesDrawingAPI(){
			init();
		}
		private function init():void{
			xPos = 0;
			//graphics.lineStyle(1, 0, 1);
			//graphics.moveTo(0, centerY);
			bmd = new BitmapData(stage.stageWidth * 2, stage.stageHeight, false, 0x000000);
			b = new Bitmap(bmd);
			addChild(b);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void{
			xPos += xSpeed;
			angle += ySpeed;
			yPos = centerY + Math.sin(angle) * range;
			//graphics.lineTo(xPos, yPos);
			bmd.setPixel(xPos, yPos, _color);
			if(xPos > stage.stageWidth)
			{
				b.x -= xSpeed;
			}
			if(xPos == bmd.width)
			{
				b.x = 0;
				xPos = 0;
				_color = Math.random()*0xffffff;
			}	
		}
	}
}