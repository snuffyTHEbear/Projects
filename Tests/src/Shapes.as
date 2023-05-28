package
{
	import com.arcticcode.greenFlames.graphics.Polygon;
	import com.arcticcode.greenFlames.graphics.dashTo;
	
	import flash.display.Sprite;
	
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class Shapes extends Sprite
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;	
		
		public function Shapes()
		{
			init();
		}
		private function init():void
		{
			this.graphics.lineStyle(1,0);
			//this.graphics["lineStyle"](1,0);
			dashTo.draw(this.graphics,5,5,200,5,1,2);
			
			/*
			this.graphics.beginFill(Math.random()*0xffffff);
			Polygon.draw(this.graphics,centreX,centreY,12,100);
			this.graphics.endFill();
			*/
		}
	}
}