package{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	
	public class EaseToMouse extends Sprite{
		
		private var ball:CreateCircle;
		private var easing:Number = 0.2;
		
		public function EaseToMouse(){
			init();
		}
		private function init():void{
			ball = new CreateCircle();
			addChild(ball);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void{
			var targetX:Number = mouseX;
			var targetY:Number = mouseY;
			var dx:Number = (targetX - ball.x);
			var dy:Number = (targetY - ball.y);
			var distance:Number = Math.sqrt(dx * dx + dy * dy);
			var vx:Number = dx * easing;
			var vy:Number = dy * easing;
			ball.x += vx;
			ball.y += vy;
		}
	}
}