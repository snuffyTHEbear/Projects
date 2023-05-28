package
{
	import com.arcticcode.greenFlames.utils.DisplayUtils;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.geom.Point;

	public class NoiseTests extends Sprite
	{
		private var bmd:BitmapData;
		private var b:Bitmap;
		private var val:Number = 0;
		
		public function NoiseTests()
		{
			init();
		}
		private function init():void
		{
			bmd = new BitmapData(stage.stageWidth,stage.stageHeight,false,0xFF000000);
			b = new Bitmap(bmd);
			//DisplayUtils.doCentreOne(b,stage.stageWidth,stage.stageHeight);
			addChild(b);
			
			bmd.noise(1000,128,255,1,true);
			//bmd.applyFilter(bmd,bmd.rect,new Point(),new BlurFilter(30,1,3));
			addEventListener(Event.ENTER_FRAME, onEF);
		}
		private function onEF(e:Event):void
		{
			bmd.noise(val,128,255,1,true);
			//bmd.applyFilter(bmd,bmd.rect,new Point(),new BlurFilter(30,1,3));
			val++;
		}
	}
}