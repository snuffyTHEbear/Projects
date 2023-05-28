package
{
	import com.flashandmath.dg.display.RainDisplay;
	import com.flashandmath.dg.objects.LineRaindrop;
	import com.flashandmath.dg.utils.RainUtils;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import net.hires.debug.Stats;
	
	[SWF(width=640, height = 480, backgroundColor = 0, frameRate = 40)] 
	public class Rain extends Sprite
	{
		private var w:Number = stage.stageWidth;
		private var h:Number = stage.stageHeight;
		private var centreX:Number = w * 0.5;
		private var centreY:Number = h * 0.5;
		private var _timer:Timer;
		private var _rainDisplay:RainDisplay;
		private var _bitmap:Bitmap;
		private var _colorTransform:ColorTransform;
		private var _blur:BlurFilter;
		private var _origin:Point = new Point(0, 0);
		private var _t:Number;
		private var _et:Number;
		private var _stats:Stats;
		
		public function Rain()
		{
			init();
		}
		
		private function init():void
		{			
			_rainDisplay = new RainDisplay(w, h, false);
			setupRainDisplay();
			
			_bitmap = new Bitmap(new BitmapData(w, h));
			addChild(_bitmap);
			
			_stats = new Stats();
			addChild(_stats);
			
			_colorTransform = new ColorTransform(1, 1, 1, 0.8);
			_blur = new BlurFilter(2.0, 2.0);
			
			_timer = new Timer(5, 0);
			_timer.addEventListener(TimerEvent.TIMER, render);
			_timer.start();
		}
		
		private function setupRainDisplay():void
		{
			_rainDisplay.defaultDropColor = 0x666666;
			_rainDisplay.randomizeColor = true;
			_rainDisplay.colorMethod = RainUtils.GRADIENT;
			_rainDisplay.gradientColor1 = Math.random() * 0xFFFFFF;
			_rainDisplay.gradientColor2 = Math.random() * 0xFFFFFF;
			_rainDisplay.defaultDropThickness = 1;
			_rainDisplay.splashThickness = 0.5;
			_rainDisplay.defaultDropAlpha = 0.8;
			_rainDisplay.splashAlpha = 0.8;
			_rainDisplay.wind = new Point(0.5, 0);
			
			_rainDisplay.gravity = 0.1;
			_rainDisplay.defaultInitialVelocity = new Point(0, 6);
			_rainDisplay.initialVelocityVariancePercent = 0.5;
			_rainDisplay.initialVelocityVarianceX = 0;
			_rainDisplay.initialVelocityVarianceY = 0;
			_rainDisplay.dropLength = RainUtils.LONG;
			
			_rainDisplay.splashMaxVelX = .6;
			_rainDisplay.splashMinVelX = -.6;
			_rainDisplay.splashMinVelY = 0.33;
			_rainDisplay.splashMaxVelY = 1.5;
			_rainDisplay.minSplashDrops = 1;
			_rainDisplay.maxSplashDrops = 3;
			
			_rainDisplay.removeDropsOutsideXRange = false;
		}
		
		private function render(e:TimerEvent):void
		{
			_rainDisplay.wind.x += Math.random() * 0.025 - 0.012;
			for(var i:uint = 0; i < 5; i++)
			{
				_rainDisplay.addDrop(-50 + (Math.random() * w), 0).atTerminalVelocity = false;
			}
			
			_rainDisplay.update();
			_bitmap.bitmapData.applyFilter(_bitmap.bitmapData, _bitmap.bitmapData.rect, _origin, _blur);
			_bitmap.bitmapData.colorTransform(_bitmap.bitmapData.rect, _colorTransform);
			_bitmap.bitmapData.draw(_rainDisplay);
		}
	}
}