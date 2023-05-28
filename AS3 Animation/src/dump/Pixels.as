package{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Pixels extends Sprite{
		
		private var canvas:BitmapData;
		private var bmp:Bitmap;
		private var _color:uint;
		private var _xPos:Number = 0;
		private var _yPos:Number = 0;
		private var angle:Number = 0;
		private var radius:Number = 5;
		private var vr:Number = 0.5;
		private var easing:Number = 0.2;
		private var _right:Boolean = false;
		private var area:Number = stage.stageWidth*stage.stageHeight;
		public function Pixels(){
			init();
		}
		private function init():void{
			//canvas = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0x00000000);
			canvas  = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0x00000000);
			bmp = new Bitmap(canvas);
			bmp.x = 0;
			bmp.y = 0;
			addChild(bmp);
			
			//_yPos = stage.stageHeight / 2;
			_yPos = 0;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void{
			//_color = _xPos*0xff0000 + 0xff000000;
			_color = Math.random()*0xffffff + 0xff000000;
				if(_xPos >= canvas.width && _right == true){
					_right = false;
					_xPos = canvas.width;
					_yPos += 1;
				}else if(_xPos <= 0 && _right == false)
				{
					_right = true;
					_xPos = 0;
					_yPos += 1;
				}
				if(_right){
					_xPos++;
				}
				else
				{
					_xPos--;
				}
				if(_xPos >= canvas.width && _yPos >= canvas.height)
				{
					removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				}
			canvas.setPixel32(_xPos, _yPos, _color);
		}
	}
}