package
{
	import com.arcticcode.greenFlames.geom.LWPoint;
	import com.arcticcode.greenFlames.graphics.Curves.QuadBez;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BevelFilter;
	import flash.filters.DropShadowFilter;
	[SWF(width=600,height=400,backgroundColor=0xFFFFFF)]
	public class ButterflieCurves extends Sprite
	{
		private var bevel:BevelFilter;
		private var colourInfo:Object = {lineColour:0,lineAlpha:1,thickness:1};
		private var bmd:BitmapData;
		private var b:Bitmap;
		private var bflie:Shape;
		
		public function ButterflieCurves()
		{
			init();
		}
		private function init():void
		{
			bmd = new BitmapData(stage.stageWidth,stage.stageHeight,false,0xffffff);
			b = new Bitmap(bmd);
			addChild(b);
			//
			stage.addEventListener(MouseEvent.CLICK, onStageClick);
		}
		private function onStageClick(e:MouseEvent):void
		{
			bflie = butterflie(Math.random()*0xffffff);
			bflie.x = mouseX;
			bflie.y = mouseY;
			bflie.scaleX = bflie.scaleY = (Math.random()*5);
			bflie.rotation = Math.random()*360-180;
			//addChild(b);
			bmd.draw(bflie,bflie.transform.matrix);
			bflie.graphics.clear();
			bflie = null;
		}
		private function butterflie(colour:uint=0):Shape
		{
			var bf:Shape = new Shape();
			//bf.graphics.lineStyle(0.7,colour);
			//var c:uint=0;
			var points:Array = new Array();
			for(var theta:Number = 0;theta<100*Math.PI;theta+=.1)
			{
				//trace(c);
				var r:Number = (Math.exp(Math.cos(theta)) - 2 * Math.cos(theta*4) + Math.pow(Math.sin(theta/12),5));
				var X:Number = ((r * Math.cos(theta))*6);
				var Y:Number = ((r * Math.sin(theta))*6);
				points.push(new LWPoint(X,Y));
				//if(theta==0)bf.graphics.moveTo(X,Y);
				//else bf.graphics.lineTo(X,Y);
				//c++;
			}
			bf.graphics.lineStyle(1,colour);
			QuadBez.draw(bf.graphics,points,false,false);
			bf.filters = [new BevelFilter(2,45,0xffffff,0.85,0,0.75,2,2,1),new DropShadowFilter(5,20,0,0.85,3,3,1,3)];
			return bf;
		}
	}
}