package{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	
	public class PythagoreanThereom extends Sprite{
		
		private var output:TextField;
		
		private var x1:Number;
		private var x2:Number;
		private var y1:Number;
		private var y2:Number;
		private var dx:Number;
		private var dy:Number;
		private var dist:Number;
		
		private var ball1:CreateCircle;
		private var ball2:CreateCircle;
		
		public function PythagoreanThereom(){
			init();
		}
		private function init():void{
			ball1 = new CreateCircle(0xff6600);
			addChild(ball1);
			ball2 = new CreateCircle(0x0066ff);
			addChild(ball2);
			output = new TextField();
			addChild(output);
			output.x = output.y = 0;
			output.autoSize = TextFieldAutoSize.LEFT;
			stage.addEventListener(MouseEvent.CLICK,onStageClick); 
			setValues();
		}
		private function setValues():void{
			ball1.x = Math.random()*(200+10);
			ball1.y = Math.random()*(150+10);
			ball2.x = Math.random()*(200+10);
			ball2.y = Math.random()*(150+10);
			
			x1 = ball1.x;
			y1 = ball1.y;
			x2 = ball2.x;
			y2 = ball2.y;
			
			getDistance();
		}
		public function getDistance():void{
			dx = x2 - x1;
			dy = y2 - y1;
			dist = Math.sqrt(dx*dx + dy * dy);
			output.text = " x1: "+x1 + " x2: "+x2 + "\n y1: "+y1 + " y2: " + y2 + "\n dist: " + dist;
			//trace("Distance is: " + dist);
		}
		private function onStageClick(event:MouseEvent):void{
			setValues();
		}
	}
}