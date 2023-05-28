package Assets.PlayerCore.UI
{
	import Assets.Events.AddToPlaylist;
	import Assets.Events.ControlEvent;
	import Assets.Events.ListPopulatedEvent;
	import Assets.PlayerCore.Audio.ID3.GetID3Info;
	import Assets.PlayerCore.Audio.ID3.OnID3Event;
	import Assets.PlayerCore.File.DragDropManager;
	import Assets.PlayerUI.PlayerUI;
	import Assets.UI_Icons.UIIcons;
	import Assets.Visual.FileBrowser;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import robDaniels.greenFlames.src.preloader.ContentLoadedEvent;
	import robDaniels.greenFlames.src.preloader.LoadErrorEvent;
	import robDaniels.greenFlames.src.preloader.Preloader;
	import robDaniels.greenFlames.src.preloader.loaderTypes.LoadProgressEvent;
	
	public class UIHandler extends Sprite
	{
		private var _ui:PlayerUI;
		private var _fb:FileBrowser;
		private var _ddm:DragDropManager;
		private var _dir:File;
		private var _base:Sprite;
		
		private var _isPlaying:Boolean = false;
		private var _isLoading:Boolean = false;
		private var _isPaused:Boolean = false;
		private var _isSeeking:Boolean = false;
		private var _pauseVal:Number;
		private var _currentIndex:uint = 0;
		private var _soundLoader:Preloader;
		private var _track:Sound;
		private var _soundChannel:SoundChannel;
		private var _mins:String;
		private var _secs:String;
		private var _totMins:String;
		private var _totSecs:String;
		private var _soundTimer:Timer;
		private var _currPos:String;
		private var _ID3:GetID3Info;
		private var _icons:UIIcons;
		//
		private var _ba:ByteArray;
		
		public function UIHandler(UI:PlayerUI)
		{
			_ui = UI;
			init();
		}
		private function init():void
		{			
			_icons = new UIIcons();
			
			_dir = File.documentsDirectory;
			
			_ba = new ByteArray();
			
			_ID3 = new GetID3Info();
			_ID3.addEventListener(OnID3Event.ID3_COLLECTED, onID3);
			
			_base = Sprite(_ui.parent);
			
			_fb = new FileBrowser("mp3", "Data/UserData.xml");
			_fb.addEventListener(AddToPlaylist.ADD_ITEM, onAddItem);
			
			_ddm = new DragDropManager(_base, "mp3");
			_ddm.addEventListener(AddToPlaylist.ADD_ITEM, onAddItem);
			
			_ui.addEventListener(ControlEvent.CONTROL_TYPE, onControl);
			_ui.addEventListener(ListPopulatedEvent.LIST_POPULATED, onListPop);
			
			_soundTimer = new Timer(10);
			_soundTimer.addEventListener(TimerEvent.TIMER, onSoundTimer);
		}
		private function onAddItem(e:AddToPlaylist):void
		{
			var icon:Bitmap = new Bitmap()
			var bmd:BitmapData = new BitmapData(_icons.__bullet_red.width,_icons.__bullet_red.height,true,0x000000);
			bmd.draw(_icons.__bullet_red);
			icon.bitmapData = bmd;
			_ui.addListItem(e._file.name, e._file.nativePath, icon);
		}
		private function onControl(e:ControlEvent):void
		{
			switch(e._command)
			{
				case "Open":
					_base.addChild(_fb);
				break;
				
				case "Play":
					doPlay(_ui.DoubleClickItem);
				break;
				
				case "Pause":
					doPause();
				break;
				
				case "Stop":
					doStop();
				break;
				
				case "Next":
					doNext();
				break;
				
				case "Prev":
					doPrev();
				break;
				
				case "Pos Click":
					doPosClick();
				break;
				
				case "Pos Up":
					doPosChange();
				break;
			}
		}
		private function doPosClick():void
		{
			_soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			_soundTimer.stop();
			_ui.icon = "Pause";
			_isPlaying = false;
			_soundChannel.stop();
			_isSeeking = true;
		}
		private function doPosChange():void
		{
			_isSeeking = false;
			_ui.icon = "Play";
			var _position:Number = _ui.ProgBarVal;
			_soundChannel.stop();
			_soundChannel = _track.play(_position);
			_isPlaying = true;
			_soundTimer.start();
			_soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		}
		private function onSoundTimer(e:TimerEvent):void
		{
			if(!_isLoading)
			{
				if(!_isSeeking && _isPlaying)
				{
					_ui.setProgBarVal(_soundChannel.position);
				}
				else if(_isSeeking && !_isPlaying)
				{
					
				}
				var _minutes:Number = Math.floor((_soundChannel.position/1000)/60);
				var _seconds:Number = Math.floor((_soundChannel.position/1000)%60);
				_mins = _minutes.toString();
				_secs = _seconds.toString();
				
				if(_seconds < 10)
				{
					_secs = "0" + _secs;
				}
				else
				{
					_secs = _secs;
				}
				if(_minutes < 10)
				{
					_mins = "0" + _mins;
				}
				else
				{
					_mins = _mins;
				}
				_currPos = _mins + ":" + _secs + " / " + _totMins + ":" + _totSecs;
				_ui.setTimeText(_currPos);
				/*SoundMixer.computeSpectrum(_ba, false);
				_ui.setVis(_ba);*/
				
				if(_ui.ProgBarVal == _track.length)
				{
					_soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
					doNext();
				}
			}
		}
		private function onListPop(e:ListPopulatedEvent):void
		{
			_ui.ListItem = 0;
			doPlay(_ui.DoubleClickItem);
			_isPlaying = true;
			turnControls("On");
		}
		private function doPlay(item:Object):void
		{
			var _item:Object;
			if(!_isPaused && !_isPlaying && !_isLoading)
			{
				_ui.icon = "Play";
				_item = item;
				_ui.setPercentBar("On");
				_soundLoader = new Preloader(_item._path);
				_soundLoader.addEventListener(LoadProgressEvent.LOAD_PROGRESS, onLoadProgress);
				_soundLoader.addEventListener(LoadErrorEvent.LOAD_ERROR, onLoadError);
				_soundLoader.addEventListener(ContentLoadedEvent.CONTENT_LOADED, onLoaded);
			}
			else if(_isPaused)
			{
				_ui.icon = "Play";
				_soundChannel = _track.play(_pauseVal);
				_isPaused = false;
				_isPlaying = true;
				_soundTimer.start();
			}
			else if(_isLoading || _isLoading && _isPlaying)
			{
				_ui.icon = "Play";
				doStop();
				_item = item;
				_ui.setPercentBar("On");
				_soundLoader = new Preloader(_item._path);
				_soundLoader.addEventListener(LoadProgressEvent.LOAD_PROGRESS, onLoadProgress);
				_soundLoader.addEventListener(LoadErrorEvent.LOAD_ERROR, onLoadError);
				_soundLoader.addEventListener(ContentLoadedEvent.CONTENT_LOADED, onLoaded);
			} 
			else if(_isPlaying && !_isPaused)
			{
				_ui.icon = "Play";
				doStop();
				_item = item;
				_ui.setPercentBar("On");
				_soundLoader = new Preloader(_item._path);
				_soundLoader.addEventListener(LoadProgressEvent.LOAD_PROGRESS, onLoadProgress);
				_soundLoader.addEventListener(LoadErrorEvent.LOAD_ERROR, onLoadError);
				_soundLoader.addEventListener(ContentLoadedEvent.CONTENT_LOADED, onLoaded);
			}
		}
		private function doPause():void
		{
			_pauseVal = _soundChannel.position;
			_soundChannel.stop();
			_isPaused = true;
			_isPlaying = false;
			_ui.icon = "Pause";
			if(_soundTimer.running)
			{
				_soundTimer.stop();
			}
		}
		private function doStop():void
		{
			if(_isLoading)
			{
				_soundLoader.close();
				_isLoading = false;
			}
			if(_isPlaying)
			{
				_soundChannel.stop();
				turnControls("Off");
				_isPlaying = false;
				_pauseVal = 0;
			}
			else if(_isPaused)
			{
				_soundChannel.stop();
				turnControls("Off");
				_pauseVal = 0;
				_isPaused = false;
			}
			if(_soundTimer.running)
			{
				_soundTimer.stop();
			}
		}
		private function doNext():void
		{
			_ui.icon = "Next";
			if(_ui.PlaylistCount == 1)
			{
				_ui.ListItem = 0;
			}
			else if(_ui.CurrentIndex == _ui.PlaylistCount-1)
			{
				_ui.ListItem = 0;
			}
			else
			{
				_ui.ListItem = _ui.CurrentIndex + 1;
			}
			doPlay(_ui.DoubleClickItem);
		}
		private function doPrev():void
		{
			_ui.icon = "Next";
			if(_ui.PlaylistCount == 1)
			{
				_ui.ListItem = 0;
			}
			else if(_ui.CurrentIndex == 0)
			{
				_ui.ListItem = _ui.PlaylistCount - 1;
			}
			else
			{
				_ui.ListItem = _ui.CurrentIndex - 1;
			}
			doPlay(_ui.DoubleClickItem);
		}
		private function turnControls(val:String):void
		{
			switch(val)
			{
				case "On":
					_ui.setStop("On");
					_ui.setNext("On");
					_ui.setPrev("On");
					if(_isPlaying)
					{
						_ui.setPlayPause("On");
						_ui.togglePlayPause("Play");
					}
				break;
					
				case "Off":
					_ui.setStop("Off");
					_ui.setProgressBar("Off");
					_ui.setProgBarVal(0);
					_ui.setTimeText("--:-- / --:--");
					if(_isPlaying)
					{
						_ui.togglePlayPause("Pause");
					}
				break;
			}
		}
		private function onLoadError(e:LoadErrorEvent):void
		{
			trace(e._error);
		}
		private function onLoadProgress(e:LoadProgressEvent):void
		{
			_ui.Percent = e._percent;
			_isLoading = true;
			
			if(e._percent == 100)
			{
				_ui.setPercentBar("Off");
				_isLoading = false;
				if(!_isLoading)
				{
					var _totalSeconds:Number = Math.floor((_track.length/1000)%60);
					var _totalMinutes:Number = Math.floor((_track.length/1000)/60);
					_totSecs = _totalSeconds.toString();
					_totMins = _totalMinutes.toString();
					
					if(_totalSeconds < 10)
					{
						_totSecs = "0" + _totSecs;
					}
					else
					{
						_totSecs = _totSecs;
					}
					if(_totalMinutes < 10)
					{
						_totMins = "0" + _totMins;
					}
					else
					{
						_totMins = _totMins;
					}
					_ui.setProgressBar("On");
					_ui.setProgBarVals(0,_track.length);
					//_ui.setCurrentPosition(
					_soundTimer.start();
					_ID3.getID3(_track);
				}
				_soundLoader.removeEventListener(LoadProgressEvent.LOAD_PROGRESS, onLoadProgress);
				_soundLoader.removeEventListener(LoadErrorEvent.LOAD_ERROR, onLoadError);
				_soundLoader.removeEventListener(ContentLoadedEvent.CONTENT_LOADED, onLoaded);
			}
		}
		private function onLoaded(e:ContentLoadedEvent):void
		{
			_track = Sound(e.content);
			_soundChannel = _track.play();
			_isPlaying = true;
			turnControls("On");
			_soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		}
		private function onID3(e:OnID3Event):void
		{
			_ui.artistInfo = e._artist;
			_ui.trackInfo = e._track;
			_ui.albumInfo = e._album;
		}
		private function onSoundComplete(e:Event):void
		{
			_soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			doNext();
		}
	}
}