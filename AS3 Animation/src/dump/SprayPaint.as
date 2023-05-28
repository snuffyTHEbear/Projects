package{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	public class SprayPaint extends Sprite{
		
		private var canvas:BitmapData;
		private var bmp:Bitmap;
		private var color:uint;
		private var size:Number = 10;
		private var density:Number = 50;
		
		public function SprayPaint(){
			init();
		}
		private function init():void{
			canvas = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0x00000000);
			bmp = new Bitmap(canvas);
			addChild(bmp);
			addListeners();
			//bmp.filters = [new BlurFilter(2, 2, 3)];
		}
		private function addListeners():void{		
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		private function onMouseDown(event:MouseEvent):void{
			color = Math.random() * 0xffffff + 0xff000000;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onMouseUp(event:MouseEvent):void{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void{
			for(var i:int = 0; i < density; i++){
				var angle:Number = Math.random()*Math.PI*2;
				//var angle:Number = 0.5 * Math.PI * 2;
				var radius:Number = Math.random()*size;
				var xPos:Number = mouseX + Math.cos(angle)*radius;
				var yPos:Number = mouseY + Math.sin(angle)*radius;
				canvas.setPixel32(xPos, yPos, color);
			}
		}
		private function onKeyDown(event:KeyboardEvent):void{
			if(event.charCode == Keyboard.SPACE){
				removeChild(bmp);
				init();
			}
		}
	}
}