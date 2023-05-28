package{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	
	public class PulsingMotion extends Sprite{
			private var ball:CreateCircle;
			private var angle:Number = 0;
			private var centerScale:Number = 1;
			private var range:Number = .5;
			private var speed:Number = .1;
		public function PulsingMotion(){
			init();
		}
		private function init():void{
			ball = new CreateCircle();
			addChild(ball);
			ball.x = stage.stageWidth / 2;
			ball.y = stage.stageHeight / 2;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void{
			ball.scaleX = ball.scaleY = centerScale + Math.sin(angle) * range;
			angle += speed;
		}
	}
}