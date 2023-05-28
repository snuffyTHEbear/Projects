package {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle3D;

	public class Collision3D extends Sprite
	{
		private var balls:Array;
		private var numBalls:uint = 20;
		private var fl:Number = 250;
		private var vpX:Number = stage.stageWidth / 2;
		private var vpY:Number = stage.stageHeight / 2;
		private var top:Number = -200;
		private var bottom:Number = 200;
		private var left:Number = -200;
		private var right:Number = 200;
		private var front:Number = 200;
		private var back:Number = -200;
		
		public function Collision3D()
		{
			init();
		}
		
		private function init():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			balls = new Array();
			for(var i:uint = 0; i < numBalls; i++)
			{
				var ball:CreateCircle3D = new CreateCircle3D(15);
				balls.push(ball);
				ball.xPos = Math.random() * 400 - 200;
				ball.yPos = Math.random() * 400 - 200;
				ball.zPos = Math.random() * 400 - 200;
				ball.vx = Math.random() * 10 - 5;
				ball.vy = Math.random() * 10 - 5;
				ball.vz = Math.random() * 10 - 5;
				addChild(ball);
			}
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(event:Event):void
		{
			for(var i:uint = 0; i < numBalls; i++)
			{
				var ball:CreateCircle3D = balls[i];
				move(ball);
			}
			for(i = 0; i < numBalls - 1; i++)
			{
				var ballA:CreateCircle3D = balls[i];
				for(var j:uint = i + 1; j < numBalls; j++)
				{
					var ballB:CreateCircle3D = balls[j];
					var dx:Number = ballA.xPos - ballB.xPos;
					var dy:Number = ballA.yPos - ballB.yPos;
					var dz:Number = ballA.zPos - ballB.zPos;
					var dist:Number = Math.sqrt(dx * dx + dy * dy + dz * dz);
					if(dist < ballA.radius + ballB.radius)
					{
						var blueTransform:ColorTransform = new ColorTransform(0, 1, 1, 1, 0, 0, 255, 0);
						ballA.transform.colorTransform = blueTransform;
						ballB.transform.colorTransform = blueTransform;
					}
				}
			}
			sortZ();
		}
		
		private function move(ball:CreateCircle3D):void
		{
			var radius:Number =  ball.radius;
			
			ball.xPos += ball.vx;
			ball.yPos += ball.vy;
			ball.zPos += ball.vz;
			
			if(ball.xPos + radius > right)
			{
				ball.xPos = right - radius;
				ball.vx *= -1;
			}
			else if(ball.xPos - radius < left)
			{
				ball.xPos = left + radius;
				ball.vx *= -1;
			}
			if(ball.yPos + radius > bottom)
			{
				ball.yPos = bottom - radius;
				ball.vy *= -1;
			}
			else if(ball.yPos - radius < top)
			{
				ball.yPos = top + radius;
				ball.vy *= -1;
			}
			if(ball.zPos + radius > front)
			{
				ball.zPos = front - radius;
				ball.vz *= -1;
			}
			else if(ball.zPos - radius < back)
			{
				ball.zPos = back + radius;
				ball.vz *= -1;
			}
			
			if(ball.zPos > -fl)
			{
				var scale:Number = fl / (fl + ball.zPos);
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
		
		private function sortZ():void
		{
			balls.sortOn("zPos", Array.DESCENDING | Array.NUMERIC);
			for(var i:uint = 0; i < numBalls; i++)
			{
				var ball:CreateCircle3D = balls[i];
				setChildIndex(ball, i);
			}
		}
	}
}
