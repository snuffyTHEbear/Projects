package
{
	import com.arcticcode.greenFlames.utils.DisplayUtils;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class NumberTests extends Sprite
	{
		private var bmd:BitmapData;
		private var b:Bitmap;
		private var cont:Shape;
		
		public function NumberTests()
		{
			cont = new Shape();
			DisplayUtils.doCentreOne(cont,stage.stageWidth,stage.stageHeight);
			addChild(cont);
			
			cont.graphics.beginFill(0,1);
			//MandelbrotSet();
		}
		private function MandelbrotSet():void
		{
			for(var X:Number=-200;X<200;X+=1)
			{
				for(var Y:Number=-200;Y<200;Y+=1)
				{
					var cr:Number=X;
					var ci:Number=Y;
					var rx:Number=0;
					var ry:Number=0;
					for(var k:Number=0;k<60;k++)
					{
						var newx:Number = rx*rx - ry*ry + cr;
						ry = 2*rx*ry+ci;
						rx = newx;
						if(((rx-cr)+(ry-ci))>4)break;
					}
					if((k%2)==0)cont.graphics.drawCircle(X,Y,1);
				}
			}
		}
		private function partitionGraph():void
		{
			var start:Number = 0;
			var stop:Number = 300;
			var scale:Number = 100/stop;
			for(var i:uint=start;i<stop;i++)
			{
				var looptop:Number = i/2+1;
				for(var j:uint=1;j<looptop;j++)
				{
					var sum:Number = 0;
					var top:Number = j;
					sum = again(sum,top);
					if(sum<i)
					{
						sum = again(sum,top);
					}
					else if(sum==i)
					{
						trace(i,j,top-1);
						for(var k:uint = j;k<top-1;k++)
						{
							graphics.drawCircle(i*scale,k*scale,1);
						}
					}
				}
			}
			
			function again(sum:Number,top:Number):Number
			{
				return sum+top;
			}
		}
		private function pairSquare1():void
		{
			//?
			for(var i:uint=0;i<31;i++)
			{
				for(var j:uint=0;i<22;i++)
				{
					var b:Number = i + 2 * j;
					var n:Number = (b*b - i*i)/2;
					//if(n>1000)break;
					var p:Number = (b*b - i*i)/2;
					trace(p,n);
				}
			}
		}
	}
}