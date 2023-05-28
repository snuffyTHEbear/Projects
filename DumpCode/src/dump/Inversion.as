package
{
	import com.arcticcode.greenFlames.geom.LWPoint;
	
	import flash.display.Sprite;
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class Inversion extends Sprite
	{
		private var cp:LWPoint;
		private var bool:Boolean = true;
		
		public function Inversion()
		{
			init();
		}
		private function init():void
		{
			cp = new LWPoint(stage.stageWidth*0.5,stage.stageHeight*0.5);
			graphics.lineStyle(0,0,1);
			graphics.drawCircle(cp.x,cp.y,5);
			
			graphics.clear();
			graphics.beginFill(0,0.75);
			graphics.drawCircle(cp.x,cp.y,50);
			
			graphics.moveTo(5,5);
			graphics.drawRoundRectComplex(5,5,50,50,10,10,5,5);
			
			bool ? trace("true") : trace("false");
		}
		private function inver(p:LWPoint):void
		{
			
		}
	}
}