package
{
	import efnx.events.WaveformEvent;
	import efnx.sound.Waveform;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;

	public class Spectr extends MovieClip
	{
		private var plotter:Waveform = new Waveform();
		private var method:String = "rms";
		private var dx:int = 0;
		private var _waveformWidth:Number;
		private var _waveformHeight:Number;
		private var _sound:Sound;
		private var s:Sprite = new Sprite();
		private var _isModel:Boolean;
		private var _start:Boolean = true;

		public function Spectr( width:Number, height:Number, sound:Sound, isModel:Boolean = false )
		{
			_waveformWidth = width;
			_waveformHeight = height;
			_sound = sound;
			_isModel = isModel;

			addEventListener( Event.ADDED_TO_STAGE, init );
		}

		private function init( e:Event ):void
		{
			removeEventListener( e.type, init );

			s.y = this.parent.height / 2;
			addChild(s);
			s.graphics.lineStyle(0, 0xCC0000);
			
			createWaveform();
		}

		public function createWaveform():void
		{
			_start = true;
			plotter.sound = _sound;
			plotter.leftSample = 0;
			plotter.rightSample = _sound.length * 44.1;
			plotter.numWindows = _waveformWidth;
			plotter.addEventListener( "progress", onWindowAnalyze, false, 0, true );
			plotter.addEventListener( "complete", onAnalyzeComplete, false, 0, true );
			plotter.createWaveform( "rms" );
		}

		public function onWindowAnalyze( event:WaveformEvent ):void
		{
			var l:Number = event.leftChunk.length;
			var r:Number = event.rightChunk.length;
			
			var i:uint = 0;
			var j:uint = 0;
			
			var lv:Number;
			var rv:Number;
			
			var top:Number, bottom:Number;
			var centerY:Number = _waveformHeight / 2;
			var chunkHeight:Number = _isModel ? 130 : 49;
			
			for(i; i < l; i += 1)
			{
				if(dx + i < this.parent.width)
				{
				lv = event.leftChunk[ i ];
				rv = event.rightChunk[ i ];
				top = abs(lv) * chunkHeight;
				bottom = abs(rv) * chunkHeight;
				if(_start)
				{
					s.graphics.moveTo(dx + i, -top);
				}
				else
				{
					s.graphics.lineTo(dx + i, -top);
				}
				s.graphics.lineTo(dx + i, bottom);
				}
			}
			dx += i;
			_start = false;
		}

		public function onAnalyzeComplete( event:Event ):void
		{
			//trace( "Waveform_Main::onAnalyzeComplete()" );
		}

		public function abs( value:Number ):Number
		{
			return value < 0 ? -value : value;
		}
	}
}