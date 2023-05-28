package{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	
	public class Bubbles2 extends Sprite{
		
		private var balls:Array;
		private var numBalls:Number = 15;
		private var bounce:Number = -0.5;
		private var spring:Number = 0.05;
		private var gravity:Number = 0.05;
		private var friction:Number = 0.99;
		
		public function Bubbles2(){
			init();
		}
		private function init():void{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			balls = new Array();
			
			for(var i:uint = 0; i < numBalls; i++)
			{
				var ball:CreateCircle = new CreateCircle(Math.random()*30+20, Math.random()*0xffffff);
				ball.x = Math.random()*stage.stageWidth;
				ball.y = Math.random()*stage.stageHeight;
				ball.vx = Math.random() * 6 - 3;
				ball.vy = Math.random() * 6 - 3;
				addChild(ball);
				balls.push(ball);
			}

			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void{
			for(var i:uint = 0; i < numBalls - 1; i++)
			{
				var ball0:CreateCircle = balls[i];
				
				for(var j:uint = i + 1; j< numBalls; j++)
				{
					var ball1:CreateCircle = balls[j];
					var dx:Number = ball1.x - ball0.x;
					var dy:Number = ball1.y - ball0.y;
					var distance:Number = Math.sqrt(dx * dx + dy * dy);
					var minDistance:Number = ball0.radius + ball1.radius;
					
					if(distance < minDistance)
					{
						//var angle:Number = Math.atan2(dy, dx);
						//var tx:Number = Math.cos(angle) * minDistance;
						//var ty:Number = Math.sin(angle) * minDistance;
						var tx:Number = ball0.x + dx / distance * minDistance;
						var ty:Number = ball0.y + dy / distance * minDistance;
						var ax:Number = (tx - ball1.x) * spring;
						var ay:Number = (ty - ball1.y) * spring;
						ball0.vx -= ax;
						ball0.vy -= ay;
						ball1.vx += ax;
						ball1.vy += ay;
					}							
				}
			}
			for(i = 0; i < numBalls; i++)
			{
				var ball:CreateCircle = balls[i];
				move(ball);
			}
		}
		private function move(ball:CreateCircle):void{
			ball.vy += gravity;
			ball.vx *= friction;
			ball.vy *= friction;
			ball.x += ball.vx;
			ball.y += ball.vy;
			if(ball.x + ball.radius > stage.stageWidth)
			{
				ball.x = stage.stageWidth - ball.radius;
				ball.vx *= bounce;
			}
			else if(ball.x - ball.radius < 0)
			{
				ball.x = ball.radius;
				ball.vx *= bounce;
			}
			if(ball.y + ball.radius > stage.stageHeight)
			{
				ball.y = stage.stageHeight - ball.radius;
				ball.vy *= bounce;
			}
			else if(ball.y - ball.radius < 0)
			{
				ball.y = ball.radius;
				ball.vy *= bounce;
			}
		}
	}
}