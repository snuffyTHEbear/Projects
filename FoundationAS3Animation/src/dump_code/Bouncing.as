package{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	
	public class Bouncing extends Sprite{
		
		private var ball:CreateCircle
		private var vx:Number;
		private var vy:Number;
		private var bounce:Number = -0.7;
		private var gravity:Number = .5;
		private var friction:Number = 0.99;
		private var oldX:Number;
		private var oldY:Number;
		private var ball2:CreateCircle;
		private var output:TextField;
		
		public function Bouncing(){
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
			vx = Math.random()*15 - 1;
			//vy = Math.random()*15 - 1;
			vy = -10;
			addChild(ball);
			
			ball2 = new CreateCircle(10, 0xff6600);
			ball2.x = 10;
			ball2.y = -10;
			ball.addChild(ball2);
			
			ball.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void{
			vy += gravity;
			vx *= friction;
			vy *= friction;
			ball.x += vx;
			ball.y += vy;
			var rotX:Number = 0;
			var rotY:Number = 0;
			var rotV:Number = 0;
			if(vx < .1 && vx > -.1)
			{
				rotX = 0;
			}
			else
			{
				rotX = vx * (Math.PI * 2);
			}
			if(vy == .2923803898405198 || vy == .29238038984051984 && vy > -.1)
			{
				rotY = 0;
			}
			else
			{
				rotY = vy * (Math.PI * 2);
			}
			rotV = rotX - rotY;
			ball.rotation += rotV;
			//ball.rotation += (vx - vy) * (Math.PI * 2);
			output.text = "vx: " + vx + "\nvy: " + vy + "\nrotX: " + rotX + "\nrotY: " + rotY + "\nrotV: " + rotV;
			
			var left:Number = 0;
			var right:Number = stage.stageWidth;
			var top:Number = 0;
			var bottom:Number = stage.stageHeight;
			
			if(ball.x + ball.radius > right)
			{
				playSound();
				ball.x = right - ball.radius;
				vx *= bounce;
			}
			else if(ball.x - ball.radius < left)
			{
				playSound();
				ball.x = left + ball.radius;
				vx *= bounce;
			}
			if(ball.y + ball.radius > bottom)
			{
				playSound();
				ball.y = bottom - ball.radius;
				vy *= bounce;
			}
			else if(ball.y - ball.radius < top)
			{
				playSound();
				ball.y = top + ball.radius;
				vy *= bounce;
			}
		}
		private function playSound():void
		{
			//var ranNum:Number = Math.round(Math.random()*4+1);
			//var collide:Sound = new Sound(new URLRequest("chimes/" + ranNum + ".mp3"));
			//collide.play();
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