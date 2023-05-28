package{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle3D;
	
	public class Spring3D extends Sprite{
		
		private var ball:CreateCircle3D;
		private var tx:Number;
		private var ty:Number;
		private var tz:Number;
		private var spring:Number = .1;
		private var friction:Number = .94;
		private var fl:Number = 250;
		private var vpX:Number = stage.stageWidth / 2;
		private var vpY:Number = stage.stageHeight / 2;
		
		public function Spring3D(){
			init();
		}
		private function init():void{
			ball = new CreateCircle3D();
			addChild(ball);
			
			tx = Math.random() * 500 - 250;
			ty = Math.random() * 500 - 250;
			tz = Math.random() * 500;
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		private function onEnterFrame(event:Event):void{
			var dx:Number = tx - ball.xPos;
			var dy:Number = ty - ball.yPos;
			var dz:Number = tz - ball.zPos;
			ball.vx += dx * spring;
			ball.vy += dy * spring;
			ball.vz += dz * spring;
			ball.xPos += ball.vx;
			ball.yPos += ball.vy;
			ball.zPos += ball.vz;
			ball.vx *= friction;
			ball.vy *= friction;
			ball.vz *= friction;
			
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
		private function onMouseDown(event:MouseEvent):void{
			tx = Math.random() * 500 - 250;
			ty = Math.random() * 500 - 250;
			tz = Math.random() * 500;
		}
	}
}