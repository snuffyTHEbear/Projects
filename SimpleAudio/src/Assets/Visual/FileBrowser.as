package Assets.Visual
{
	import Assets.Events.AddToPlaylist;
	import Assets.PlayerCore.File.FileDirSort;
	import Assets.UI_Icons.UIIcons;
	
	import caurina.transitions.Tweener;
	
	import com.bit101.components.Label;
	
	import fl.controls.List;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filters.DropShadowFilter;
	
	import robDaniels.greenFlames.src.graphics.CreateRect;
	import robDaniels.greenFlames.src.graphics.CreateRoundRect;
	import robDaniels.greenFlames.src.preloader.ContentLoadedEvent;
	import robDaniels.greenFlames.src.preloader.Preloader;
	
	public class FileBrowser extends Sprite
	{
		private var _mask:CreateRect;
		private var _parent:CreateRoundRect;
		private var _changeMask:CreateRoundRect;
		private var _list:List;
		private var _dir:File;
		private var _ext:String;
		private var _addBtn:SimpleButton;
		private var _info:Label;
		private var _upBtn:SimpleButton;
		private var _closeBtn:SimpleButton;
		private var _currDir:Label;
		//List Icons
		[Embed(source="Assets/list_icons/page_sound.gif")]
		private var __file:Class;
		[Embed(source="Assets/list_icons/folder.gif")]
		private var __folder:Class;
		[Embed(source="Assets/list_icons/arrow_right.gif")]
		private var __folderOpen:Class;
		private var _folderOpen:Bitmap;
		private var _popup:CreateRoundRect;
		private var _yesBtn:SimpleButton;
		private var _noBtn:SimpleButton;
		private var _message:Label;
		private var _topMessage:Label;
		private var _changeDriveBtn:SimpleButton;
		private var _dataPath:String;
		private var _showPopup:Boolean;
		
		//
		private var _icons:UIIcons;
		
		private var _fileSort:FileDirSort;
		private var _xmlLoader:Preloader;
		
		public function FileBrowser(ext:String, dataPath:String)
		{
			this._ext = ext;
			this._dataPath = dataPath;
			_icons = new UIIcons();
			_xmlLoader = new Preloader(_dataPath);
			_xmlLoader.addEventListener(ContentLoadedEvent.CONTENT_LOADED, onXml);
		}
		private function onXml(e:ContentLoadedEvent):void
		{
			var xml:XML = e.content as XML;
			var _d:String = xml.data.@DEFAULT_DRIVE;
			trace(_d);
			if(_d == "null")
			{
				_dir = File.documentsDirectory;
			}
			else
			{
				_dir = new File;
				_dir.nativePath = _d;
			}
			var _sp:String = xml.data.@SHOW_POPUP;
			if(_sp == "true")
			{
				_showPopup = true;
			}
			else
			{
				_showPopup = false;
			}
			 init();
		}
		private function init():void
		{
			_fileSort = new FileDirSort();
			_fileSort.addEventListener(AddToPlaylist.ADD_ITEM, onAddItem);
			
			_mask = new CreateRect(700,600,0xcccccc,0.95,true,0,0);
			addChild(_mask);
						
			_parent = new CreateRoundRect(310,550,0xffffff,1,true,195,25,15,15);
			_mask.addChild(_parent);
			
			_changeMask = new CreateRoundRect(310,550,0xcccccc,0,true,195,25,15,15);
			_changeMask.visible = false;
			_mask.addChild(_changeMask);
			
			_list = new List();
			_list.setSize(300, 485);
			_list.move(5,20);
			_list.doubleClickEnabled = true;
			_list.allowMultipleSelection = true;
			_list.iconField = "_icon";
			_parent.addToDisplayList(_list);
			
			_addBtn = new SimpleButton(null,_icons.__add, "Add to Playlist*", 5, 510,addItems,null);
			_parent.addToDisplayList(_addBtn);
			
			_info = new Label(null, 5,530,"*Multiple files or directories can be added.");
			_parent.addToDisplayList(_info);
			
			_upBtn = new SimpleButton(null,_icons.__arrow_up, "Up", 210, 510, onUp, null);
			_parent.addToDisplayList(_upBtn);
			
			_closeBtn = new SimpleButton(null,_icons.__cancel,"Close",260, 510, onClose, null);
			_parent.addToDisplayList(_closeBtn);
			
			_currDir = new Label(null,25,0,_dir.name);
			_parent.addToDisplayList(_currDir);
			
			_folderOpen = new __folderOpen();
			_folderOpen.x = 5;
			_folderOpen.y = 2;
			_parent.addToDisplayList(_folderOpen);
			
			_changeDriveBtn = new SimpleButton(null,_icons.__drive,"Change Drive", 110,510, changeDrive,null);
			_parent.addToDisplayList(_changeDriveBtn);
			
			_popup = new CreateRoundRect(350, 150,0xdcdcdc,0,false,350,300,15,15);
			_popup.filters = [new DropShadowFilter(0,90,0x000000,1,5,5,1,3)];
			addChild(_popup);
			
			_yesBtn = new SimpleButton(null,_icons.__icon_accept, "Yes*", -95,-15,onYes,null);
			_yesBtn.alpha = 0;
			_popup.addToDisplayList(_yesBtn);
			
			_noBtn = new SimpleButton(null,_icons.__cross,"No",60,-15,onNo,null);
			_noBtn.alpha = 0;
			_popup.addToDisplayList(_noBtn);
			
			_message = new Label(null,-140,30,"*This will open a popup in which you can choose a different drive");
			_message.alpha = 0;
			_popup.addToDisplayList(_message);
			
			_topMessage = new Label(null,-80,-50,"Do you wish to select another drive?");
			_topMessage.alpha = 0;
			_popup.addToDisplayList(_topMessage);
			
			_popup.visible = false;
			_yesBtn.visible = false;
			_noBtn.visible = false;
			_topMessage.visible = false;
			_message.visible = false;
			
			doList();
		}
		private function clearList():void
		{
			_list.removeAll();
		}
		private function doList():void
		{
			if(_list.length > 0)
			{
				clearList();
				_list.removeEventListener(MouseEvent.DOUBLE_CLICK, onListOpen);
			}
			var _arr:Array = _dir.getDirectoryListing();
			for(var i:uint=0;i<_arr.length;i++)
			{
				var _file:File = File(_arr[i]);
				if(_file.extension == _ext || _file.isDirectory)
				{
					var _label:String = _file.name;
					var _data:String = _file.nativePath;
					var _iconType:Bitmap;
					if(_file.isDirectory)
					{
						_iconType = new __folder();
					}
					else
					{
						_iconType = new __file();
					}
					
					_list.addItem({label:_label,_path:_data,_icon:_iconType});
				}
				else
				{
					
				}
			}
			_list.sortItemsOn("_icon", Array.DESCENDING);
			_list.scrollToIndex(0);
			_currDir.text = _dir.name;
			_list.addEventListener(MouseEvent.DOUBLE_CLICK, onListOpen);
		}
		private function onListOpen(e:MouseEvent):void
		{
			var _file:File = new File(_list.selectedItem._path);
			if(_file.isDirectory)
			{
				_dir.nativePath = (_list.selectedItem._path);
				doList();
			}
			else
			{
				addItem(_file);
			}
		}
		private function addItems(e:Event):void
		{
			var _arr:Array = _list.selectedItems;
			var _array:Array = new Array();
			for(var a:uint=0;a<_arr.length;a++)
			{
				var _f:File = new File(_arr[a]._path);
				_array.push(_f);
			}
			_fileSort.sort(_array, _ext);
		}
		private function onAddItem(e:AddToPlaylist):void
		{
			addItem(e._file);
		}
		private function addItem(file:File):void
		{
			dispatchEvent(new AddToPlaylist(file));
		}
		private function onUp(e:Event):void
		{
			if(_dir.parent != null)
			{
				_dir.nativePath = _dir.parent.nativePath;
				doList();
			}
			else
			{
			}
		}
		private function changeDrive(e:Event):void
		{
			if(_showPopup)
			{
				_changeMask.visible = true;
				_changeMask.visible = true;
				_popup.visible = true;
				_yesBtn.visible = true;
				_noBtn.visible = true;
				_topMessage.visible = true;
				_message.visible = true;
				Tweener.addTween(_changeMask, {alpha:0.95, time:0.5});
				Tweener.addTween(_popup, {alpha:1, time:1.5, onComplete:tweenControls()});
			}
			else
			{
				doShowBrowser();
			}
		}
		private function tweenControls():void
		{
			Tweener.addTween(_yesBtn, {alpha:1, time:1});
			Tweener.addTween(_noBtn, {alpha:1, time:1});
			Tweener.addTween(_message, {alpha:1, time:1});
			Tweener.addTween(_topMessage, {alpha:1, time:1});
		}
		private function onYes(e:Event):void
		{
			doShowBrowser();
		}
		private function doShowBrowser():void
		{
			var _file:File = new File();
			_file.browseForDirectory("Please choose a new drive");
			_file.addEventListener(Event.SELECT, onOpenDir);
		}
		private function onOpenDir(e:Event):void
		{
			var _f:File = e.target as File;
			_dir.nativePath = _f.nativePath;
			removePopup();
			doList();
		}
		private function onNo(e:Event):void
		{
			removePopup();
		}
		private function removePopup():void
		{
			Tweener.addTween(_yesBtn, {alpha:0, time:0.5});
			Tweener.addTween(_noBtn, {alpha:0, time:0.5});
			Tweener.addTween(_message, {alpha:0, time:0.5});
			Tweener.addTween(_popup, {alpha:0, time:1});
			Tweener.addTween(_topMessage, {alpha:0, time:0.5});
			Tweener.addTween(_changeMask, {alpha:0, time:1.5,onComplete:doRemove()});
		}
		private function doRemove():void
		{
			_changeMask.visible = false;
			_popup.visible = false;
			_yesBtn.visible = false;
			_noBtn.visible = false;
			_topMessage.visible = false;
			_message.visible = false;
		}
		private function onClose(e:Event):void
		{
			_list.selectedItem = null;
			_list.scrollToIndex(0);
			this.parent.removeChild(this);
		}
	}
}