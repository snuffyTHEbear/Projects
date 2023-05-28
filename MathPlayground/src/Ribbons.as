package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	[SWF(width=800,height=500,backgroundColor=0xffffff)]
	public class Ribbons extends Sprite
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;	
		private var bmd:BitmapData;
		private var b:Bitmap;
		private var canvas:Sprite;
		private var target:Point;
		private var renderBMD:BitmapData;
		
		public function Ribbons()
		{
			init();
		}
		
		private function init():void
		{
			bmd = new BitmapData(stage.stageWidth, stage.stageHeight, false, 0xffffff);
			b = new Bitmap(bmd);
			addChild(b);
			
			bmd.lock();
			bmd.perlinNoise(bmd.width, bmd.height, 3, Math.random()*1000, false, true, 2 | 3, false, null);
			bmd.unlock();
			
			renderBMD = new BitmapData(200, 200, false, 0xffffff);
			var b2:Bitmap = new Bitmap(renderBMD);
			addChild(b2);
			
			b2.x = centreX - b2.width / 2;
			b2.y = centreY - b2.height / 2;
			
			canvas = new Sprite();
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		private function loop(e:Event):void
		{
			
		}
	}
}