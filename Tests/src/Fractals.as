package
{
	import com.arcticcode.greenFlames.graphics.ColourUtils;
	
	import flash.display.Sprite;
	[SWF(width=600,height=400,backgroundColor=0xFFFFFF)]
	public class Fractals extends Sprite
	{
		private var X:Number = stage.stageWidth*0.5;
		private var Y:Number = stage.stageHeight;
		private var L:Number = 100;
		private var A:Number = -Math.PI/2;
		private var W:Number = 8;
		private static const maxBranch:uint =4;
		private static const maxAngle:Number = (3 * Math.PI / 4);
		private static const maxWidth:Number = 8;
		
		public function Fractals()
		{
			init();
		}
		private function init():void
		{
			/*for(var i:uint = 0;i<100;i++)
			{
				branch(X,Y,L,A,W);
				L *= 0.8;
				A += Math.PI/16;
				W--;
			}*/
			branch(X,Y,L,A,W);
		}
		private function branch(startX:Number,startY:Number,length:Number,angle:Number,width:Number):void
		{
			if(width > 0)
			{
				graphics.lineStyle(width,0,1);
				graphics.moveTo(startX,startY);
				var xPos:Number = startX + length * Math.cos(angle);
				var yPos:Number = startY + length * Math.sin(angle);
				graphics.lineTo(xPos,yPos);
				//X = xPos;
				//Y = yPos;
				
				var sub:Number = (Math.random() * maxBranch - 1 + 2);
				var len:Number = 0.5 + Math.random() / 2;
				for(var j:Number=0;j<sub;j++)
				{
					var newLen:Number = length * len;
					var newAng:Number = angle + Math.random() * maxAngle - maxAngle / 2;
					var newWid:Number = width - 1;
					branch(xPos,yPos,newLen,newAng,newWid);
				}				
			}
		}
	}
}