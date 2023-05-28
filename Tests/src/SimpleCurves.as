package
{
	import com.arcticcode.greenFlames.geom.LWPoint;
	import com.arcticcode.greenFlames.graphics.Curves.QuadBez;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class SimpleCurves extends Sprite
	{
		private var curve:Shape;
		private var points:Array;
		private var bmd:BitmapData;
		private var b:Bitmap;
		private var xIncr:Number=0;
		
		public function SimpleCurves()
		{
			init();
		}
		private function init():void
		{
			points = new Array();
			curve = new Shape();
			curve.x = -10;
			//addChild(curve);
			
			bmd = new BitmapData(stage.stageWidth,stage.stageHeight,false,0xffffff);
			b = new Bitmap(bmd);
			b.opaqueBackground = true;
			addChild(b);
						
			points[0] = new LWPoint(0,0);
			points[1] = new LWPoint(Math.random()*10+4,stage.stageHeight/4);
			points[2] = new LWPoint(0,stage.stageHeight/2);
			points[3] = new LWPoint((Math.random()*-10-4),(stage.stageHeight/4)*3);
			points[4] = new LWPoint(0,stage.stageHeight);
			points[5] = new LWPoint(Math.random()*10+4,stage.stageHeight+50);
						
			for(var i:uint=0;i<500;i++)
			{
				xIncr = Math.random()*10+2;
				curve.x += (xIncr/2);
				curve.graphics.clear();
				curve.graphics.lineStyle(xIncr,Math.random()*0xffffff);
				QuadBez.draw(curve.graphics,points,false,false);
				
				bmd.draw(curve,curve.transform.matrix);
			}
			
		}
	}
}