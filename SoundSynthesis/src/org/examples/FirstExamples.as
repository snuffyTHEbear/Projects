package
{
	import audio.synthesis.Tone;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.SampleDataEvent;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.utils.Timer;
	
	public class FirstExamples extends Sprite
	{
		
		public function FirstExamples()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private var mono:Boolean = false;
		private var position:int = 0;
		private var n:Number = 0;
		private var amp:Number = 1.0;
		private var timer:Timer;
		
		private function init(e:Event):void
		{
			removeEventListener(e.type, init);
			
			stage.addEventListener(MouseEvent.CLICK, onStageClick);
			
			/*timer = new Timer(500);
			timer.addEventListener(TimerEvent.TIMER, timerTick);
			timer.start();
			
			var sound:Sound = new Sound();
			sound.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
			sound.play();*/
		}
		
		private function onStageClick(e:MouseEvent):void
		{
			//mono =! mono;
		}
		
		private function onSampleData(e:SampleDataEvent):void
		{
			graphics.clear();
			graphics.lineStyle(0, 0x999999);
			graphics.moveTo(0, stage.stageHeight * 0.5);
			
			var i:int;
			var len:int= 2048;
			for(i = 0;i<len;i++)
			{
				var phase:Number = position / 44100 * Math.PI * 2;
				position++;
				var sample:Number = Math.sin(phase * 440 * Math.pow(2, n / 12)) * amp;
				e.data.writeFloat(sample);
				e.data.writeFloat(sample);
				graphics.lineTo(i / 2048 * stage.stageWidth, stage.stageHeight / 2 - sample * stage.stageHeight / 8);
				/*var sampleA:Number = Math.random() * 2.0 - 1.0;
				var sampleB:Number = Math.random() * 2.0 - 1.0;
				e.data.writeFloat(sampleA);
				if(mono)
				{
				e.data.writeFloat(sampleA);
				}
				else
				{
				e.data.writeFloat(sampleB);
				}*/
			}
			
			amp *= 0.7;
		}
		
		private function timerTick(e:TimerEvent):void
		{
			//amp = 1.0;
			amp = 0.5 + Math.cos(position * 0.001) * 0.5;
			n = Math.floor(Math.random() * 20 - 5);
			timer.delay = 125 * (1 + Math.floor(Math.random() * 7));
		}
	}
}