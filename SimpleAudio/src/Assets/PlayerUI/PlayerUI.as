package Assets.PlayerUI
{
	import Assets.Events.ControlEvent;
	import Assets.Events.ListPopulatedEvent;
	import Assets.UI_Icons.UIIcons;
	import Assets.Visual.SimpleButton;
	import Assets.Visual.Visualizer;
	
	import com.bit101.components.Label;
	import com.bit101.components.ProgressBar;
	import com.bit101.components.Slider;
	
	import fl.controls.List;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.utils.ByteArray;
	
	import robDaniels.greenFlames.src.graphics.CreateRoundRect;
	
	public class PlayerUI extends Sprite
	{
		private var _parent:CreateRoundRect;
		private var _list:List;
		private var _playBtn:SimpleButton;
		private var _pauseBtn:SimpleButton;
		private var _stopBtn:SimpleButton;
		private var _prevBtn:SimpleButton;
		private var _nextBtn:SimpleButton;
		private var _openBtn:SimpleButton;
		private var _percBar:ProgressBar;
		private var _progBar:Slider;
		private var _currPos:String = "--:-- / --:--";
		private var _timeLabel:Label;
		//ID3 Info Display
		private var _id3Parent:CreateRoundRect;
		private var _id3Artist:Label;
		private var _id3Track:Label;
		private var _id3Album:Label;
		//ID3 Info
		private var _artistInfo:String;
		private var _trackInfo:String;
		private var _albumInfo:String;
		//
		private var _doubleClickItem:Object;
		private var _doubleClickIndex:uint;
		private var _prevIndex:uint;
		//VIS
		private var _visualizer:Visualizer;
		//
		private var _icon:Bitmap;
		private var _icons:UIIcons;
		//
		
		
		public function PlayerUI()
		{
			init();
		}
		private function init():void
		{
			_parent= new CreateRoundRect(700, 600, 0xF3F3F3,1,true,5,5,15,15);
			//_parent.filters = [new DropShadowFilter(0,90,0x000000,1,3,3,1,1)];
			addChild(_parent);
			
			_icons = new UIIcons();
			
			_visualizer = new Visualizer(300,300,0xf3f3f3,0x5b8fde);
			_visualizer.x = 300;
			_visualizer.y = 100;
			_visualizer.visHeight = 300;
			_visualizer.visWidth = 300;
			_parent.addChild(_visualizer);
			
			_list = new List();
			_list.move(5,5);
			_list.setSize(250, 510);
			_list.doubleClickEnabled = true;
			_list.allowMultipleSelection = true;
			_list.iconField = "_icon";
			_parent.addChild(_list);
			
			_progBar = new Slider(Slider.HORIZONTAL,_parent,260,35);
			_progBar.alpha = .5;
			_progBar.setSize(435,10);
			_progBar.backClick = true;
			
			_id3Parent = new CreateRoundRect(690,70,0xDCDCDC,1,true,5,525,10,10);
			_parent.addChild(_id3Parent);
			
			_id3Artist = new Label(null,5,0,"Artist: ");
			_id3Parent.addToDisplayList(_id3Artist);
			_id3Artist.setSize(205,10);
			_id3Artist.move(5,5);
			
			_id3Track = new Label(null,5,0,"Track: ");
			_id3Parent.addToDisplayList(_id3Track);
			_id3Track.setSize(205,10);
			_id3Track.move(5, 25);
			
			_id3Album = new Label(null,5,0,"Album: ");
			_id3Parent.addToDisplayList(_id3Album);
			_id3Album.setSize(205,10);
			_id3Album.move(5,45);
			
			_percBar = new ProgressBar(_parent,260,50);
			_percBar.setSize(435,10);
			_percBar.maximum = 100;
			_percBar.alpha = .5;
			
			_playBtn = new SimpleButton(_parent,_icons.__control_play,"", 425,5,null,_icons.__control_play_blue);
			_playBtn.name = "Play";
			_playBtn.alpha = .5;
			
			_pauseBtn = new SimpleButton(_parent,_icons.__control_pause,"", 425,5,null,_icons.__control_pause_blue); 
			_pauseBtn.visible = false;
			_pauseBtn.alpha = 0.5;
			
			_stopBtn = new SimpleButton(_parent,_icons.__control_stop,"",440,5,null,_icons.__control_stop_blue);
			_stopBtn.alpha = .5;
			
			_nextBtn = new SimpleButton(_parent,_icons.__control_end,"",470,5,null,_icons.__control_end_blue)
			_nextBtn.alpha = .5;

			_prevBtn = new SimpleButton(_parent, _icons.__control_start,"", 455,5,null,_icons.__control_start_blue);
			_prevBtn.alpha = .5;
			
			_timeLabel = new Label(_parent,345,5,_currPos);
			
			_openBtn = new SimpleButton(_parent, _icons.__control_eject,"Open",645,5,onOpen, _icons.__control_eject_blue);
			
			/*
			var _b:SimpleButton = new SimpleButton(_icons.__add, "Add");
			_b.x = 300;
			_b.y = 200;
			_parent.addChild(_b);
			*/
			
			_list.addEventListener(MouseEvent.DOUBLE_CLICK, onListSelect);
		}
		private function onListSelect(e:MouseEvent):void
		{
			_prevIndex = _doubleClickIndex;
			_doubleClickItem = _list.selectedItem;
			_doubleClickIndex = _list.selectedIndex;
			dispatchEvent(new ControlEvent("Play"));
		}
		public function onPlayPauseClick(e:Event):void
		{
			//trace(e.currentTarget,e.target);
			var _btn:SimpleButton = SimpleButton(e.currentTarget);
			if(_btn.name == "Play")
			{
				dispatchEvent(new ControlEvent("Play"));
				togglePlayPause("Play");
			}
			else
			{
				dispatchEvent(new ControlEvent("Pause"));
				togglePlayPause("Pause");
			}
		}
		private function onStopClick(e:Event):void
		{
			icon = "Stop";
			dispatchEvent(new ControlEvent("Stop"));
		}
		private function onPosClick(e:MouseEvent):void
		{
			dispatchEvent(new ControlEvent("Pos Click"));
			stage.addEventListener(MouseEvent.MOUSE_UP, onChangePos);
		}
		private function onChangePos(e:MouseEvent):void
		{
			dispatchEvent(new ControlEvent("Pos Up"));
			stage.removeEventListener(MouseEvent.MOUSE_UP, onChangePos);
		}
		public function setPlayPause(val:String):void
		{
			switch(val)
			{
				case "Off":
				_playBtn.alpha = 0.5;
				_pauseBtn.alpha = 0.5;
				_pauseBtn.removeEventListener(MouseEvent.CLICK, onPlayPauseClick);
				_playBtn.removeEventListener(MouseEvent.CLICK, onPlayPauseClick);
				break;
				
				case "On":
				_playBtn.alpha = 1;
				_pauseBtn.alpha = 1;
				_pauseBtn.addEventListener(MouseEvent.CLICK, onPlayPauseClick);
				_playBtn.addEventListener(MouseEvent.CLICK, onPlayPauseClick);
				break;
			}
		}
		public function setPercentBar(val:String):void
		{
			switch(val)
			{
				case "Off":
				_percBar.alpha = 0.5;
				break;
				
				case "On":
				_percBar.alpha = 1;
				break;
			}
		}
		public function setStop(val:String):void
		{
			switch(val)
			{
				case "On":
				_stopBtn.alpha = 1;
				_stopBtn.addEventListener(MouseEvent.CLICK, onStopClick);
				break;
				
				case "Off":
				_stopBtn.alpha = 0.5;
				_stopBtn.removeEventListener(MouseEvent.CLICK, onStopClick);
				break;
			}
		}
		public function setProgressBar(val:String):void
		{
			switch(val)
			{
				case "On":
				_progBar.alpha = 1;
				_progBar.addEventListener(MouseEvent.MOUSE_DOWN, onPosClick);
				break;
				
				case "Off":
				_progBar.alpha = 0.5;
				_progBar.removeEventListener(MouseEvent.MOUSE_DOWN, onPosClick);
				break;
			}
		}
		public function setNext(val:String):void
		{
			switch(val)
			{
				case "On":
				_nextBtn.alpha = 1;
				_nextBtn.addEventListener(MouseEvent.CLICK, onNextClick);
				break;
				
				case "Off":
				_nextBtn.alpha = 0.5;
				_nextBtn.removeEventListener(MouseEvent.CLICK, onNextClick);
			}
		}
		public function setPrev(val:String):void
		{
			switch(val)
			{
				case "On":
				_prevBtn.alpha = 1;
				_prevBtn.addEventListener(MouseEvent.CLICK, onPrevClick);
				break;
				
				case "Off":
				_prevBtn.alpha = 0.5;
				_prevBtn.removeEventListener(MouseEvent.CLICK, onPrevClick);
			}
		}
		public function togglePlayPause(val:String):void
		{
			switch(val)
			{
				case "Play":
				_pauseBtn.visible = true;
				_playBtn.visible = false;
				break;
				
				case "Pause":
				_pauseBtn.visible = false;
				_playBtn.visible = true;
				break;
			}
		}
		public function set artistInfo(val:String):void
		{
			_artistInfo = val;
			_id3Artist.text = "Artist: " + _artistInfo;
		}
		public function set trackInfo(val:String):void
		{
			_trackInfo = val;
			_id3Track.text = "Track: " + _trackInfo;
		}
		public function set albumInfo(val:String):void
		{
			_albumInfo = val;
			_id3Album.text = "Album: " + _albumInfo;
		}
		private function onOpen(e:Event):void
		{
			dispatchEvent(new ControlEvent("Open"));
		}
		public function addListItem(label:String, path:String, icon:Bitmap):void
		{
			_list.addItem({label:label, _path:path, _icon:icon});
			if(_list.length == 1)
			{
				_list.selectedIndex = 0;
				_doubleClickItem = _list.selectedItem;
				_doubleClickIndex = _list.selectedIndex;
				dispatchEvent(new ListPopulatedEvent());
			}
		}
		public function get DoubleClickItem():Object
		{
			return _doubleClickItem;
		}
		public function set ListItem(val:uint):void
		{
			_prevIndex = _doubleClickIndex;
			_doubleClickIndex = val;
			_list.selectedIndex = _doubleClickIndex;
			_doubleClickItem = _list.selectedItem;
		}
		public function get CurrentIndex():uint
		{
			return _doubleClickIndex;
		}
		public function get PlaylistCount():Number
		{
			return _list.length;
		}
		public function set Percent(val:Number):void
		{
			_percBar.value = val;
		}
		public function setProgBarVals(min:Number,max:Number):void
		{
			_progBar.minimum = min;
			_progBar.maximum = max;
		}
		public function setProgBarVal(val:Number):void
		{
			_progBar.value = val;
		}
		public function get ProgBarVal():Number
		{
			return _progBar.value;
		}
		private function onNextClick(e:Event):void
		{
			dispatchEvent(new ControlEvent("Next"));
		}
		private function onPrevClick(e:Event):void
		{
			dispatchEvent(new ControlEvent("Prev"));
		}
		public function setTimeText(label:String):void
		{
			_timeLabel.text = label;
		}
		public function setVis(data:ByteArray):void
		{
			_visualizer.doVis(data);
		}
		public function set icon(_val:String):void
		{
			var icon:Bitmap;
			var bmd:BitmapData;
			var label:String;
			var _path:String;
			
			switch(_val)
			{
				case "Pause":
				
				icon = new Bitmap()
				bmd = new BitmapData(_icons.__bullet_purple.width,_icons.__bullet_purple.height,true,0x000000);
				bmd.draw(_icons.__bullet_purple);
				icon.bitmapData = bmd;
				//_ui.icon = icon;
				
				//_icon = val;
				label = _list.selectedItem.label;
				_path = _list.selectedItem._path;
				_list.removeItemAt(_doubleClickIndex);
				//_list.selectedItem._icon = _icon;
				//addListItem(label,_path,_icon);
				_list.addItemAt({label:label, _path:_path, _icon:icon}, _doubleClickIndex);
				_list.selectedIndex = _doubleClickIndex;
				
				break				
				
				case "Next":
				
				icon = new Bitmap()
				bmd = new BitmapData(_icons.__bullet_red.width,_icons.__bullet_red.height,true,0x000000);
				bmd.draw(_icons.__bullet_red);
				icon.bitmapData = bmd;
				//_ui.icon = icon;
				
				//_icon = val;
				label = _list.selectedItem.label;
				_path = _list.selectedItem._path;
				_list.removeItemAt(_doubleClickIndex);
				//_list.selectedItem._icon = _icon;
				//addListItem(label,_path,_icon);
				_list.addItemAt({label:label, _path:_path, _icon:icon}, _doubleClickIndex);
				_list.selectedIndex = _doubleClickIndex;
			
				break;
			
				case "Play":
					
				icon = new Bitmap()
				bmd = new BitmapData(_icons.__bullet_red.width,_icons.__bullet_red.height,true,0x000000);
				bmd.draw(_icons.__bullet_red);
				icon.bitmapData = bmd;
				//_ui.icon = icon;
				
				//_icon = val;
				label = _list.getItemAt(_prevIndex).label;
				_path = _list.getItemAt(_prevIndex)._path;
				_list.removeItemAt(_prevIndex);
				//_list.selectedItem._icon = _icon;
				//addListItem(label,_path,_icon);
				_list.addItemAt({label:label, _path:_path, _icon:icon}, _prevIndex);
				_list.selectedIndex = _doubleClickIndex;					
								
				icon = new Bitmap()
				bmd = new BitmapData(_icons.__bullet_green.width,_icons.__bullet_green.height,true,0x000000);
				bmd.draw(_icons.__bullet_green);
				icon.bitmapData = bmd;
				//_ui.icon = icon;
				
				//_icon = val;
				label = _list.selectedItem.label;
				_path = _list.selectedItem._path;
				_list.removeItemAt(_doubleClickIndex);
				//_list.selectedItem._icon = _icon;
				//addListItem(label,_path,_icon);
				_list.addItemAt({label:label, _path:_path, _icon:icon}, _doubleClickIndex);
				_list.selectedIndex = _doubleClickIndex;
				break;
				
				case "Stop":
				icon = new Bitmap()
				bmd = new BitmapData(_icons.__bullet_red.width,_icons.__bullet_red.height,true,0x000000);
				bmd.draw(_icons.__bullet_red);
				icon.bitmapData = bmd;
				//_ui.prevIcon = icon;
				
				//_icon = val;
				label = _list.selectedItem.label;
				_path = _list.selectedItem._path;
				_list.removeItemAt(_doubleClickIndex);
				//_list.selectedItem._icon = _icon;
				//addListItem(label,_path,_icon);
				_list.addItemAt({label:label, _path:_path, _icon:icon}, _doubleClickIndex);
				_list.selectedIndex = _doubleClickIndex;
				break;
			}
			
			//_icon = val;
			
			/*
			**
			*/
			
		}
	}
}