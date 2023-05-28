package
{
	import com.arcticcode.greenFlames.geom.LWPoint3D;
	import com.arcticcode.greenFlames.isometric.core.IsometricEngine;
	import com.arcticcode.greenFlames.isometric.math.IsoMath;
	import com.arcticcode.greenFlames.isometric.view.BaseIsometricView;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	
	[SWF(width=640,height=480,backgroundColor=0xffffff,frameRate=60)]
	public class LiveRendering extends BaseIsometricView
	{
		private var angleIncr:Number = 0;	
		private var bmd:BitmapData;
		private var b:Bitmap;
		private var cont:Sprite;
		
		public function LiveRendering()
		{
			super.init();
		}
		override protected function init():void
		{
			engine = new IsometricEngine(null, centreX,centreY,IsometricEngine.RIGHT,true,true,false);
			
			bmd = new BitmapData(stage.stageWidth,stage.stageHeight,true,0x00ffffff);
			b = new Bitmap(bmd, PixelSnapping.NEVER, false);
			addChild(b);
			b.filters = [new DropShadowFilter(1,90,0,1,3,3,0.85,3,false,false,false)];
			
			cont = new Sprite();
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		override protected function onEnterFrame(e:Event):void
		{
			
		}
	}
}