package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width=640, height = 520, backgroundColor = 0x000000)]
	public class CoronaTests extends Sprite
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		
		private var centreY:Number = stage.stageHeight * 0.5;
		
		private var w:Number = stage.stageWidth;
		
		private var h:Number = stage.stageHeight;
		
		private var total:uint = 256;
		
		private var inc:uint = 0;
		
		private var angle:Number = 0;
		
		private var firstVal:Number = 0;
		
		private var first:Boolean = true;
		
		private var val:Number = 0;
		
		private var radius:Number = 100;
		
		private var canvas:Sprite = new Sprite();
		
		public function CoronaTests()
		{
			init();
		}
		
		private function init():void
		{
			addChild(canvas);
			
			setupCanvas();
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function setupCanvas():void
		{
			canvas.graphics.clear();
			canvas.graphics.lineStyle(1, 0xffffff, 1);
			canvas.graphics.moveTo(calculateX(angle, val), calculateY(angle, val));
		}
		
		private function loop(e:Event):void
		{
			inc += 1;
			angle = inc * 2 * Math.PI / total;
			val = Math.random() / 2;
			if(first)
			{
				firstVal = val;
				first = false;
			}
			else if(!first && inc == total - 1)
			{
				val = firstVal;
				first = true;
			}
			if(inc > total)
			{
				//removeEventListener(Event.ENTER_FRAME, loop);
				radius -= 10;
				total -= 10;
				inc = 0;
				angle = inc * 2 * Math.PI / total;
				canvas.graphics.moveTo(calculateX(angle, val), calculateY(angle, val));
				return;
				setupCanvas();
				inc = 0;
				angle = inc * 2 * Math.PI / total;
			}
			
			canvas.graphics.lineStyle(5, (radius + val) * ((val / total) * 1000000));
			canvas.graphics.lineTo(calculateX(angle, val, 1.0), calculateY(angle, val, 1.0));
		/* canvas.graphics.lineStyle(null);
		   canvas.graphics.beginFill((radius + val) * 1000000);
		 canvas.graphics.drawCircle(calculateX(angle, val, 1.0), calculateY(angle, val, 1.0),1); */
		}
		
		private function calculateX(angle:Number, value:Number, scale:Number = 1.0):Number
		{
			return centreX + Math.cos(angle) * (radius * (1 + scale) + val * w * 0.1);
		}
		
		private function calculateY(angle:Number, value:Number, scale:Number = 1.0):Number
		{
			return centreY + Math.sin(angle) * (radius * (1 + scale) + val * h * 0.1);
		}
	}
}