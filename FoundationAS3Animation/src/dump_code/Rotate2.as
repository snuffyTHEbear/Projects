package{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	
	public class Rotate2 extends Sprite{
		
		private var ball:CreateCircle;
		private var angle:Number = 0;
		private var radius:Number = 0;
		private var vr:Number = .05;
		private var cos:Number = Math.cos(vr);
		private var sin:Number = Math.sin(vr);
		private var output:TextField;
		private var canvas:BitmapData;
		private var bmp:Bitmap;
		private var color:uint;
		
		public function Rotate2(){
			init();
		}
		private function init():void{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			output = new TextField();
			output.autoSize = TextFieldAutoSize.LEFT;
			addChild(output);
			
			//canvas = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0x00000000);
			//bmp = new Bitmap(canvas);
			//addChild(bmp);
			
			ball = new CreateCircle();
			addChild(ball);
			ball.x = Math.random()*stage.stageWidth;
			ball.y = Math.random()*stage.stageHeight;
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void{
			var x1:Number = ball.x - stage.stageWidth / 2;
			var y1:Number = ball.y - stage.stageHeight / 2;
			var x2:Number = cos * x1 - sin * y1;
			var y2:Number = cos * y1 + sin * x1;
			ball.x = stage.stageWidth / 2 + x2;
			ball.y = stage.stageHeight / 2 + y2;
		}
	}
}