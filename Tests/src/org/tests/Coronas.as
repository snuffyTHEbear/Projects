package org.tests
{
	import com.arcticcode.greenFlames.math.Corona;
	import com.arcticcode.greenFlames.sound.objects.AudioObject;
	import com.arcticcode.greenFlames.xPreloader.XPreloader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.ConvolutionFilter;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.Timer;
	
	import flashx.textLayout.conversion.ConversionType;
	
	public class Coronas extends Sprite
	{
		private var _sound:Sound;
		private var _channel:SoundChannel;
		private var _audioObject:AudioObject;
		private var _corona:Sprite;
		private var centreX:Number;
		private var centreY:Number;
		private var _audioLoader:XPreloader;
		private var _bitmap:Bitmap;
		
		public function Coronas()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(e.type, init);
			
			centreX = stage.stageWidth * 0.5;
			centreY = stage.stageHeight * 0.5;
			
			_corona = addChild(new Sprite()) as Sprite;
			_corona.x = 0;//stage.stageWidth * 0.5;
			_corona.y = 0;//stage.stageHeight * 0.5;
			
			setupLoader();
		}
		
		private function setupLoader():void
		{
			_audioLoader = new XPreloader("http://arctic-code.com/dump/JI.mp3");
			_audioLoader.addEventListener(ProgressEvent.PROGRESS, loaderProgress);
			_audioLoader.addEventListener(Event.COMPLETE, loaderComplete);
		}
		
		private function loaderProgress(e:ProgressEvent):void
		{
			_corona.graphics.clear();
			_corona.graphics.beginFill(0xc3c3c3, 1);
			_corona.graphics.drawRect(-50, -2, e.bytesLoaded / e.bytesTotal * 100, 4);
			_corona.graphics.endFill();
		}
		
		private function loaderComplete(e:Event):void
		{
			_corona.graphics.clear();
			setupCorona();
		}
		
		private function setupCorona():void
		{
			_audioObject = new AudioObject();
			_sound = _audioLoader.content as Sound;
			_channel = _sound.play();
			
			_corona.x = _corona.y = 0;
			//removeChild(_corona);
			
			//_bitmap = addChild(new Bitmap(new BitmapData(stage.stageWidth, stage.stageHeight, false, 0))) as Bitmap;
			
			var timer:Timer = new Timer(25);
			timer.addEventListener(TimerEvent.TIMER, tick);
			timer.start();
		}
		
		private function tick(e:TimerEvent):void
		{
			_audioObject.tick();
			draw();
			e.updateAfterEvent();
		}
		
		private function draw():void
		{
			_corona.graphics.clear();
			_corona.graphics.lineStyle(0);
			_corona.rotationY+= Math.sin((_channel.rightPeak + _channel.leftPeak) / 2) * 75;
			var i:uint = 0;
			var len:uint = _audioObject.rawAverage.length;
			var angle:Number = Corona.angle(0, 2, len);
			var rawAv:Number = _audioObject.rawAverage[0];
			var rad:Number = 60;//Math.sin((_channel.leftPeak + _channel.rightPeak) / 2) * 120;
			_corona.graphics.moveTo(Corona.calculateX(centreX, angle, rad, rawAv, stage.stageWidth, 1),
									Corona.calculateY(centreY, angle, rad, rawAv, stage.stageHeight, 1));
			for(i=1;i<len;i++)
			{
				rawAv = _audioObject.rawAverage[i];
				angle = Corona.angle(i, 2, len);
				_corona.graphics.lineTo(Corona.calculateX(centreX, angle, rad, rawAv, stage.stageWidth, 1),
										Corona.calculateY(centreY, angle, rad, rawAv, stage.stageHeight, 1));
			}
			
			rawAv = _audioObject.rawAverage[0];
			angle = Corona.angle(0, 2, len);
			_corona.graphics.lineTo(Corona.calculateX(centreX, angle, rad, rawAv, stage.stageWidth, 1),
				Corona.calculateY(centreY, angle, rad, rawAv, stage.stageHeight, 1));
			
			//_bitmap.bitmapData.fillRect(_bitmap.bitmapData.rect, 0);
			//_bitmap.bitmapData.draw(_corona);
			
		}
	}
}