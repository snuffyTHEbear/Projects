package dump
{
	import com.arcticcode.greenFlames.ThreeDee.CreateCircle3D;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class RotateX extends Sprite
	{
		
		private var balls:Array;
		private var numBalls:uint = 50;
		private var fl:Number = 250;
		private var vpX:Number;
		private var vpY:Number;
		
		public function RotateX(w:Number, h:Number)
		{
			vpX = w * 0.5;
			vpY = h * 0.5;
			
			init();
		}
		
		private function init():void
		{
			balls = new Array();
			for(var i:uint = 0; i < numBalls; i++)
			{
				var ball:CreateCircle3D = new CreateCircle3D(15);
				balls.push(ball);
				ball.xpos = Math.random() * 200 - 100;
				ball.ypos = Math.random() * 200 - 100;
				ball.zpos = Math.random() * 200 - 100;
				addChild(ball);
			}
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(event:Event):void
		{
			var angleX:Number = (mouseY - vpY) * .001;
			for(var i:uint = 0; i < numBalls; i++)
			{
				var ball:CreateCircle3D = balls[i];
				rotateX(ball, angleX);
			}
			sortZ();
		}
		
		private function rotateX(ball:CreateCircle3D, angleX:Number):void
		{
			var cosX:Number = Math.cos(angleX);
			var sinX:Number = Math.sin(angleX);
			
			var y1:Number = ball.ypos * cosX - ball.zpos * sinX;
			var z1:Number = ball.zpos * cosX + ball.ypos * sinX;
			
			ball.ypos = y1;
			ball.zpos = z1;
			
			if(ball.zpos > -fl)
			{
				var scale:Number = fl / (fl + ball.zpos);
				ball.scaleX = ball.scaleY = scale;
				ball.x = vpX + ball.xpos * scale;
				ball.y = vpY + ball.ypos * scale;
				ball.visible = true;
			}
			else
			{
				ball.visible = false;
			}
		}
		
		private function sortZ():void
		{
			balls.sortOn("zpos", Array.DESCENDING | Array.NUMERIC);
			for(var i:uint = 0; i < numBalls; i++)
			{
				var ball:CreateCircle3D = balls[i];
				setChildIndex(ball, i);
			}
		}
	}
}