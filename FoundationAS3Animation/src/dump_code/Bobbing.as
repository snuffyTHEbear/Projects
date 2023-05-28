package{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	
	public class Bobbing extends Sprite{
		
		private var ball:CreateCircle;
		private var angle:Number = 0;
		private var centerY:Number = stage.stageWidth / 2;
		private var range:Number = 50;
		private var speed:Number = 0.1;
		private var xSpeed:Number = 1;
		private var ySpeed:Number = .1;
		
		public function Bobbing(){
			init();
		}
		private function init():void{
			ball = new CreateCircle();
			addChild(ball);
			ball.x = centerY;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		public function onEnterFrame(event:Event):void{
			ball.x += xSpeed;
			ball.y = centerY + Math.sin(angle) * range;
			trace("Value is: " + centerY + Math.sin(angle) * range);
			//angle += speed;
			angle += ySpeed;
		}
	}
}