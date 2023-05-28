package{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	
	public class Easing1 extends Sprite{
		
		private var ball:CreateCircle;
		private var easing:Number = 0.2;
		private var targetX:Number = stage.stageWidth / 2;
		private var targetY:Number = stage.stageHeight / 2;
		
		public function Easing1(){
			init();
		}
		private function init():void{
			ball = new CreateCircle();
			addChild(ball);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			ball.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		private function onMouseDown(event:MouseEvent):void{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			ball.startDrag();
		}
		private function onMouseUp(event:MouseEvent):void{
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			ball.stopDrag();
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(event:Event):void{
			var dx:Number = (targetX - ball.x);
			var dy:Number = (targetY - ball.y);
			var distance:Number = Math.sqrt(dx * dx + dy * dy);
			if(distance < 1){
				ball.x = targetX;
				ball.y = targetY;
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				trace("Done");
			}else{
				var vx:Number = dx * easing;
				var vy:Number = dy * easing;
				ball.x += vx;
				ball.y += vy;
			}
		}
	}
}