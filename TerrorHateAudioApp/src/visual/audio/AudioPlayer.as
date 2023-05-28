package visual.audio
{
	import com.arcticcode.greenFlames.xPreloader.XPreloader;
	
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.filters.GlowFilter;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import web.urls.urls;

	public class AudioPlayer extends Sprite
	{
		private var _vis:playerVis = new playerVis();
		private var _channel:SoundChannel;
		private var _sound:Sound;
		private var _playing:Boolean = false;
		private var audioLoader:XPreloader;
		private var _playlist:XMLList;
		private var _visualizer:Sprite;
		private var _pos:Number = 0;
		private var _playingIndex:uint=0;
		private var _percText:TextField;
		private var _isPlaying:Boolean = false;
		private var _font:Font;
		
		public function AudioPlayer(font:Font)
		{
			_font = font;
			init();
		}
		private function init():void
		{
			audioLoader = new XPreloader("",XPreloader.MP3,false);
			audioLoader.addEventListener(ProgressEvent.PROGRESS,progress);
			audioLoader.addEventListener(Event.COMPLETE, loaded);
			
			_percText = new TextField();
			_percText.embedFonts = true;
			_percText.autoSize = "left";
			_percText.defaultTextFormat = new TextFormat(_font.fontName,22,0xff6600);
			_percText.x = 100;
			_percText.text = "100";
			//addChild(_percText);
			
			_vis.pauseButton.visible = false;
			addChild(_vis);
			_vis.ID3INFO.embedFonts = true;
			addListeners(_vis.nextButton,_vis.pauseButton,_vis.playButton,_vis.prevButton);
		}
		private function addListeners(...rest):void
		{
			var btn:SimpleButton;
			for(var inc:uint=0;inc<rest.length;inc++)
			{
				btn = rest[inc] as SimpleButton;
				btn.addEventListener(MouseEvent.CLICK, onClick);
				btn.addEventListener(MouseEvent.MOUSE_OVER, onOver);
				btn.addEventListener(MouseEvent.MOUSE_OUT, onOut);
			}
		}
		private function onOver(e:MouseEvent):void
		{
			e.target.filters = [new GlowFilter(0xff6600,1,3,3,0.85,3,false,false)];
		}
		private function onOut(e:MouseEvent):void
		{
			e.target.filters = [];
		}
		private function onClick(e:MouseEvent):void
		{
			trace(e.target.name);
			switch(e.target.name)
			{
				case "playButton":
				loadAudio();
				break;
				
				case "pauseButton":
				pause();
				break;
				
				case "nextButton":
				next();
				break;
				
				case "prevButton":
				prev();
				break;
			}
		}
		private function loadAudio():void
		{
			audioLoader.loadURL(urls.BASE_URL+_playlist[_playingIndex].@name+".mp3",XPreloader.MP3,false);
			audioLoader.load();
		}
		private function progress(e:ProgressEvent):void
		{
			var p:Number = e.bytesLoaded / e.bytesTotal;
			_vis.ID3INFO.text = "Loading: " + (Math.floor(p*100)).toString();
		}
		private function loaded(e:Event):void
		{
			_sound = e.target.content as Sound;
			play();
			updateID3Info();
		}
		public function set playlist(val:XMLList):void
		{
			_playlist = val.track;
			loadAudio();
		}
		private function updateID3Info():void
		{
			_vis.ID3INFO.text = (_sound.id3.track) + " - " + (_sound.id3.songName);
		}
		private function next():void
		{
			if(audioLoader.isLoading)
			{
				audioLoader.close();
			}
			stop();
			if(_playingIndex < _playlist.length()-1)
			{
				_playingIndex += 1;
			}
			else
			{
				_playingIndex = 0;
			}
			loadAudio();
		}
		private function prev():void
		{
			if(audioLoader.isLoading)
			{
				audioLoader.close();
			}
			stop();
			if(_playingIndex > 0)
			{
				_playingIndex -= 1;
			}
			else
			{
				_playingIndex = _playlist.length()-1;
			}
			loadAudio();
		}
		private function pause():void
		{
			_isPlaying = false;
			_pos = _channel.position;
			_channel.stop();
			_vis.pauseButton.visible = false;
			_vis.playButton.visible = true;
		}
		private function play():void
		{
			_isPlaying = true;
			_vis.pauseButton.visible = true;
			_vis.playButton.visible = false;
			_channel = _sound.play(_pos);
			_channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		}
		private function onSoundComplete(e:Event):void
		{
			_isPlaying = false;
			_pos = 0;
			_channel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			next();
		}
		private function stop():void
		{
			_isPlaying = false;
			if(_channel != null)
			{_channel.stop();}
			_pos = 0;
		}
	}
}