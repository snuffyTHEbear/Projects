package
{
	import com.arcticcode.greenFlames.utils.DisplayUtils;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;

	public class IkedaAttractor extends Sprite
	{
		private var c1:Number = 0.4;
		private var c2:Number = 0.9;
		private var c3:Number = 6.0;
		private var rho:Number = 1.0;
		private var bmd:BitmapData;
		private var b:Bitmap;
		private var cont:Sprite;
		
		public function IkedaAttractor()
		{
			init();
		}
		private function init():void
		{
			bmd = new BitmapData(stage.stageWidth,stage.stageHeight,false,0xFFFFFF);
			b = new Bitmap(bmd);
			addChild(b);
			
			cont = new Sprite();
			DisplayUtils.doCentreOne(cont,stage.stageWidth,stage.stageHeight);
			
			ikeda();
		}
		private function ikeda():void
		{
			var xPos:Number = 0.1;
			var yPos:Number = 0.1;
			cont.graphics.clear();
			cont.graphics.lineStyle(0,0,1);
			for(var i:uint=0;i<3000;i++)
			{
				var temp:Number = c1 - c3 / (1 + xPos * xPos + yPos * yPos);
				var sinTemp:Number = Math.sin(temp);
				var cosTemp:Number = Math.cos(temp);
				var xTemp:Number = rho + c2 * (xPos * cosTemp - yPos * sinTemp);
				yPos = (c2 * (xPos * sinTemp + yPos * cosTemp)) * 1+20;
				xPos = xTemp * 1+20;
				//bmd.setPixel(xPos,yPos,0);
				cont.graphics.lineTo(xPos,yPos);
				bmd.draw(cont,cont.transform.matrix);
			}
		}
	}
}