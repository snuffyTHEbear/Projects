package{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import robDaniels.greenFlames.src.graphics.Segment;
	
	public class DraggingSegments extends Sprite{
		
		private var numSegments:Number = 10;
		private var segments:Array;
		private var gravity:Number = 7;
		
		public function DraggingSegments(){
			init();
		}
		private function init():void{
			segments = new Array();
			for(var i:uint = 0; i<numSegments; i++)
			{
				var segment:Segment = new Segment(25, 10);
				addChild(segment);
				segments.push(segment);	
			}
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void{
			drag(segments[0], mouseX, mouseY);
			for(var i:uint = 1; i<numSegments;i++)
			{
				var segmentA:Segment = segments[i];
				var segmentB:Segment = segments[i-1];
				drag(segmentA, segmentB.x, segmentB.y);
			}
		}
		private function drag(segment:Segment, xPos:Number, yPos:Number):void{
			var dx:Number = xPos - segment.x;
			var dy:Number = yPos - segment.y;
			var angle:Number = Math.atan2(dy, dx);
			segment.rotation = angle * 180 / Math.PI;
			
			var w:Number = segment.getPin().x - segment.x;
			var h:Number = segment.getPin().y - segment.y;
			segment.x = xPos - w;
			segment.y = yPos - h;
			segment.y+=gravity;
		}
	}
}