package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class CantorCheeseCrossSections extends Sprite
	{
		private var centY:Number = stage.stageHeight*0.5;
		public function CantorCheeseCrossSections()
		{
			init();
		}
		private function init():void
		{
			//cantor();
			stage.addEventListener(MouseEvent.CLICK, onClick);
		}
		private function onClick(e:MouseEvent):void
		{
			graphics.clear();
			cantor();
		}
		private function cantor():void
		{
			var midpoints:Array = new Array();
			midpoints[0] = stage.stageWidth*0.5;
			var count:uint = 0;
			var radius:Number = 200;
			var frac:Number = 1;
			graphics.beginFill(Math.random()*0xffffff,0.85);
			graphics.drawCircle(midpoints[count],centY,radius);
			graphics.endFill();
			for(var i:uint=0;i<10;i++)
			{
				var bot:Number = Math.pow(2,i);
				var top:Number = Math.pow(2,(i+1))-1;
				radius/=2
				var l:Number = radius;
				for(var j:Number=bot-1;j<top;j++)
				{
					graphics.beginFill(Math.random()*0xffffff,0.85);
					midpoints[count+1] = midpoints[j] - frac*l;
					graphics.drawCircle(midpoints[count+1],centY,radius);
					midpoints[count+2] = midpoints[j] + frac*l;
					graphics.drawCircle(midpoints[count+2],centY,radius);
					graphics.endFill();
					count+=2;
				}
			}
		}
	}
}