package{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	
	public class Friction1 extends Sprite{
		
		private var ball:CreateCircle;
		private var vx:Number = 0;
		private var vy:Number = 0;
		private var friction:Number = 0.9;
		
		public function Friction1(){
			init();
		}
		private function init():void{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			ball = new CreateCircle();
			ball.x = stage.stageWidth / 2;
			ball.y = stage.stageHeight / 2;
			vx = Math.random()* 25 - 5;
			vy = Math.random()* 25 - 5;
			addChild(ball);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void{
			/*var speed:Number = Math.sqrt(vx * vx + vy * vy);
			var angle:Number = Math.atan2(vy, vx);
			if(speed > friction)
			{
				speed -= friction;
			}
			else
			{
				speed = 0;
			}
			vx = Math.cos(angle) * speed;
			vy = Math.sin(angle) * speed;*/
			vx *= friction;
			vy *= friction;
			ball.x += vx;
			ball.y += vy;
		}
	}
}