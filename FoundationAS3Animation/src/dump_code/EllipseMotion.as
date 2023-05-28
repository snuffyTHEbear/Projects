package{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	
	public class EllipseMotion extends Sprite{
		
		private var ball:CreateCircle;
		private var angle:Number = 0;
		private var centerX:Number = 200;
		private var centerY:Number = 200;
		private var radiusX:Number = 200;
		private var radiusY:Number = 100;
		private var speed:Number = .1;
		
		public function EllipseMotion(){
			init();
		}
		private function init():void{
			ball = new CreateCircle(25,0,0x0066FF);
			addChild(ball);
			ball.x = 0;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		public function onEnterFrame(event:Event):void{
			ball.x = centerX + Math.sin(angle) * radiusX;
			ball.y = centerY + Math.cos(angle) * radiusY;
			angle += speed;
		}
	}
}