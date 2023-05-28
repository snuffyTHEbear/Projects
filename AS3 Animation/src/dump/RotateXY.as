package{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle3D;
	
	public class RotateXY extends Sprite{
		
		private var balls:Array;
		private var numBalls:uint = 50;
		private var fl:Number = 250;
		private var vpX:Number = stage.stageWidth / 2;
		private var vpY:Number = stage.stageHeight / 2;
		
		public function RotateXY(){
			init();
		}
		private function init():void{
			balls = new Array();
			for(var i:uint = 0; i < numBalls; i++)
			{
				var ball:CreateCircle3D = new CreateCircle3D(0);
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
			var angleY:Number = (mouseX - vpX) * .001;
			for(var i:uint = 0; i < numBalls; i++)
			{
				var ball:CreateCircle3D = balls[i];
				rotateX(ball, angleX);
				rotateY(ball, angleY);
				doPerspective(ball);
			}
			graphics.clear();
			graphics.lineStyle(0);
			graphics.moveTo(balls[0].x, balls[0].y);
			for(i = 1;i<numBalls;i++)
			{
				graphics.lineTo(balls[i].x, balls[i].y);
			}
		}
		private function rotateX(ball:CreateCircle3D, angleX:Number):void{
			var position:Array = [ball.xPos, ball.yPos, ball.zPos];
			
			var sin:Number = Math.sin(angleX);
			var cos:Number = Math.cos(angleX);
			var xRotMatrix:Array = new Array();
			xRotMatrix[0] = [1,	   0,	  0];
			xRotMatrix[1] = [0,	 cos,	sin];
			xRotMatrix[2] = [0,	-sin,	cos];
			
			var result:Array = matrixMultiply(position, xRotMatrix);
			ball.xPos = result[0];
			ball.yPos = result[1];
			ball.zPos = result[2];	
		}
		private function matrixMultiply(matrixA:Array, matrixB:Array):Array
		{
			var result:Array = new Array();
			result[0] = matrixA[0] * matrixB[0][0]+
						matrixA[1] * matrixB[1][0]+
						matrixA[2] * matrixB[2][0];
						
			result[1] = matrixA[0] * matrixB[0][1]+
						matrixA[1] * matrixB[1][1]+
						matrixA[2] * matrixB[2][1];
						
			result[2] = matrixA[0] * matrixB[0][2]+
						matrixA[1] * matrixB[1][2]+
						matrixA[2] * matrixB[2][2];
			return result;
		}
		private function rotateY(ball:CreateCircle3D, angleY:Number):void{
			var position:Array = [ball.xPos, ball.yPos, ball.zPos];
			
			var sin:Number = Math.sin(angleY);
			var cos:Number = Math.cos(angleY);
			var yRotMatrix:Array = new Array();
			
			yRotMatrix[0] = [cos,	0,	sin];
			yRotMatrix[1] = [0,		1,	  0];
			yRotMatrix[2] = [-sin,	0,	cos];
			
			var result:Array = matrixMultiply(position, yRotMatrix);
			ball.xPos = result[0];
			ball.yPos = result[1];
			ball.zPos = result[2];
		}
		private function doPerspective(ball:CreateCircle3D):void{
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
	}
}