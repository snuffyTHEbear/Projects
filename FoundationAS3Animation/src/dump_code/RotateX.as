package{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle3D;
	
	public class RotateX extends Sprite{
		
		private var balls:Array;
		private var numBalls:uint = 50;
		private var fl:Number = 250;
		private var vpX:Number = stage.stageWidth / 2;
		private var vpY:Number = stage.stageHeight / 2;
		
		public function RotateX(){
			init();
		}
		private function init():void{
			balls = new Array();
			for(var i:uint = 0; i < numBalls; i++)
			{
				var ball:CreateCircle3D = new CreateCircle3D(15);
				balls.push(ball);
				ball.xPos = Math.random() * 200 - 100;
				ball.yPos = Math.random() * 200 - 100;
				ball.zPos = Math.random() * 200 - 100;
				addChild(ball);
			}
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void{
			var angleX:Number = (mouseY - vpY) * .001;
			for(var i:uint = 0; i < numBalls; i++)
			{
				var ball:CreateCircle3D = balls[i];
				rotateX(ball, angleX);
			}
			sortZ();
		}
		private function rotateX(ball:CreateCircle3D, angleX:Number):void{
			var cosX:Number = Math.cos(angleX);
			var sinX:Number = Math.sin(angleX);
			
			var y1:Number = ball.yPos * cosX - ball.zPos * sinX;
			var z1:Number = ball.zPos * cosX- ball.yPos * sinX;
			
			ball.yPos = y1;
			ball.zPos = z1;
			
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