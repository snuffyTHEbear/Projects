package
{
	import audio.synthesis.Tone;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.examples.KeyPlayer;
	
	public class SoundSynthesis extends Sprite
	{
		private var _toneA:Tone = new Tone(800);
		private var _toneB:Tone = new Tone(800);
		private var _toneC:Tone = new Tone(800);
		
		private var _timer:Timer;
		
		public function SoundSynthesis()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(e.type, init);
			
			var example:Sprite = new KeyPlayer();
			addChild(example);
		}
		
		private function timerTick(e:TimerEvent):void
		{
			if(!_toneA.isPlaying)
			{
				_toneA.frequency = 300 + Math.random() * 500;
				_toneA.play();
			}
			else if(!_toneB.isPlaying)
			{
				_toneB.frequency = 300 + Math.random() * 500;
				_toneB.play();
			}
			else if(!_toneC.isPlaying)
			{
				_toneC.frequency = 300 + Math.random() * 500;
				_toneC.play();
			}
		}
		
		private function onStageClick(e:MouseEvent):void
		{
			
		}
	}
}