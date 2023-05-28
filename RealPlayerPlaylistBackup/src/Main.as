package {
	import com.arcticcode.greenFlames.xPreloader.XPreloader;
	
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragManager;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.NativeDragEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.net.FileReference;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	[SWF(width=500,height=100,backgroundColor=0xffffff)]
	public class Main extends Sprite
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;	
		private var base:Sprite = new Sprite();
		private var playlist:XML;
		private var fileName:String;
		private var loader:XPreloader = new XPreloader("", "xml", false);
		private var filePaths:Array = new Array();
		private var targetDir:File;
		private var tf:TextField;
		
		[Embed(source="dadha__.ttf", mimeType="application/x-font-truetype", fontName="Dadhand")]
		private var _dadhand:Class;
		
		public function Main()
		{
			stage.nativeWindow.title = "Real Player Backup";
			
			initBase();
			init();
		}
		private function initBase():void
		{
			base.graphics.beginFill(0xffffff);
			base.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
			base.graphics.endFill();
			addChild(base);
			
			tf = new TextField();
			tf.selectable = false;
			tf.defaultTextFormat = new TextFormat("Dadhand", 20, 0x000000);
			tf.text = "Drag playlist here";
			tf.embedFonts = true;
			tf.autoSize = "left";
			addChild(tf);
		}
		private function init():void
		{
			stage.nativeWindow.visible = true;
			
			loader.addEventListener(Event.COMPLETE, xmlLoaded_Handler);
			
			base.addEventListener(NativeDragEvent.NATIVE_DRAG_ENTER, dragEnter_Handler);
			base.addEventListener(NativeDragEvent.NATIVE_DRAG_DROP, dragDrop_Handler);
		}
		private function dragEnter_Handler(e:NativeDragEvent):void
		{
			var cb:Clipboard = e.clipboard;
			var f:Object = cb.getData(ClipboardFormats.FILE_LIST_FORMAT);
			if(f[0].extension == "RMP")
			{
				NativeDragManager.acceptDragDrop(base);
			}
		}
		private function dragDrop_Handler(e:NativeDragEvent):void
		{
			var f:File = e.clipboard.getData(ClipboardFormats.FILE_LIST_FORMAT)[0] as File;
			//trace(f.url);
			loader.loadURL(f.url,"xml",true);
		}
		private function xmlLoaded_Handler(e:Event):void
		{
			playlist = new XML(e.target.content);
			//trace(playlist);
			
			for each(var path:String in playlist.TRACKLIST.TRACK.FILENAME)
			{
				//trace(path);
				filePaths.push(path);
			}
			
			var f:File = new File();
			f.browseForDirectory("Choose Target Directory");
			f.addEventListener(Event.SELECT, targetDirSelect_Handler);
		}
		private function targetDirSelect_Handler(e:Event):void
		{
			targetDir = e.target as File;
			startCopy();
		}
		private function startCopy():void
		{
			var f:File;
			var fr:FileReference;
			
			for(var i:uint = 0;i<filePaths.length;i++)
			{
				f = new File();
				f = f.resolvePath(filePaths[i]);
				trace(f.nativePath);
				fileName = f.name;
				fr = targetDir.resolvePath(f.name);				
				f.copyToAsync(fr,false);
				f.addEventListener(ProgressEvent.PROGRESS, progress_Handler);
			}
			tf.text = "Complete" + playlist.TITLE;
		}
		private function progress_Handler(e:ProgressEvent):void
		{
			tf.text = fileName + Math.floor((e.bytesLoaded / e.bytesTotal * 100)).toString() + "%";
		}
	}
}
