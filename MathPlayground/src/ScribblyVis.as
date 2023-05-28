package
{
	import com.arcticcode.greenFlames.geom.LWPoint;
	import com.arcticcode.greenFlames.sound.objects.AudioObject;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Transform;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.ByteArray;

	[SWF(width=1100, height = 700, backgroundColor = 0)]
	public class ScribblyVis extends Sprite
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;
		private var w:Number = stage.stageWidth;
		private var h:Number = stage.stageHeight;
		private var bmd:BitmapData;
		private var b:Bitmap;
		private var cont:Sprite;

		[Embed(source="assets/the_trooper.mp3", mimeType = "audio/mpeg")]
		private var audioFile:Class;
		private var sound:Sound;
		private var channel:SoundChannel;

		private var ba:ByteArray = new ByteArray();
		private var i:uint = 0;
		private var val:Number = 0;
		private var scale:Number = 0;
		private var point:LWPoint = new LWPoint(10, centreY);
		private var val2:Number = 0;
		private var color:uint = uint(Math.random() * 256) << 16 | uint(Math.random() * 256) << 8 | uint(Math.random() * 256)
		private var col1r:Number = Math.random();
		private var col2r:Number = Math.random();
		private var col1g:Number = Math.random();
		private var col2g:Number = Math.random();
		private var col1b:Number = Math.random();
		private var col2b:Number = Math.random();
		private var angle:Number = 0;
		private var audio:AudioObject = new AudioObject();
		private var radius:Number = 300;
		private var averagePeak:Number = 0;
		private var color2:uint = uint(255 * (col1r * (col2r - col1r))) << 16 | uint(255 * (col1g * (col2g - col1g))) << 8 | uint(255 * (col1b * (col2b - col1b)));

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
			bmd = new BitmapData(stage.stageWidth + 50, stage.stageHeight, true, 0x00000000);
			b = new Bitmap(bmd, PixelSnapping.NEVER, false);
			addChild(b);

			cont = new Sprite();
			addChild(cont);
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
			if (radius > 300)
			{
				radius = 300;
			}
			else if (radius < 50)
			{
				radius = 50;
			}

			audio.tick();
			cont.graphics.clear();
			bmd.lock();
			var angle:Number = 0 * 2 * Math.PI / 255
			var rawAv:Number = audio.rawAverage[0];
			//cont.graphics.beginFill(color2);
			//cont.graphics.lineStyle(0, color2);
			//cont.graphics.moveTo(centreX + radius * (1 + scale) + rawAv * w * 0.1, centreY);
			cont.graphics.moveTo(centreX + Math.cos(angle) * (radius * (1 + scale) + rawAv * w * 0.1),
									centreY + Math.sin(angle) * (radius * (1 + scale) + rawAv * h * 0.1));
			for (var i:uint = 1; i < 256; i++)
			{
				rawAv = audio.rawAverage[i];
				angle = i * 2 * Math.PI / 255;
				//cont.graphics.lineTo(centreX + Math.cos(angle) * (radius * (1 + scale) + rawAv * w * 0.1),
				//centreY + Math.sin(angle) * (radius * (1 + scale) + rawAv * h * 0.1));
				/* cont.graphics.beginFill(color2);
				cont.graphics.drawRect(centreX + Math.cos(angle) * (radius * (1 + scale) + rawAv * w * 0.1),
										 centreY + Math.sin(angle) * (radius * (1 + scale) + rawAv * h * 0.1), 
										 (averagePeak / 500)*8,(averagePeak/500)*8);
				cont.graphics.endFill(); */
				
				cont.graphics.lineStyle(1, rawAv * 1000000, 1);
				
				cont.graphics.lineTo(centreX + Math.cos(angle) * (radius * (1 + scale) + rawAv * w * 0.1),
									centreY + Math.sin(angle) * (radius * (1 + scale) + rawAv * h * 0.1));
				cont.graphics.drawCircle(centreX + Math.cos(angle) * (radius * (1 + scale) + rawAv * w * 0.1),
										centreY + Math.sin(angle) * (radius * (1 + scale) + rawAv * h * 0.1), 3);
			}

			rawAv = audio.rawAverage[0];
			//cont.graphics.lineTo(centreX + radius * (1 + scale) + rawAv * w * 0.1, centreY);
			/* var tran:Transform = cont.transform;
			var ct:ColorTransform = new ColorTransform(1, 1, 1, 1,
													   tran.colorTransform.redOffset + Math.random() * 255 - 122.25,
													   tran.colorTransform.greenOffset + Math.random() * 255 - 122.25,
													   tran.colorTransform.blueOffset + Math.random() * 255 - 122.25); */
			//bmd.draw(cont, cont.transform.matrix, ct);
			//bmd.applyFilter(bmd, bmd.rect, new Point(0, -1), new BlurFilter(6, 6));
			bmd.unlock();
		}
	}
}