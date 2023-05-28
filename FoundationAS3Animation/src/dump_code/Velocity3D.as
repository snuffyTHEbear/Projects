package{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	
	public class Velocity3D extends Sprite{
		
		private var ball:CreateCircle;
		private var xPos:Number = 0;
		private var yPos:Number = 0;
		private var zPos:Number = 0;
		private var vx:Number = 0;
		private var vy:Number = 0;
		private var vz:Number = 0;
		private var friction:Number = .98;
		private var fl:Number = 250;
		private var vpX:Number = stage.stageWidth / 2;
		private var vpY:Number = stage.stageHeight / 2;
		
		public function Velocity3D(){
			init();
		}
		private function init():void{
			ball = new CreateCircle();
			addChild(ball);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		private function onEnterFrame(event:Event):void{
			xPos += vx;
			yPos += vy;
			zPos += vz;
			
			vx *= friction;
			vy *= friction;
			vz *= friction;
			if(zPos > -fl){
				var scale:Number = fl / (fl + zPos);
				ball.scaleX = ball.scaleY = scale;
				ball.x = vpX + xPos * scale;
				ball.y = vpY + yPos * scale;
				ball.visible = true;
			}
			else
			{
				ball.visible = false;
			}
		}
		private function onKeyDown(event:KeyboardEvent):void{
			switch(event.keyCode)
			{
				case Keyboard.UP:
				vy -= 1;
				break;
				
				case Keyboard.DOWN:
				vy += 1;
				break;
				
				case Keyboard.LEFT:
				vx -= 1;
				break;
				
				case Keyboard.RIGHT:
				vx += 1;
				break;
				
				case Keyboard.SHIFT:
				vz += 1;
				break;
				
				case Keyboard.CONTROL:
				vz -= 1;
				break;
				
				default:
				break;
			}
		}
	}
}