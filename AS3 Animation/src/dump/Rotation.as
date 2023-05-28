package{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import robDaniels.greenFlames.src.graphics.CreateRect;
	
	public class Rotation extends Sprite{
		
		private var output:TextField;
		private var mySquare:CreateRect;
		private var mySquare2:CreateRect;
		private var amount:uint = 1;
		private var amount2:Number = 0;		
		
		public function Rotation(){
			init();
		}
		private function init():void{
			
			output = new TextField();
			addChild(output);
			output.x = output.y = 0;
			output.autoSize = TextFieldAutoSize.LEFT;
			
			mySquare = new CreateRect(0xff0000,0.5);
			addChild(mySquare);
			mySquare.x = stage.stageWidth / 2;
			mySquare.y = stage.stageHeight / 2; 
			mySquare2 = new CreateRect(0xFF6600,0.5);
			addChild(mySquare2);
			mySquare2.x = stage.stageWidth / 2;
			mySquare2.y = stage.stageHeight / 2;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void{
			
			output.text = "Amount: " + amount + "\n" + "Amount2: " + amount2;
			
			mySquare.rotation +=amount2;
			mySquare2.rotation -= amount2;
			amount2 = amount2 + amount;
		}
	}
}