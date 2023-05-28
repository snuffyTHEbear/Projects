package{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	[SWF(width="1024", height="768")]
	
	public class Rotate1 extends Sprite{
		
		//private var ball:CreateCircle;
		private var angle:Number = 0;
		private var radius:Number = 0;
		private var vr:Number = .5;
		private var output:TextField;
		private var canvas:BitmapData;
		private var bmp:Bitmap;
		private var color:uint;
		private var _xpos:Number;
		private var _ypos:Number;
		
		public function Rotate1(){
			init();
		}
		private function init():void{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			output = new TextField();
			output.autoSize = TextFieldAutoSize.LEFT;
			addChild(output);
			
			canvas = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0x00000000);
			bmp = new Bitmap(canvas);
			addChild(bmp);
			
			//ball = new CreateCircle();
			//ball.x = stage.stageWidth / 2;
			//ball.y = stage.stageHeight / 2;
			//addChild(ball);
			//graphics.lineStyle(1);
			//graphics.moveTo(ball.x, ball.y);
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
		//	stage.addEventListener(MouseEvent.CLICK, onEnterFrame);
		}
		//private function onEnterFrame(event:MouseEvent):void{
			//graphics.lineTo(ball.x, ball.y);
			//output.text = radius.toString();
			//color = Math.random() * 0xffffff + 0xff000000;
			//var ball0:CreateCircle = new CreateCircle(radius/2, Math.random()*0xffffff, 0.5);
			//if(radius>=300){
				//removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			//}else{
			private function onEnterFrame(event:Event):void{
			for(var i:Number = 0.5; i < 50; i+=0.5)
			{
				color = Math.random() * 0xffffff + 0xff000000;
				radius = radius + 0.01;
				_xpos = stage.stageWidth / 2 + Math.cos(angle) * radius;
				_ypos = stage.stageHeight / 2 + Math.sin(angle) * radius;
				//ball0.x = stage.stageWidth / 2 + Math.cos(angle) * radius;
				//ball0.y = stage.stageHeight / 2 + Math.sin(angle) * radius;
				//addChild(ball0);
				canvas.setPixel32(_xpos, _ypos, color);
				angle += vr;
			//}
			}
		}
	}
}