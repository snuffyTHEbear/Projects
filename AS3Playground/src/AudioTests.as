package
{
	import com.arcticcode.greenFlames.math.Corona;
	import com.arcticcode.greenFlames.sound.objects.AudioObject;
	import com.arcticcode.greenFlames.sound.utils.SoundUtils;
	import com.arcticcode.greenFlames.xPreloader.XPreloader;
	//import arc
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	[SWF(width=800, height = 600, backgroundColor = 0x000000)]
	public class AudioTests extends Sprite
	{
		private var _url:String = "M:/Music/Soundtrack/Game/Valve Soundtracks/Half-Life 2/02 CP Violation.mp3";
		
		private var _loader:XPreloader;
		
		private var _sound:Sound;
		
		private var _channel:SoundChannel;
		
		private var _averagePeak:Number = 0;
		
		private var _audioObject:AudioObject;
		
		/*Stage properties (width, height, centre coordinates)*/
		private var centreX:Number = stage.stageWidth * 0.5;
		
		private var centreY:Number = stage.stageHeight * 0.5;
		
		private var sWidth:Number = stage.stageWidth;
		
		private var sHeight:Number = stage.stageHeight;
		
		/*Corona properties and values*/
		private var angle:Number = 0;
		
		private var radius:Number = 70;
		
		private var innerRadius:Number = 25;
		
		private var total:int = 255;
		
		private var _bitmap:Bitmap;
		
		private var _bmd:BitmapData;
		
		private var _bitmapFilter:BlurFilter;
		
		public function AudioTests()
		{
			stage.scaleMode = "noScale";
			
			init();
		}
		
		private function init():void
		{
			_bmd = new BitmapData(sWidth, sHeight, true, 0x00000000);
			_bitmap = new Bitmap(_bmd);
			addChild(_bitmap);
			_bitmapFilter = new BlurFilter(3, 3, 3);
			
			initLoader();
		}
		
		private function initLoader():void
		{
			_loader = new XPreloader(_url, "mp3", true);
			_loader.addEventListener(Event.COMPLETE, loaded);
		}
		
		private function loaded(e:Event):void
		{
			_sound = _loader.content as Sound;
			_loader.removeEventListener(e.type, loaded);
			_loader = null;
			
			showLength();
		}
		
		private function showLength():void
		{
			//trace(_sound.length);
			//trace(SoundUtils.getTotalMinutes(_sound.length));
			//trace(SoundUtils.getTotalSeconds(_sound.length));
			trace(SoundUtils.parseSoundLength(_sound.length));
			_audioObject = new AudioObject();
			_audioObject.tick();
			_channel = _sound.play();
			_channel.soundTransform.volume = 1.0;
			renderCorona();
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		/*
		 *Abstract to class
		 */
		private function renderCorona():void
		{
			_averagePeak = (_channel.leftPeak + _channel.rightPeak) / 2;
			
			radius = _averagePeak * 150;
			innerRadius = _averagePeak * 30;
			
			graphics.clear();
			//graphics.beginFill(0xcc0000, 0.75);
			graphics.lineStyle(5, _averagePeak * 0xFFFFFF);
			
			//Outer Corona
			angle = Corona.angle(0, 2, total);
			var rawAverage:Number = _audioObject.rawAverage[0];
			//Move position - organically
			var _y:Number = centreY;
			var _x:Number = centreX;
			var xpos:Number = Corona.calculateX(_x, angle, radius, rawAverage, sWidth, 1.0);
			var ypos:Number = Corona.calculateY(_y, angle, radius, rawAverage, sHeight, 1.0);
			graphics.moveTo(xpos, ypos);
			for(var i:uint = 0; i < 256; i++)
			{
				rawAverage = _audioObject.rawAverage[i];
				angle = Corona.angle(i, 2, total);
				xpos = Corona.calculateX(_x, angle, radius, rawAverage, sWidth, 1.0);
				ypos = Corona.calculateY(_y, angle, radius, rawAverage, sHeight, 1.0);
				graphics.lineTo(xpos, ypos);
			}
			rawAverage = _audioObject.rawAverage[0];
			angle = Corona.angle(0, 2, total);
			xpos = Corona.calculateX(_x, angle, radius, rawAverage, sWidth, 1.0);
			ypos = Corona.calculateY(_y, angle, radius, rawAverage, sHeight, 1.0);
			graphics.lineTo(xpos, ypos);
			//Inner Corona
		/*angle = Corona.angle(0, 2, total);
		   rawAverage = _audioObject.rawAverage[0];
		   xpos = Corona.calculateX(centreX, angle, innerRadius, rawAverage, sWidth, 1.0);
		   ypos = Corona.calculateY(centreY, angle, innerRadius, rawAverage, sHeight, 1.0);
		   graphics.moveTo(xpos, ypos);
		   for(i = 0; i < 256; i++)
		   {
		   rawAverage = _audioObject.rawAverage[i];
		   angle = Corona.angle(i, 2, total);
		   xpos = Corona.calculateX(centreX, angle, innerRadius, rawAverage, sWidth, 1.0);
		   ypos = Corona.calculateY(centreY, angle, innerRadius, rawAverage, sHeight, 1.0);
		   graphics.lineTo(xpos, ypos);
		   }
		   rawAverage = _audioObject.rawAverage[0];
		   angle = Corona.angle(0, 2, total);
		   xpos = Corona.calculateX(centreX, angle, innerRadius, rawAverage, sWidth, 1.0);
		   ypos = Corona.calculateY(centreY, angle, innerRadius, rawAverage, sHeight, 1.0);
		 graphics.lineTo(xpos, ypos);*/
		}
		
		private function loop(e:Event):void
		{
			_audioObject.tick();
			renderCorona();
			draw();
		}
		
		private function draw():void
		{
			_bmd.draw(this);
			_bmd.scroll(0, -(_averagePeak * 10));
			_bmd.applyFilter(_bmd, _bmd.rect, new Point(), _bitmapFilter);
			//this.graphics.clear();
		}
	}
}