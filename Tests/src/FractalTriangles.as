package
{
	import flash.display.Shape;
	import flash.display.Sprite;
	
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class FractalTriangles extends Sprite
	{
		private var centreX:Number = stage.stageWidth*0.5;
		private var centreY:Number = stage.stageHeight*0.5;
		private var count:uint=0;
		private var obj:Object = {x:0,y:0,w:0,h:0,r:0};
		
		public function FractalTriangles()
		{
			init();
		}
		private function init():void
		{
			drawTriangle(centreX,centreY,75,50,0);
			drawTris(centreX,centreY,75,50,0);
		}
		private function drawTris(x:Number,y:Number,w:Number,h:Number,r:Number):void
		{
			drawTriangle(x-(w/2),y,w/2,h/2,r-90);
			drawTriangle(x,y-h,w/2,h/2,r);
			drawTriangle(x+(w/2),y,w/2,h/2,r+90);
		}
		private function drawTriangle(x:Number,y:Number,w:Number,h:Number,r:Number):void
		{
			var s:Shape = new Shape();
			s.graphics.lineStyle(0,0,1);
			s.graphics.moveTo(0,-h);
			s.graphics.lineTo(w/2,0);
			s.graphics.lineTo(-w/2,0);
			s.graphics.lineTo(0,-h);
			s.x = x;
			s.y = y;
			addChild(s);
			s.rotation = r;
		}
	}
}