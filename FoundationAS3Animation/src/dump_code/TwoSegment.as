package{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import robDaniels.greenFlames.src.graphics.Segment;
	import robDaniels.greenFlames.src.graphics.SimpleSlider;
	
	public class TwoSegment extends Sprite{
		
		private var segment0:Segment;
		private var slider0:SimpleSlider;
		private var segment1:Segment;
		private var slider1:SimpleSlider;
		private var cycle:Number = 0;
		private var offset:Number = -Math.PI / 2;
		
		public function TwoSegment(){
			init();
		}
		private function init():void{
			segment0 = new Segment(50, 25);
			addChild(segment0);
			segment0.x = 100;
			segment0.y = 100;
			
			segment1 = new Segment(145,10);
			addChild(segment1);
			segment1.x = segment0.getPin().x;
			segment1.y = segment0.getPin().y;
			
			slider0 = new SimpleSlider(-90, 90, 0);
			addChild(slider0);
			slider0.x = 320;
			slider0.y = 20;
			slider0.visible = false;
			slider0.addEventListener(Event.CHANGE, onChange);
			
			slider1 = new SimpleSlider(-90,90,0);
			addChild(slider1);
			slider1.x = 340;
			slider1.y = 20;
			slider1.visible = false;
			slider1.addEventListener(Event.CHANGE, onChange);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void{
			cycle += .05;
			var angle0:Number = Math.sin(cycle)*45+90;
			var angle1:Number = Math.sin(cycle + offset)*45+45;
			segment0.rotation = angle0;
			segment1.rotation = segment0.rotation + angle1;
			//segment0.rotation = angle;
			//segment1.rotation = segment0.rotation + angle;
			segment1.x = segment0.getPin().x;
			segment1.y = segment0.getPin().y;
		}
		private function onChange(event:Event):void{
			segment0.rotation = slider0.value;
			segment1.rotation = segment0.rotation + slider1.value;
			segment1.x = segment0.getPin().x;
			segment1.y = segment0.getPin().y;
		}
	}
}