package audio.synthesis
{
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.utils.ByteArray;

	public class Tone
	{
		protected var RATE:Number = 44100;
		protected var _position:int = 0;
		protected var _sound:Sound;
		protected var _numSamples:int = 2048;
		protected var _samples:ByteArray;
		protected var _frequency:Number;
		protected var _isPlaying:Boolean = false;
		
		public function Tone(frequency:Number)
		{
			_frequency = frequency;
			_sound = new Sound();
			_sound.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
			_samples = new ByteArray();
			createSamples();
		}
		
		public function get isPlaying():Boolean
		{
			return _isPlaying;
		}

		public function get frequency():Number
		{
			return _frequency;
		}

		public function set frequency(value:Number):void
		{
			_frequency = value;
			createSamples();
		}

		protected function createSamples():void
		{
			var amp:Number = 1.0;
			var i:int = 0;
			var mult:Number = _frequency / RATE * Math.PI * 2;
			_samples.clear();
			while(amp > 0.01)
			{
				_samples.writeFloat(Math.sin(i * mult) * amp);
				amp *= 0.9998;
				i++;
			}
		}
		
		public function play():void
		{
			if(!_isPlaying)
			{
				_position = 0;
				_samples.position = _position;
				_sound.play();
				_isPlaying = true;
			}
		}
		
		protected function onSampleData(e:SampleDataEvent):void
		{
			var i:int = 0;
			
			for(i=0;i<_numSamples;i++)
			{
				if(_position >= _samples.length || _samples.bytesAvailable <= 0)
				{
					_isPlaying = false;
					return;
				}
				var s:Number = _samples.readFloat();
				e.data.writeFloat(s);
				e.data.writeFloat(s);
				_position++;
			}
		}
	}
}