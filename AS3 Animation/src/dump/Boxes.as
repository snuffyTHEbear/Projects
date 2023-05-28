package{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import robDaniels.greenFlames.src.graphics.CreateRect;
	
	public class Boxes extends Sprite{
		
		private var box:CreateRect;
		private var boxes:Array;
		private var gravity:Number = 0.5;
		
		public function Boxes(){
			init();
		}
		private function init():void{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			boxes = new Array();
			createBox();
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void{
			box.vy += gravity;
			box.y += box.vy;
			if(box.y + box.height / 2 > stage.stageHeight)
			{
				box.y = stage.stageHeight - box.height / 2;
				createBox();
			}
			for(var i:uint = 0; i < boxes.length; i++)
			{
				if(box != boxes[i] && box.hitTestObject(boxes[i]))
				{
					box.y = boxes[i].y - boxes[i].height / 2 - box.height / 2;
					createBox();
				}
			}
		}
		private function createBox():void{
			box = new CreateRect(Math.random()* 40 +10, Math.random()*40 +10, Math.random()*0xffffff, Math.random()+0.5);
			box.x = Math.random() * (stage.stageWidth - 60) + 60;
			addChild(box);
			boxes.push(box);
		}
	}
}