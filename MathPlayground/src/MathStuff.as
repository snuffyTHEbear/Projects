package
{
	import com.arcticcode.greenFlames.math.MathUtils;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width=640,height=480,backgroundColor=0xffffff)]
	public class MathStuff extends Sprite
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;
		private var radius:Number = 50;
		private var angle:Number = 0;
		
		public function MathStuff()
		{
			init();
		}
		private function init():void
		{
			addEventListener(Event.ENTER_FRAME, loop);
		}
		private function pie(val:Number,startVal:Number,cx:Number,cy:Number):void
		{
			var radians:Number = MathUtils.degreesToRadians(val);
			var inc:Number = radians / val;
			graphics.moveTo(cx,cy);
			graphics.lineTo(Math.cos(startVal)*radius+cx,Math.sin(startVal)*radius+cy);
			for(var i:Number=0;i<radians;i+=inc)
			{
				graphics.lineTo(Math.cos(i)*radius+cx,Math.sin(i)*radius+cy);
			}
			graphics.lineTo(cx,cy);
		}
		private function loop(e:Event):void
		{
			graphics.clear();
			graphics.lineStyle(3,0);
			pie(MathUtils.distanceToDegrees(mouseX,centreX,mouseY,centreY),0,0,0)
			/* pie(angle/100*360);
			angle += 1;
			if(angle >= (100))
			{
				angle = 0;
			} */
		}
	}
}