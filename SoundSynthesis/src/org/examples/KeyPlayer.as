package org.examples
{
	import audio.synthesis.Tone;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.net.dns.AAAARecord;
	
	public class KeyPlayer extends Sprite
	{
		private var _tone:Tone;
		
		public function KeyPlayer()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(e.type, init);
			
			_tone = new Tone(0);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, stageKeyDown);
		}
		
		private function stageKeyDown(e:KeyboardEvent):void
		{
			_tone.frequency = e.keyCode * (e.keyCode);
			_tone.play();
		}
	}
}