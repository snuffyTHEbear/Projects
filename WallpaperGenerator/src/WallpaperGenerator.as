package
{
	import com.arcticcode.greenFlames.filters.BasicFilterPanel;
	import com.arcticcode.greenFlames.filters.BasicFilters;
	import com.arcticcode.greenFlames.filters.FilterFactory;
	import com.arcticcode.greenFlames.math.MathUtils;
	import com.arcticcode.greenFlames.xPreloader.XPreloader;
	import com.arcticcode.purpleFlames.air.utils.AirUtils;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NativeWindowBoundsEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.utils.ByteArray;
	
	import mx.graphics.codec.JPEGEncoder;
	import mx.graphics.codec.PNGEncoder;
	
	[SWF(width = 800, height = 600)]
	public class WallpaperGenerator extends Sprite
	{
		private var _imageTypes:FileFilter = AirUtils.fileFilter("Image", ["jpg", "jpeg", "png"]);
		private var _imageFile:File;
		private var _image:Bitmap;
		private var _snapshot:BitmapData;
		private var _fileStream:FileStream;
		private var _openBtn:OpenButton;
		private var _exportBtn:ExportButton;
		private var _imageLoader:XPreloader;
		private var _jpeg:JPEGEncoder;
		private var _png:PNGEncoder;
		private var _fileName:String;
		private var _fileDir:String;
		private var _export:File;
		private var _dump:Object = {scale:1};
		private var _filterPanel:BasicFilterPanel;
		
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;
		
		
		public function WallpaperGenerator()
		{
			stage.scaleMode = "noScale";
			stage.align = "topLeft";
			
			stage.nativeWindow.addEventListener(NativeWindowBoundsEvent.RESIZE, stageResize_Handler);
			stage.nativeWindow.addEventListener(NativeWindowBoundsEvent.RESIZING, stageResize_Handler);
			
			_filterPanel = new BasicFilterPanel(FilterFactory.DROP_SHADOW_FILTER);
			
			initUI();
			init();
		}
		
		private function stageResize_Handler(e:Event):void
		{
			resize();
		}
		private function resize():void
		{
			centreX = stage.nativeWindow.width * 0.5;
			centreY = stage.nativeWindow.height * 0.5;
			_image != null ? move(_image, centreX - _image.width * 0.5, centreY - _image.height * 0.5) : {};
		}
		
		private function initUI():void
		{
			_openBtn = new OpenButton();
			_openBtn.filters = [BasicFilters.BasicDropShadow()];
			move(_openBtn, 10, 10);
			addChild(_openBtn);
			
			_exportBtn = new ExportButton();
			_exportBtn.filters = [BasicFilters.BasicDropShadow()];
			move(_exportBtn, 10, 50);
			addChild(_exportBtn);
		}
		
		private function move(obj:Object, x:Number, y:Number):void
		{
			obj.x = x;
			obj.y = y;
		}
		
		private function init():void
		{
			stage.nativeWindow.visible = true;
			
			_exportBtn.addEventListener(MouseEvent.CLICK, exportBtnClick_Handler);
			_openBtn.addEventListener(MouseEvent.CLICK, openBtnClick_Handler);
		}
		
		private function openBtnClick_Handler(e:Event):void
		{
			openImage();
		}
		
		private function exportBtnClick_Handler(e:MouseEvent):void
		{
			exportImage();
		}
		
		private function openImage():void
		{
			_imageFile = new File();
			_imageFile.browse([_imageTypes]);
			_imageFile.addEventListener(Event.SELECT, imageFileSelect_Handler);
		}
		private function prepareExport(exporting:Boolean):void
		{
			if(exporting)
			{
				_openBtn.visible = _exportBtn.visible = false;
				stage.nativeWindow.width = _image.width + 70;
				stage.nativeWindow.height = _image.height + 70;
			}
			else
			{
				_openBtn.visible = _exportBtn.visible = true;
				stage.nativeWindow.width = _dump.width;
				stage.nativeWindow.height = _dump.height;
			}
		}
		private function exportImage():void
		{
			_image.scaleX = _image.scaleY = 1;
			_snapshot = new BitmapData(_image.width + 70, _image.height + 70, true);
			_dump.width = stage.nativeWindow.width;
			_dump.height = stage.nativeWindow.height;
			prepareExport(true);
			resize();
			_snapshot.draw(this);
			_jpeg = new JPEGEncoder(100.0);
			var ba:ByteArray = _jpeg.encode(_snapshot);
			_fileStream = new FileStream();
			_export = _imageFile.resolvePath(_fileDir);
			_fileStream.openAsync(_export, FileMode.WRITE);
			_fileStream.writeBytes(ba);
			_fileStream.close();
			prepareExport(false);
			resize();
			_image.scaleX = _image.scaleY = _dump.scale;
			move(_image, centreX - _image.width * 0.5, centreY - _image.height * 0.5);
		}
		
		private function imageFileSelect_Handler(e:Event):void
		{
			_fileName = e.target.name;
			_fileDir = e.target.nativePath;
			_fileDir = _fileDir.replace(_fileName, "wallpaper_" + _fileName);
			_imageLoader = new XPreloader(e.target.url, XPreloader.IMAGE, false);
			_imageLoader.addEventListener(Event.COMPLETE, imageLoaderComplete_Handler);
			_imageLoader.load();
		}
		private function imageLoaderComplete_Handler(e:Event):void
		{
			_image = e.target.content as Bitmap;
			if(_image.width > stage.stageWidth)
			{
				scaleImageDown(_image.width, stage.stageWidth);
			}
			else if(_image.height > stage.stageHeight)
			{
				scaleImageDown(_image.height, stage.stageHeight);
			}
			move(_image, centreX - _image.width * 0.5, centreY - _image.height * 0.5);
			addChild(_image);
			_image.filters = [BasicFilters.BasicDropShadow(16.0, 16.0)];
		}
		private function scaleImageDown(amount:Number, total:Number):void
		{
			_image.scaleX = _image.scaleY = MathUtils.percent(amount, total, 0.5);
			_dump.scale = _image.scaleX;
		}
	}
}