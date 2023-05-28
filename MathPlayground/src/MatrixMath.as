package
{
	import com.arcticcode.greenFlames.graphics.CreateRect;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	
	[SWF(width=640,height=480,backgroundColor=0xffffff)]
	public class MatrixMath extends Sprite
	{
		private var matrix:Matrix;
		private var square:CreateRect;
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;	
		
		public function MatrixMath()
		{
			init();
		}
		
		private function init():void
		{
			square = new CreateRect(50,50,true,false,0,1,false,0,0);
			addChild(square);
			square.move(centreX,centreY);
			
			matrix = square.transform.matrix;
		}
	}
}