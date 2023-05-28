package{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	
	public class pointHitTest extends Sprite{
		
		private var ball:CreateCircle;
		private var output:TextField;
		
		public function pointHitTest(){
			init();
		}
		private function init():void{
			ball = new CreateCircle();
			addChild(ball);
			ball.x = stage.stageWidth / 2;
			ball.y = stage.stageHeight / 2;
			
			output = new TextField();
			addChild(output);

			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void{
			if(ball.hitTestPoint(mouseX, mouseY, true))
			{
				output.text = "hit";
			}
			else
			{
				output.text = "no hit";
			}
		}
	}
}