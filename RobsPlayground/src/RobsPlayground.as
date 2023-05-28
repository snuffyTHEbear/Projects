/*==============================================*/
/*   Sasori Daniels - http://arctic-code.com    */
/*==============================================*/
package
{
	import com.arcticcode.greenFlames.text.SimpleTextField;
	import com.arcticcode.greenFlames.web.colourlovers.ColorPalette;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	import mx.graphics.codec.JPEGEncoder;
	import mx.graphics.codec.PNGEncoder;

	[SWF(width = 1024, height = 640, backgroundColor = 0xFFFFFF, frameRate = 60)]
	public class RobsPlayground extends Sprite
	{
		public function RobsPlayground()
		{
			stage.scaleMode = "noScale";
			stage.align = StageAlign.TOP_LEFT;
			addEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, stageKeyDown);
			_output = new SimpleTextField(new TextFormat("Verdana", 12, 0xcc0000, true), "left", false, "normal", false);
			_output.text = 'Shit Face';
		}
		public var _output:SimpleTextField;
		private const IMAGE_FOLDER:String = "CoronaCurves/";
		private const JPEG_EXT:String = ".jpg";
		private const PNG_EXT:String = ".png";
		private var _ba:ByteArray;
		private var _buffer:BitmapData;
		private var _child:CoronaCurves;
		private var _colourIDS:Array = [524168, 17656, 54937, 416175, 474546, 932683, 1046104, 919313, 1011738, 1035600, 1046074, 1046081, 1046083, 1046087, 338087, 92095, 1045979, 1045982, 1040284, 1033084, 1046064, 1046067, 1046071];
		private var _colourInc:uint = 0;
		private var _colours:ColorPalette;
		private var _file:File;
		private var _imageNum:uint = 0;
		private var _jpeg:JPEGEncoder;
		private var _png:PNGEncoder;
		private var _started:Boolean = false;
		private var _stream:FileStream;

		private function curvesComplete():void
		{
			_output.text = "Complete";
		}

		//Returns a unique new image file reference
		//with specified extension
		private function getNewImageFile(ext:String):File
		{
			//Create a new unique filename based on date/time
			var fileName:String = "image" + getNowTimestamp() + ext;
			//Create a reference to a new file on app folder
			//We use resolvepath to get a file object that points to the correct 
			//image folder - [USER]/[Documents]/[YOUR_APP_NAME]/images/
			//it also creates any directory that does not exists in the path
			var fl:File = File.documentsDirectory.resolvePath(IMAGE_FOLDER + fileName);
			//verify that the file really does not exist
			if (fl.exists)
			{
				//if exists , tries to get a new one using recursion
				return getNewImageFile(ext);
			}
			return fl;
		}

		/**
		 * @return - String in the format (DayMonthYear_HoursMinutesSecondsMilliseconds
		 */
		private function getNowTimestamp():String
		{
			var d:Date = new Date();
			var tstamp:String = d.getDate().toString() + d.getMonth() + d.getFullYear() + "_" + d.getHours() + d.getMinutes() + d.getSeconds() + d.getMilliseconds();
			return tstamp;
		}

		private function init(e:Event):void
		{
			_colours = new ColorPalette(paletteLoaded);
			_colours.loadPalette(_colourIDS[_colourInc]);
			_child = new CoronaCurves(1024, 640, 150, 50, 50, curvesComplete, 0xFFFFFF);
			addChild(_child);
			_child.removeColours(0, 5);
			_child.start();
			_buffer = new BitmapData(1024,640, true, 0xFFFFFFFF);
			_stream = new FileStream();
			addChild(_output);
		}

		private function paletteLoaded():void
		{
			for (var i:uint = 0; i < _colours.colours.length; i++)
			{
				_child.addColour(_colours.colours[i]);
			}
			if (_colourInc < _colourIDS.length)
			{
				_colourInc += 1;
				_colours = new ColorPalette(paletteLoaded);
				_colours.loadPalette(_colourIDS[_colourInc]);
			}
			if (!_started)
			{
				_child.start();
				//_child.startBlur();
				_started = true;
			}
		}

		/**
		 *
		 * @param dp - DisplayObject to take snaphot of and save as an image (JPG)
		 *
		 */
		private function saveImage(dp:DisplayObject):void
		{
			_jpeg = new JPEGEncoder(100.0);
			_ba = new ByteArray();
			_stream = new FileStream();
			_buffer.draw(dp);
			_ba = _jpeg.encode(_buffer);
			_file = getNewImageFile(JPEG_EXT);
			_stream.open(_file, FileMode.WRITE);
			_stream.writeBytes(_ba);
			_stream.close();
			_output.text = "";
		}

		private function stageKeyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.SPACE)
			{
				_child.pause();
			}
			else if (e.keyCode == Keyboard.R)
			{
				_output.text = "Saving..";
				saveImage(_child);
			}
		}
	}
}
