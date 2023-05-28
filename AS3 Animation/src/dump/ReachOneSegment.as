package{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	import robDaniels.greenFlames.src.graphics.Segment;
	
	public class ReachOneSegment extends Sprite{
		private var numSegments:Number = 6;
		private var segments:Array;
		private var ball:CreateCircle;
		private var gravity:Number = 0.5;
		private var bounce:Number = -0.9;
		public function ReachOneSegment(){
			init();
		}
		private function init():void{
			ball = new CreateCircle();
			ball.vx = 10;
			addChild(ball);
			segments = new Array();
			for(var i:uint = 0;i<numSegments;i++)
			{
				var segment:Segment = new Segment(25, 10, Math.random()*0xffffff);
				addChild(segment);
				segments.push(segment);
			}
			segment.x = stage.stageWidth / 2;
			segment.y = stage.stageHeight / 2;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void{
			moveBall();
			var target:Point = reach(segments[0], ball.x, ball.y);
			for(var i:uint = 1;i<numSegments; i++)
			{		
				var segment:Segment = segments[i];
				target = reach(segment, target.x, target.y);
			}
			for(i = numSegments - 1;i>0;i--)
			{
				var segmentA:Segment = segments[i];
				var segmentB:Segment = segments[i-1];
				position(segmentB, segmentA);
			}
			checkHit();
		}
		private function reach(segment:Segment, xPos:Number, yPos:Number):Point{
			var dx:Number = xPos - segment.x;
			var dy:Number = yPos - segment.y;
			var angle:Number = Math.atan2(dy,dx);
			segment.rotation = angle * 180 / Math.PI;
			
			var w:Number = segment.getPin().x - segment.x;
			var h:Number = segment.getPin().y - segment.y;
			var tx:Number = xPos - w;
			var ty:Number = yPos - h;
			return new Point(tx, ty);
		}
		private function position(segmentA:Segment, segmentB:Segment):void{
			segmentA.x = segmentB.getPin().x;
			segmentA.y = segmentB.getPin().y;
		}
		private function moveBall():void{
			ball.vy += gravity;
			ball.x += ball.vx;
			ball.y += ball.vy;
			if(ball.x + ball.radius > stage.stageWidth)
			{
			ball.x = stage.stageWidth - ball.radius;
			ball.vx *= bounce;
			}
			else if(ball.x - ball.radius < 0)
			{
			ball.x = ball.radius;
			ball.vx *= bounce;
			}
			if(ball.y + ball.radius > stage.stageHeight)
			{
			ball.y = stage.stageHeight - ball.radius;
			ball.vy *= bounce;
			}
			else if(ball.y - ball.radius < 0)
			{
			ball.y = ball.radius;
			ball.vy *= bounce;
			}
		}
		private function checkHit():void{
			var segment:Segment = segments[0];
			var dx:Number = segment.getPin().x - ball.x;
			var dy:Number = segment.getPin().y - ball.y;
			var distance:Number = Math.sqrt(dx * dx + dy * dy);
			if(distance < ball.radius)
			{
				ball.vx += Math.random() * 2 - 1;
				ball.vy -= 1;
			}
		}
	}
}