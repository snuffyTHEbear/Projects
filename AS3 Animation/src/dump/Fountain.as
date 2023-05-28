package{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	
	public class Fountain extends Sprite{
		
		private var count:int = 100;
		private var gravity:Number = 0.5;
		private var wind:Number = 0.1;
		private var balls:Array;
		
		public function Fountain(){
			init();
		}
		private function init():void{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			balls = new Array();
			for(var i:int = 0; i < count; i++)
			{
				var ball:CreateCircle = new CreateCircle(Math.random() * 10 + 2, 0, Math.random()*0xffffff, Math.random() + 0.1);
				ball.x = stage.stageWidth / 2;
				ball.y = stage.stageHeight;
				ball.vx = Math.random()* 2-1;
				ball.vy = Math.random()* -10 - 10;
				addChild(ball);
				balls.push(ball);
			}
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void{
			
			//wind = (stage.mouseX / 100);
			//trace(wind);
			
			for(var i:Number = 0; i<balls.length;i++){
				var ball:CreateCircle = CreateCircle(balls[i]);
				//wind = Math.random() * 3 - 1;
				ball.vy += gravity;
				ball.vx += wind;
				ball.x += ball.vx;
				ball.y += ball.vy;
				if(ball.x - ball.radius > stage.stageWidth||
				ball.x + ball.radius < 0 ||
				ball.y - ball.radius > stage.stageHeight ||
				ball.y + ball.radius < 0)
				{
					ball.x = stage.stageWidth / 2;
					ball.y = stage.stageHeight;
					ball.vx = Math.random() * 2 - 1;
					ball.vy = Math.random() * -10 - 10;
				}
			}
		}
	}
}