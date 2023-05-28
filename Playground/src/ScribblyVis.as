package 
{
	import com.arcticcode.greenFlames.geom.LWPoint;
	import com.arcticcode.greenFlames.math.Corona;
	import com.arcticcode.greenFlames.sound.objects.AudioObject;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Transform;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.ByteArray;
	
	import hype.extended.rhythm.FilterRhythm;
	import hype.framework.core.TimeType;
	import hype.framework.display.BitmapCanvas;
	
	[SWF(width=1100, height = 700, backgroundColor = 0)]
	public class ScribblyVis extends Sprite
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		
		private var centreY:Number = stage.stageHeight * 0.5;
		
		private var w:Number = stage.stageWidth;
		
		private var h:Number = stage.stageHeight;
		
		private var bmd:BitmapData;
		
		private var filterRhythm:FilterRhythm;
		
		private var canvas:BitmapCanvas;
		
		private var b:Bitmap;
		
		private var cont:Sprite;
		
		[Embed(source="../assets/Daedelus_FairWeatherFriends", mimeType = "audio/mpeg")]
		private var audioFile:Class;
		
		private var sound:Sound;
		
		private var channel:SoundChannel;
		
		private var scale:Number = 0;
		
		private var val2:Number = 0;
		
		private var color2:uint = uint(Math.random() * 256) << 16 | uint(Math.random() * 256) << 8 | uint(Math.random() * 256);
		
		private var angle:Number = 0;
		
		private var audio:AudioObject = new AudioObject();
		
		private var radius:Number = 150;
		
		private var averagePeak:Number = 0;
		
		public function ScribblyVis()
		{
			init();
		}
		
		private function init():void
		{
			stage.scaleMode = "noScale";
			
			initVis();
			initSound();
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function initVis():void
		{
			cont = new Sprite();
			//addChild(cont);
			
			canvas = new BitmapCanvas(w, h);
			canvas.startCapture(cont, false, TimeType.TIME, 1);
			addChild(canvas);
			
			filterRhythm = new FilterRhythm([new BlurFilter(5.0, 5.0, 3.0)], canvas.bitmap.bitmapData);
			//filterRhythm.start(TimeType.TIME, 1);
		}
		
		private function initSound():void
		{
			sound = new audioFile();
			channel = sound.play();
		}
		
		private function loop(e:Event):void
		{
			averagePeak = (channel.leftPeak + channel.rightPeak) / 2;
			averagePeak *= 500;
			radius = 300;
			if(radius > 300)
			{
				radius = 300;
			}
			else if(radius < 50)
			{
				radius = 50;
			}
			
			audio.tick();
			cont.graphics.clear();
			angle = 0 * 2 * Math.PI / 255;
			var rawAv:Number = audio.rawAverage[0];
			for(var i:uint = 1; i < 256; i++)
			{
				rawAv = audio.rawAverage[i];
				angle = Corona.angle(i, 2, 255);
				//cont.graphics.lineTo(centreX + Math.cos(angle) * (radius * (1 + scale) + rawAv * w * 0.1),
				//centreY + Math.sin(angle) * (radius * (1 + scale) + rawAv * h * 0.1));
				
				//Corona - filled square
				
				cont.graphics.beginFill(color2);
				
				/*cont.graphics.drawRect(centreX + Math.sin(angle) * (radius * (1 + scale) + rawAv * w * 0.1),
				   centreY + Math.cos(angle) * (radius * (1 + scale) + rawAv * h * 0.1),
				 (averagePeak / 500) * 10,(averagePeak/500) * 10);*/
				
				cont.graphics.drawCircle(Corona.calculateX(centreX, angle, radius, rawAv, w, scale), Corona.calculateY(centreY, angle, radius, rawAv, h, scale), 3);
				
				cont.graphics.endFill();
				
					//Corona - circles - lines
				
				/*cont.graphics.lineStyle(1, (rawAv), 1);
				
				   cont.graphics.lineTo(centreX + Math.cos(angle) * (radius * (1 + scale) + rawAv * w * 0.1),
				   centreY + Math.sin(angle) * (radius * (1 + scale) + rawAv * h * 0.1));
				   cont.graphics.drawCircle(centreX + Math.cos(angle) * (radius * (1 + scale) + rawAv * w * 0.1),
				 centreY + Math.sin(angle) * (radius * (1 + scale) + rawAv * h * 0.1), 3);*/
			}
		
			//rawAv = audio.rawAverage[0];
			//cont.graphics.lineTo(centreX + radius * (1 + scale) + rawAv * w * 0.1, centreY);
		/*var tran:Transform = cont.transform;
		   var ct:ColorTransform = new ColorTransform(1, 1, 1, 1,
		   tran.colorTransform.redOffset + Math.random() * 255 - 122.25,
		   tran.colorTransform.greenOffset + Math.random() * 255 - 122.25,
		 tran.colorTransform.blueOffset + Math.random() * 255 - 122.25);*/
		}
	}
}