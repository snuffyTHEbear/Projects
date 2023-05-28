package
{
	import com.arcticcode.greenFlames.audio.ScrubSeekBar;
	import com.arcticcode.greenFlames.sound.objects.AudioObject;
	import com.arcticcode.greenFlames.sound.utils.SoundUtils;
	import com.arcticcode.greenFlames.text.SimpleTextField;
	import com.arcticcode.greenFlames.xPreloader.XPreloader;
	
	import flash.display.CapsStyle;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.text.AntiAliasType;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	[SWF(width=640, height = 480, backgroundColor = 0x000000)]
	public class AudioVisulizer extends Sprite
	{
		private var _scrubSeekBar:ScrubSeekBar;
		
		private var _playing:Boolean = false;
		
		private var _position:Number = 0;
		
		private var _seekBar:Sprite;
		
		private var _ao:AudioObject;
		
		private var _scrubWidth:Number = 512;
		
		private var _scrub:Sprite;
		
		private var _visA:Sprite;
		
		private var _visB:Sprite;
		
		private var _loader:XPreloader;
		
		private var _sound:Sound;
		
		private var _channel:SoundChannel;
		
		private var _audioObject:AudioObject;
		
		private var _timer:Timer;
		
		private var _centerX:Number = stage.stageWidth * 0.5;
		
		private var _centerY:Number = stage.stageHeight * 0.5;
		
		private var _simpleTF:SimpleTextField;
		
		public function AudioVisulizer()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(e.type, init);
			
			_loader = new XPreloader("assets/MaxElect.mp3");
			_loader.addEventListener(Event.COMPLETE, soundLoaded);
			_loader.addEventListener(ProgressEvent.PROGRESS, soundProgress);
		}
		
		private function soundLoaded(e:Event):void
		{
			removeEventListener(e.type, soundLoaded);
			removeEventListener(ProgressEvent.PROGRESS, soundProgress);
			
			_sound = _loader.content as Sound;
			
			_channel = _sound.play(_position);
			_channel.stop();
			
			_timer = new Timer(25);
			_timer.addEventListener(TimerEvent.TIMER, timerTick);
			_timer.start();
			
			_scrubSeekBar = new ScrubSeekBar(250, 5, _sound, _channel);
			
			_ao = new AudioObject();
			
			_visA = addChild(new Sprite()) as Sprite;
			
			_visB = addChild(new Sprite()) as Sprite;
			
			_seekBar = addChild(new Sprite()) as Sprite;
			
			_scrub = addChild(new Sprite()) as Sprite;
			
			_visA.x = _visB.x = _seekBar.x = _scrub.x = 63.5;
			_seekBar.y = _scrub.y = 450;
			
			_visA.y = 50;
			_visB.y = 250;
			
			_seekBar.graphics.lineStyle(10, 0xCC0000, 0, true, "normal", CapsStyle.SQUARE);
			_seekBar.graphics.moveTo(0, 0);
			_seekBar.graphics.lineTo(_scrubWidth, 0);
			_seekBar.mouseEnabled = true;
			_seekBar.buttonMode = true;
			
			_scrub.mouseEnabled = false;
			
			_simpleTF = new SimpleTextField(new TextFormat("verdana", 10, 0xFFFFFF), "left", false, AntiAliasType.NORMAL, false);
			addChild(_simpleTF);
			center(_simpleTF);
			_simpleTF.y = stage.stageHeight - 60;
			
			for(var prop:String in _sound.id3)
			{
				//log(prop + " : " + _sound.id3[prop]);
			}
			
			_seekBar.addEventListener(MouseEvent.MOUSE_DOWN, seekMouseDown);
			
			log(SoundUtils.parseArtistSongName(_sound));
			log(SoundUtils.parseSoundLength(_sound.length));
			log(_sound.length);
		}
		
		private function soundProgress(e:ProgressEvent):void
		{
		}
		
		private function log(string:*):void
		{
			trace(string);
		}
		
		private function seekMouseDown(e:MouseEvent):void
		{
			_timer.stop();
			_channel.stop();
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stageMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, stageMouseUp);
		}
		
		
		private function stageMouseUp(e:MouseEvent):void
		{
			//TIME
			_position = Math.min(_seekBar.width, Math.max(0, _seekBar.mouseX)) / _seekBar.width * _sound.length;
			_channel = _sound.play(_position);
			_timer.start();
			
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, stageMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stageMouseUp);
		}
		
		private function stageMouseMove(e:MouseEvent):void
		{
			_scrub.graphics.clear();
			//grey line
			_scrub.graphics.lineStyle(1, 0x666666, 1, true, "normal", CapsStyle.SQUARE);
			_scrub.graphics.moveTo(0, 0);
			_scrub.graphics.lineTo(_scrubWidth, 0);
			//bar
			_scrub.graphics.lineStyle(3, 0xFFFFFF, 1, true, "normal", CapsStyle.SQUARE);
			_scrub.graphics.moveTo(0, 0);
			_scrub.graphics.lineTo(Math.min(_seekBar.width, Math.max(0, _seekBar.mouseX)) / _seekBar.width * _scrubWidth, 0);
			_position = Math.min(_seekBar.width, Math.max(0, _seekBar.mouseX)) / _seekBar.width * _sound.length;
			_simpleTF.text = SoundUtils.parseSoundPosition(_position) + " / " + SoundUtils.parseSoundLength(_sound.length);
			
			e.updateAfterEvent();
		}
		
		private function timerTick(e:TimerEvent):void
		{
			_ao.tick();
			updateScrub();
			updateVis();
			e.updateAfterEvent();
		}
		
		private function updateVis():void
		{
			_visA.graphics.clear();
			_visA.graphics.lineStyle(1, 0xFFFFFF);
			_visB.graphics.clear();
			_visB.graphics.beginFill(0xFFFFFF); //_visB.graphics.lineStyle(1, 0xFFFFFF);
			
			var rawData:Vector.<Number> = _ao.rawAverage;
			var fftData:Vector.<Number> = _ao.fftAverageData;
			var i:Number = 0;
			var len:uint = rawData.length;
			for(i = 0; i < len; i++)
			{
				i == 0 ? _visA.graphics.moveTo(i * 2, rawData[i] * 100) : _visA.graphics.lineTo(i * 2, rawData[i] * 100);
				_visB.graphics.drawRect(i * 2, 0, 2, -fftData[i] * 100);
			}
		}
		
		private function updateScrub():void
		{
			//TODO Abstract time and bar to singleton class...
			//Maybe implement scrub feature?
			
			if(_channel.position >= _sound.length)
				_timer.stop();
			
			_simpleTF.text = SoundUtils.parseSoundPosition(_channel.position) + " / " + SoundUtils.parseSoundLength(_sound.length);
			center(_simpleTF);
			_simpleTF.y = stage.stageHeight - 60;
			_scrub.graphics.clear();
			
			//grey line
			_scrub.graphics.lineStyle(1, 0x666666, 1, true, "normal", CapsStyle.SQUARE);
			_scrub.graphics.moveTo(0, 0);
			_scrub.graphics.lineTo(_scrubWidth, 0);
			//bar
			_scrub.graphics.lineStyle(3, 0xFFFFFF, 1, true, "normal", CapsStyle.SQUARE);
			_scrub.graphics.moveTo(0, 0);
			_scrub.graphics.lineTo(_channel.position / _sound.length * _scrubWidth, 0);
		}
		
		private function center(obj:DisplayObject):void
		{
			obj.x = _centerX - obj.width * 0.5;
			obj.y = _centerY - obj.height * 0.5;
		}
	}
}