package{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	
	public class ObjectHitTest extends Sprite{
		
		private var ball1:CreateCircle;
		private var ball2:CreateCircle;
		
		public function ObjectHitTest(){
			init();
		}
		private function init():void{
			ball1 = new CreateCircle(Math.random()*50+10);
			addChild(ball1);
			ball1.x = stage.stageWidth / 2;
			ball1.y = stage.stageHeight / 2;
			ball2 = new CreateCircle(Math.random()*50+10);
			addChild(ball2);
			ball2.startDrag(true);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void{
			var dx:Number = ball2.x - ball1.x;
			var dy:Number = ball2.y - ball1.y;
			var distance:Number = Math.sqrt(dx * dx + dy * dy);
			if(distance < ball1.radius + ball2.radius)
			{
				trace("hit");
			}
		}
	}
}