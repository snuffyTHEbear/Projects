package Assets.PlayerCore.File
{
	import Assets.Events.AddToPlaylist;
	
	import flash.display.Sprite;
	import flash.filesystem.File;
	
	public class FileDirSort extends Sprite
	{
		private var _fileList:Array;
		private var _ext:String;
		
		public function FileDirSort()
		{
			
		}
		public function sort(fileList:Array, ext:String):void
		{
			this._fileList = fileList;
			this._ext = ext;
			
			for(var i:uint = 0;i < _fileList.length;i++)
			{
				var _file:File = File(_fileList[i]);
				doFileCheck(_file);
			}
		}
		/*
		private function onFilesOpened(e:FileListEvent):void
		{
			for(var r:uint=0;r<fileList.length;r++)
			{
				file = File(fileList[r]);
				doFileCheck(file);
			}
			if(!isPlaying && list.length == 0)
			{
				playBtn.addEventListener(MouseEvent.CLICK, onPlayClick);
				playBtn.alpha = 1;
				list.selectedIndex = 0;
				doPlay(String(list.selectedItem.path));
			}
		}
		private function onDirOpened(e:Event):void
		{
			var _file:File = e.target as File;
			var f:Array = _file.getDirectoryListing();
			if(f[0].isDirectory && f.length == 1)
			{
				fileList = f[0].getDirectoryListing();
			}
			else if(f.length>1)
			{
				fileList = new Array();
				for(var i:uint = 0;i<f.length;i++)
				{
					var folder:File = File(f[i]);
					fileList.push(folder);
				}
			}
			//
			for(var r:uint=0;r<fileList.length;r++)
			{
				file = File(fileList[r]);
				doFileCheck(file);
			}
			if(!isPlaying && !list.selectedItem)
			{
				playBtn.addEventListener(MouseEvent.CLICK, onPlayClick);
				playBtn.alpha = 1;
				list.selectedIndex = 0;
				doPlay(String(list.selectedItem.path));
			}
		}
		*/
		private function doFileCheck(file:File):void
		{
			if(file.extension == _ext)
			{
				//url = file.url;
				//fileName = file.name;
				//addListItem(fileName,url);
				//trace(file.nativePath,file.name);
				dispatchEvent(new AddToPlaylist(file));
			}
			else if(file.isDirectory)
			{
				doDirCheck(file);
			}
		}
		private function doDirCheck(file:File):void
		{
			var fileDeep:Array = file.getDirectoryListing();
			for(var j:uint=0;j<fileDeep.length;j++)
			{
				var fileTwo:File = File(fileDeep[j]);
				doFileCheck(fileTwo);
			}
		}
	}
}