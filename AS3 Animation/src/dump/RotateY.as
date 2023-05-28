package{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle3D;
	
	public class RotateY extends Sprite{
		
		private var balls:Array;
		private var numBalls:uint = 50;
		private var fl:Number = 250;
		private var vpX:Number = stage.stageWidth / 2;
		private var vpY:Number = stage.stageHeight / 2;
		
		public function RotateY(){
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
			var angleY:Number = (mouseX - vpX) * .001;
			for(var i:uint = 0; i < numBalls; i++)
			{
				var ball:CreateCircle3D = balls[i];
				rotateY(ball, angleY);
			}
			sortZ();
		}
		private function rotateY(ball:CreateCircle3D, angleY:Number):void{
			var cosY:Number = Math.cos(angleY);
			var sinY:Number = Math.sin(angleY);
			
			var x1:Number = ball.xPos * cosY - ball.zPos * sinY;
			var z1:Number = ball.zPos * cosY - ball.xPos * sinY;
			
			ball.xPos = x1;
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