package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class PerlinShapes extends Sprite
	{
		private var bmd:BitmapData;
		private var bmd2:BitmapData;
		private var b:Bitmap;
		private var shape:Shape;
		private var centreX:Number = stage.stageWidth*0.5;
		private var centreY:Number = stage.stageHeight*0.5;
		private var wid:Number=600;
		private var hei:Number=400;
		
		public function PerlinShapes()
		{
			init();
		}
		private function init():void
		{
			shape = new Shape();
			bmd = new BitmapData(wid/4,hei/4,false,0xffffff);
			//bmd.perlinNoise(wid/4,hei/4,3,Math.random()*1000,false,true,7,false,null);
			bmd2 = new BitmapData(wid,hei,false,0xffffff);
			b = new Bitmap(bmd2);
			addChild(b);
			//addChild(shape);
			
			stage.addEventListener(MouseEvent.CLICK, onClick);
		}
		private function onClick(e:MouseEvent):void
		{
			bmd2.fillRect(bmd2.rect,0xffffff);
			//bmd.perlinNoise(wid/2,hei/2,4,Math.random()*1000,false,true,1|2|3,false,null);
			bmd.noise(Math.random()*1000,0,255,2|4);
			stage.removeEventListener(MouseEvent.CLICK, onClick);
			process();
		}
		private function process():void
		{
			var val:Number=0;
			var i:uint=0;
			var j:uint=0;
			var cx:Number=0;
			var cy:Number = 0;
			var xOff:Number = (centreX - bmd.width/2);
			var yOff:Number = (centreY - bmd.height/2);
			
			for(i=0;i<wid/4;i++)
			{
				for(j=0;j<hei/4;j++)
				{
					val = bmd.getPixel(i,j);
					cx = (i+xOff)*2 - wid /2;
					cy = (j+yOff)*2 - hei /2;
					shape.graphics.clear();
					shape.graphics.lineStyle(0,val,1);
					shape.graphics.moveTo(wid-i*4,hei-j*4);
					shape.graphics.curveTo(cx,cy,i*4,j*4);
					//val/=10000000;
					//shape.graphics.moveTo(xOff,yOff);
					//shape.graphics.curveTo(wid,hei,i+xOff,j+yOff);
					//shape.graphics.curveTo(Math.random()*wid,Math.random()*hei,cx,cy);
					//trace(val);
					//shape.graphics.clear();
					//shape.graphics.lineStyle(0,b2.bitmapData.getPixel(i,j),0.75);
					//shape.graphics.beginFill(bmd.getPixel(i,j));
					//shape.graphics.drawCircle(i,j,val*2);
					//shape.graphics.endFill();
					//shape.graphics.drawRect(i,j,val,val);
					//shape.graphics.clear();
					//shape.graphics.moveTo(i,j);
					//shape.graphics.lineStyle(0,b2.bitmapData.getPixel(i,j));
					//shape.graphics.lineTo(i,j);
					//shape.graphics.drawCircle(i,j,val);
					//shape.graphics.curveTo(i+5,j+5,i,j);
					//shape.x = i;
					//shape.y = j;
					bmd2.draw(shape,shape.transform.matrix);
				}
			}
			
			stage.addEventListener(MouseEvent.CLICK, onClick);
		}
	}
}