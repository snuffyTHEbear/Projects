package 
{
	import com.arcticcode.greenFlames.graphics.Colour24;
	import com.arcticcode.greenFlames.math.Corona;
	import com.arcticcode.greenFlames.text.SimpleTextField;
	
	import flash.display.Sprite;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextFormat;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import hype.extended.color.ColorPool;
	import hype.extended.rhythm.FilterRhythm;
	import hype.framework.display.BitmapCanvas;
	import hype.framework.rhythm.SimpleRhythm;
	import hype.framework.sound.SoundAnalyzer;
	
	[SWF(width=640, height = 600)]
	public class HypeCorona extends Sprite
	{
		private var _audioFiles:Array = new Array("Daedelus_FairWeatherFriends");
		
		private var _audioIndex:Number = 0; //Math.floor(Math.random() * _audioFiles.length);
		
		private var _currentTrack:String = _audioFiles[_audioIndex];
		
		private var w:Number = stage.stageWidth;
		
		private var h:Number = stage.stageHeight;
		
		private var centreX:Number = w * 0.5;
		
		private var centreY:Number = h * 0.5;
		
		private var _soundAnal:SoundAnalyzer;
		
		private var _canvas:BitmapCanvas;
		
		private var _colorPool:ColorPool = new ColorPool();
		
		private var _container:Sprite;
		
		private var _sound:Sound;
		
		private var _rhythm:SimpleRhythm;
		
		private var _channel:SoundChannel;
		
		private var _filterRhythm:FilterRhythm;
		
		private var _inc:uint = 0;
		
		private var _numItems:uint = 255;
		
		private var _angle:Number;
		
		private var _x:Number;
		
		private var _y:Number;
		
		private var _radius:Number = 200;
		
		private var _scale:Number = 0;
		
		private var _freq:Number;
		
		private var _playing:Boolean = false;
		
		private var _pos:Number = 0;
		
		private var _color:Colour24 = new Colour24(0, 0, 0);
		
		private var _text:SimpleTextField;
		
		private const PLAYING_STRING:String = "Playing\nClick to pause";
		
		private const PAUSED_STRING:String = "Paused\nClick to play";
		
		private var _string:String = "Click to start...";
		
		private var _contextMenu:ContextMenu;
		
		private var _coronaIndex:Number = 0;
		
		public function HypeCorona()
		{
			stage.scaleMode = "noScale";
			init();
			initSound();
			initRhythm();
			initCanvas();
			initText();
			initMenu();
		}
		
		private function initMenu():void
		{
			_contextMenu = new ContextMenu();
			_contextMenu.hideBuiltInItems();
			
			var cmiNext:ContextMenuItem = new ContextMenuItem("Next", false, true, true);
			var cmiPrevious:ContextMenuItem = new ContextMenuItem("Previous", false, true, true);
			var cmiRandom:ContextMenuItem = new ContextMenuItem("Random", true, true, true);
			var cmiArctic_Code:ContextMenuItem = new ContextMenuItem("Arctic-Code", true, true, true);
			
			cmiNext.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, cmiClick);
			cmiPrevious.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, cmiClick);
			cmiRandom.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, cmiClick);
			cmiArctic_Code.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, cmiClick);
			
			_contextMenu.customItems.push(cmiNext, cmiPrevious, cmiRandom, cmiArctic_Code);
			
			this.contextMenu = _contextMenu;
		}
		
		private function cmiClick(e:ContextMenuEvent):void
		{
			switch(e.target.caption)
			{
				case "Next":
					_audioIndex += 1;
					
					if(_audioIndex == _audioFiles.length)
					{
						_audioIndex = 0;
					}
					
					loadSong();
					break;
				
				case "Previous":
					_audioIndex -= 1;
					
					if(_audioIndex < 0)
					{
						_audioIndex = _audioFiles.length - 1;
					}
					
					loadSong();
					break;
				
				case "Random":
					_audioIndex = Math.floor(Math.random() * _audioFiles.length);
					loadSong();
					break;
				
				case "Arcitc-Code":
					navigateToURL(new URLRequest("http://arctic-code.com"), "_blank");
					break;
			}
		}
		
		private function init():void
		{
			_container = new Sprite();
			
			stage.addEventListener(MouseEvent.CLICK, stageClick);
		}
		
		private function initText():void
		{
			_text = new SimpleTextField(new TextFormat("_sans", 12, 0), "left", false, "normal", true);
			_text.move(5, 5);
			addChild(_text);
			_string = "Click to start...";
			_text.text = _string;
		}
		
		private function initSound():void
		{
			_soundAnal = new SoundAnalyzer();
			_soundAnal.start();
			
			_sound = new Sound(new URLRequest("../assets/" + _currentTrack));
			_sound.addEventListener(ProgressEvent.PROGRESS, soundLoading);
			//_channel = _sound.play();
		}
		
		private function loadSong():void
		{
			if(_channel)
			{
				_channel.stop();
			}
			if(_sound.isBuffering)
			{
				_sound.close();
			}
			_currentTrack = _audioFiles[_audioIndex];
			_sound = new Sound(new URLRequest("../assets/" + _currentTrack));
			_sound.addEventListener(ProgressEvent.PROGRESS, soundLoading);
			if(_playing)
			{
				_channel = _sound.play();
			}
		}
		
		private function soundLoading(e:ProgressEvent):void
		{
			var t:String = _string + ("\nLoading audio: " + (e.bytesLoaded / e.bytesTotal) * 100).toString();
			_text.text = t;
		}
		
		private function soundLoaded(e:Event):void
		{
			_sound.removeEventListener(ProgressEvent.PROGRESS, soundLoading);
			_channel.addEventListener(Event.SOUND_COMPLETE, soundComplete);
		}
		
		private function soundComplete(e:Event):void
		{
			_sound.removeEventListener(ProgressEvent.PROGRESS, soundLoading);
			_channel.removeEventListener(Event.SOUND_COMPLETE, soundComplete);
			
			_audioIndex += 1;
			
			if(_audioIndex == _audioFiles.length)
			{
				_audioIndex = 0;
			}
			
			loadSong();
		}
		
		private function initRhythm():void
		{
			_rhythm = new SimpleRhythm(rhythmCallback);
			_rhythm.start();
		}
		
		private function initItems():void
		{
		
		}
		
		private function initCanvas():void
		{
			_canvas = new BitmapCanvas(w, h);
			addChild(_canvas);
			_canvas.startCapture(_container);
		}
		
		private function rhythmCallback(rhythm:SimpleRhythm):void
		{
			if(!_playing)
				return;
			
			/*
			
			   Corona types
			
			   basic line / circle
			   basic fill
			   curve to centre point on each interval
			   curve with fill
			   shapes
			   ?rectangles which start at centre at go to peak outwards uses rotation?
			   patterns which mess with the algorithm
			   3D
			   Cyllendric corona like a frisbee with a hole in centre
			
			 */
			
			var startPt:Point = new Point();
			_container.graphics.clear();
			//_container.graphics.lineStyle(0, 0);
			_container.graphics.beginFill(_color.colour);
			for(_inc = 0; _inc < _numItems; _inc++)
			{
				_freq = _soundAnal.getFrequencyIndex(_inc, 0, 1);
				//_freq = _soundAnal.getFrequencyRange(_inc * 4, _inc * 4 + 4, 0, 1);
				_angle = Corona.angle(_inc, 2, _numItems);
				_x = Corona.calculateX(centreX, _angle, _radius, _freq, w, _scale);
				_y = Corona.calculateY(centreY, _angle, _radius, _freq, h, _scale);
				//_container.graphics.drawCircle(_x, _y, 3);
				if(_inc == 0)
				{
					_container.graphics.moveTo(_x, _y);
					startPt.x = _x;
					startPt.y = _y;
				}
				else
				{
					//_container.graphics.lineTo(_x, _y);
					_container.graphics.curveTo(centreX, centreY, _x, _y);
				}
				_color.blue += Math.random() * 0.5 - 0.25;
				_color.red += Math.random() * 0.5 - 0.25;
				_color.green += Math.random() * 0.5 - 0.25;
			}
			//_container.graphics.lineTo(startPt.x, startPt.y);
			_container.graphics.curveTo(centreX, centreY, _x, _y);
			_container.graphics.curveTo(centreX, centreY, startPt.x, startPt.y);
			_container.graphics.endFill();
			startPt = null;
		}
		
		private function stageClick(e:MouseEvent):void
		{
			if(_playing)
			{
				_string = PAUSED_STRING;
				_text.text = _string;
				_pos = _channel.position;
				_channel.stop();
				_playing = false;
			}
			else
			{
				_string = PLAYING_STRING;
				_text.text = _string;
				_channel = _sound.play(_pos);
				_playing = true;
			}
		}
	}
}