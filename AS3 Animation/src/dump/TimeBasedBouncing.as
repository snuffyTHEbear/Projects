package{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getTimer;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	
	public class TimeBasedBouncing extends Sprite{
		
		private var ball:CreateCircle
		private var vx:Number;
		private var vy:Number;
		private var bounce:Number = -0.7;
		private var gravity:Number = 450;
		private var friction:Number = 0.99;
		private var oldX:Number;
		private var oldY:Number;
		private var ball2:CreateCircle;
		private var output:TextField;
		private var time:Number;
		
		public function TimeBasedBouncing(){
			init();
		}
		private function init():void{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			output = new TextField();
			output.autoSize = TextFieldAutoSize.LEFT;
			output.x = output.y = 10;
			addChild(output);
			
			ball = new CreateCircle();
			ball.x = stage.stageWidth / 2;
			ball.y = stage.stageHeight / 2;
			//vx = Math.random()*15 - 1;
			//vy = Math.random()*15 - 1;
			//vy = -10;
			vx = 300;
			vy = -300;
			addChild(ball);
			
			ball2 = new CreateCircle(10, 0xff6600);
			ball2.x = 10;
			ball2.y = -10;
			ball.addChild(ball2);
			time = getTimer();
			ball.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void{
			
			var elapsed:Number = getTimer() - time;
			time = getTimer();
			ball.x += vx * elapsed / 1000;
			ball.y += vy * elapsed / 1000;
			vy += gravity * elapsed / 1000;
			vx *= friction;
			vy *= friction;
			
			/*vy += gravity;
			vx *= friction;
			vy *= friction;
			ball.x += vx;
			ball.y += vy;*/
			
			var left:Number = 0;
			var right:Number = stage.stageWidth;
			var top:Number = 0;
			var bottom:Number = stage.stageHeight;
			
			if(ball.x + ball.radius > right)
			{
				ball.x = right - ball.radius;
				vx *= bounce;
			}
			else if(ball.x - ball.radius < left)
			{
				ball.x = left + ball.radius;
				vx *= bounce;
			}
			if(ball.y + ball.radius > bottom)
			{
				ball.y = bottom - ball.radius;
				vy *= bounce;
			}
			else if(ball.y - ball.radius < top)
			{
				ball.y = top + ball.radius;
				vy *= bounce;
			}
		}
		private function onMouseDown(event:MouseEvent):void{
			oldX = ball.x;
			oldY = ball.y;
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			ball.startDrag();
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(Event.ENTER_FRAME, trackVelocity);
		}
		private function onMouseUp(event:MouseEvent):void{
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			ball.stopDrag();
			removeEventListener(Event.ENTER_FRAME, trackVelocity);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function trackVelocity(event:Event):void{
			vx = ball.x - oldX;
			vy = ball.y - oldY;
			oldX = ball.x;
			oldY = ball.y;
		}
	}
}