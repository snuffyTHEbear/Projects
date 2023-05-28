package
{
	import com.arcticcode.greenFlames.Math.MathUtils;
	import com.arcticcode.greenFlames.geom.LWPoint;
	import com.arcticcode.greenFlames.graphics.Curves.QuadBez;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.filters.BevelFilter;
	import flash.filters.BlurFilter;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.utils.Timer;
	[SWF(width=600,height=400,backgroundColor=0xFFFFFF)]
	public class ButterflieCurves2 extends Sprite
	{
		private var bevel:BevelFilter;
		private var colourInfo:Object = {lineColour:0,lineAlpha:1,thickness:1};
		private var bmd:BitmapData;
		private var b:Bitmap;
		private var bflie:Shape;
		private var timer:Timer;
		private var oldPoint:LWPoint = new LWPoint(mouseX,mouseY);
		
		public function ButterflieCurves2()
		{
			init();
		}
		private function init():void
		{
			bmd = new BitmapData(stage.stageWidth,stage.stageHeight,false,0xffffff);
			b = new Bitmap(bmd);
			addChild(b);
			//
			timer = new Timer(10);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
		}
		private function onKey(e:KeyboardEvent):void
		{
			if(timer.running)
			{
				timer.stop();
			}
			else
			{
				timer.start();
			}
		}
		private function onTimer(e:TimerEvent):void
		{
			bflie = butterflie(Math.random()*0xffffff);
			bflie.x = oldPoint.x;
			bflie.y = oldPoint.y;
			bflie.scaleX = bflie.scaleY = (Math.random()*5);
			//bflie.rotation = Math.random()*360-180;
			bflie.rotation = MathUtils.distanceToDegrees(mouseX,mouseY,bflie.x,bflie.y);
			//addChild(b);
			bmd.draw(bflie,bflie.transform.matrix);
			bflie.graphics.clear();
			bflie = null;
			oldPoint.x = mouseX;
			oldPoint.y = mouseY;
			//bmd.applyFilter(bmd,bmd.rect,new Point(),new BlurFilter(2,2,1));
			//e.updateAfterEvent();
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