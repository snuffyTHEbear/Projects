package{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	
	public class MouseDistance extends Sprite{
		
		private var output:TextField;
		
		private var ball:CreateCircle;
		
		public function MouseDistance(){
			init();
		}
		private function init():void{
			ball = new CreateCircle(0xff6600);
			addChild(ball);
			ball.x = stage.stageWidth / 2;
			ball.y = stage.stageHeight / 2;
			output = new TextField();
			addChild(output);
			output.x = output.y = 0;
			output.autoSize = TextFieldAutoSize.LEFT;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove); 
		}
		public function onMouseMove(event:MouseEvent):void{
			graphics.clear();
			graphics.lineStyle(1, 0, 1);
			graphics.moveTo(ball.x, ball.y);
			graphics.lineTo(mouseX, mouseY);
			var dx:Number = ball.x - mouseX;
			var dy:Number = ball.y - mouseY;
			var dist:Number = Math.sqrt(dx * dx + dy * dy);
			output.text = dist.toString();
		}
	}
}