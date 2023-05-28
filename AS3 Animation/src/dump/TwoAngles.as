package{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	
	public class TwoAngles extends Sprite{
		
		private var ball:CreateCircle;
		private var angleX:Number = 0;
		private var angleY:Number = 0;
		private var centerX:Number = 200;
		private var centerY:Number = 200;
		private var range:Number = 50;
		private var xSpeed:Number = .07;
		private var ySpeed:Number = .11;
		
		public function TwoAngles(){
			init();
		}
		private function init():void{
			ball = new CreateCircle();
			addChild(ball);
			ball.x = 0;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void{
			ball.x = centerX + Math.sin(angleX) * range;
			ball.y = centerY + Math.sin(angleY) * range;
			angleX += xSpeed;
			angleY += ySpeed;
		}
	}
}