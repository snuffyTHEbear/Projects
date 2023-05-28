package Assets.PlayerCore.File
{
	import Assets.Events.AddToPlaylist;
	
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragManager;
	import flash.display.Sprite;
	import flash.events.NativeDragEvent;
	import flash.filesystem.File;
	
	public class DragDropManager extends Sprite
	{
		private var _base:Sprite;
		private var _fileList:Array;
		private var _fileSort:FileDirSort;
		private var _ext:String;
		public function DragDropManager(base:Sprite, ext:String)
		{
			this._base = base;
			this._ext = ext;
			init();
		}
		private function init():void
		{
			_fileSort = new FileDirSort();
			_fileSort.addEventListener(AddToPlaylist.ADD_ITEM, onAddItem);
			
			_base.addEventListener(NativeDragEvent.NATIVE_DRAG_ENTER, onDragEnter);
			_base.addEventListener(NativeDragEvent.NATIVE_DRAG_DROP, onDragDrop);
		}
		private function onDragEnter(e:NativeDragEvent):void
		{
			var clip:Clipboard = e.clipboard;
			var f:Object = clip.getData(ClipboardFormats.FILE_LIST_FORMAT);
			if(f[0].isDirectory && f.length == 1)
			{
				_fileList = f[0].getDirectoryListing();
				NativeDragManager.acceptDragDrop(_base);
			}
			else if(f.length>1)
			{
				_fileList = new Array();
				for(var i:uint = 0;i<f.length;i++)
				{
					var folder:File = File(f[i]);
					_fileList.push(folder);
				}
				NativeDragManager.acceptDragDrop(_base);
			}
			else if(f[0].extension == _ext && f.length == 1)
			{
				_fileList = new Array();
				_fileList.push(f[0]);
				NativeDragManager.acceptDragDrop(_base);
			}
			else if(f.length > 1)
			{
				_fileList = new Array();
				for(var g:uint=0;g<f.length;g++)
				{
					var file:File = File(f[g]);
					_fileList.push(file);
				}
				NativeDragManager.acceptDragDrop(_base);
			}
		}
		private function onDragDrop(e:NativeDragEvent):void
		{
			_fileSort.sort(_fileList, "mp3");
		}
		private function onAddItem(e:AddToPlaylist):void
		{
			addItem(e._file);
		}
		private function addItem(file:File):void
		{
			dispatchEvent(new AddToPlaylist(file));
		}
	}
}