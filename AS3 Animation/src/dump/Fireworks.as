package{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle3D;
	
	[SWF(backgroundColor=0x000000)]
	
	public class Fireworks extends Sprite{
		
		private var balls:Array;
		private var numBalls:uint = 100;
		private var fl:Number = 250;
		private var vpX:Number = stage.stageWidth / 2;
		private var vpY:Number = stage.stageHeight / 2;
		private var gravity:Number = 0.2;
		private var floor:Number = 200;
		private var bounce:Number = -0.6;
		
		public function Fireworks(){
			init();
		}
		private function init():void{
			balls = new Array();
			for(var i:uint = 0;i<numBalls;i++)
			{
				var ball:CreateCircle3D = new CreateCircle3D(3, Math.random()*0xffffff);
				balls.push(ball);
				ball.yPos = -100;
				ball.vx = Math.random() * 6 - 3;
				ball.vy = Math.random() * 6 - 6;
				ball.vz = Math.random() * 6 - 3;
				addChild(ball);
			}
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void{
			for(var i:uint = 0;i<numBalls;i++)
			{
				var ball:CreateCircle3D = balls[i];
				move(ball);
			}
			sortZ();
		}
		private function move(ball:CreateCircle3D):void{
			ball.vy += gravity;
			ball.xPos += ball.vx;
			ball.yPos += ball.vy;
			ball.zPos += ball.vz;
			
			if(ball.yPos > floor)
			{
				ball.yPos = floor;
				ball.vy *= bounce;
			}
			if(ball.zPos > -fl)
			{
				var scale:Number = fl / (fl+ball.zPos);
				ball.scaleX = ball.scaleY = scale;
				ball.x = vpX + ball.xPos * scale;
				ball.y = vpY + ball.yPos * scale;
				ball.visible = true;
			}
			else
			{
				ball.visible = false;
			}
		}
		private function sortZ():void{
			balls.sortOn("zPos", Array.DESCENDING | Array.NUMERIC);
			for(var i:uint = 0;i<numBalls;i++)
			{
				var ball:CreateCircle3D = balls[i];
				setChildIndex(ball, i);
			}
		}
		
	}
}