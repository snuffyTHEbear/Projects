package{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle3D;
	
	public class Easing3D extends Sprite{
		
		private var ball:CreateCircle3D;
		private var tx:Number;
		private var ty:Number;
		private var tz:Number;
		private var easing:Number = .1;
		private var fl:Number = 250;
		private var vpX:Number = stage.stageWidth / 2;
		private var vpY:Number = stage.stageHeight / 2;
		
		public function Easing3D(){
			init();
		}
		private function init():void{
			ball = new CreateCircle3D();
			addChild(ball);
			
			tx = Math.random() * 500 - 250;
			ty = Math.random() * 500 - 250;
			tz = Math.random() * 500;
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void{
			var dx:Number = tx - ball.xPos;
			var dy:Number = ty - ball.yPos;
			var dz:Number = tz - ball.zPos;
			ball.xPos += dx * easing;
			ball.yPos += dy * easing;
			ball.zPos += dz * easing;
			
			var distance:Number = Math.sqrt(dx*dx+dy*dy+dz*dz);
			
			if(distance < 1)
			{
				tx = Math.random() * 500 - 250;
				ty = Math.random() * 500 - 250;
				tz = Math.random() * 500;
			}
			if(ball.zPos > -fl)
			{
				var scale:Number = fl / (fl +ball.zPos);
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