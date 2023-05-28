package
{
	import caurina.transitions.Tweener;
	
	import com.arcticcode.greenFlames.geom.LWPoint;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;

	public class PixelTweens extends Sprite
	{
		private var b:Bitmap;
		private var bmd:BitmapData;
		private var point:LWPoint;
		private var target:LWPoint;
		private var oldPoint:LWPoint;
		
		public function PixelTweens()
		{
			init();
		}
		private function init():void
		{
			bmd = new BitmapData(100,100,false,0xFFFFFF);
			b = new Bitmap(bmd);
			b.x = stage.stageWidth * 0.5 - b.width * 0.5;
			b.y = stage.stageHeight * 0.5 - b.height * 0.5;
			addChild(b);
			
			point = new LWPoint(Math.random()*100,Math.random()*100);
			target = new LWPoint(Math.random()*100,Math.random()*100);
			oldPoint = new LWPoint();
			
			Tweener.addTween(point,{x:target.x,y:target.y,time:1,onUpdate:draw,onComplete:tween});
		}
		private function tween():void
		{
			target.x = Math.random()*100;
			target.y = Math.random()*100;
			Tweener.addTween(point,{x:target.x,y:target.y,time:1,onUpdate:draw,onComplete:tween});
		}
		private function draw():void
		{
			bmd.setPixel(oldPoint.x,oldPoint.y,0xFFFFFF);
			bmd.setPixel(point.x,point.y,0);
			oldPoint.x = point.x;
			oldPoint.y = point.y;
		}
	}
}