package
{
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	[SWF(width=640, height = 480, backgroundColor = 0x000000)]
	public class ActiveTuts extends Sprite
	{
		
		[Embed(source='assets/Digital-Readout-Upright.ttf', fontName = 'Digital Readout Upright', mimeType = 'application/x-font-truetype')]
		private var DigitalReadoutFont:Class;
		
		private var _bgFormat:TextFormat;
		
		private var _bgTextField:TextField;
		
		private var _fgFormat:TextFormat;
		
		private var _fgTextField:TextField;
		
		private var _innerGlow:GlowFilter;
		
		private var _outerGlow:GlowFilter;
		
		private var _blur:BlurFilter;
		
		//colours
		private var _textColour:uint = 0xF4C28B;
		
		private var _bgTextColour:uint = 0x333333;
		
		private var centerX:Number = stage.stageWidth * 0.5;
		
		private var centerY:Number = stage.stageHeight * 0.5;
		
		private const EIGHT:String = "8";
		
		private var _number:Number = 1;
		
		private var _value:String = '000000000000000000000000';
		
		public function ActiveTuts()
		{
			_blur = new BlurFilter(3.0, 3.0, 1.0);
			_bgFormat = new TextFormat('Digital Readout Upright', 40, _bgTextColour);
			_bgTextField = new TextField();
			_bgTextField.embedFonts = true;
			_bgTextField.selectable = false;
			_bgTextField.autoSize = TextFieldAutoSize.CENTER;
			_bgTextField.defaultTextFormat = _bgFormat;
			_bgTextField.text = "";
			addChild(_bgTextField);
			_bgTextField.x = centerX - _bgTextField.width * 0.5;
			_bgTextField.y = centerY - _bgTextField.height * 0.5;
			_bgTextField.filters = [_blur];
			
			_innerGlow = new GlowFilter(0xFF0000, 1.0, 2.0, 2.0, 2, 1.0, true);
			_outerGlow = new GlowFilter(0xFF0000, 1.0, 5.0, 5.0, 2.0, 1.0, false);
			_fgFormat = new TextFormat('Digital Readout Upright', 40, _textColour);
			_fgTextField = new TextField();
			_fgTextField.embedFonts = true;
			_fgTextField.selectable = false;
			_fgTextField.autoSize = TextFieldAutoSize.CENTER;
			_fgTextField.defaultTextFormat = _fgFormat;
			_fgTextField.text = "";
			addChild(_fgTextField);
			_fgTextField.x = _bgTextField.x;
			_fgTextField.y = _bgTextField.y;
			_fgTextField.filters = [_outerGlow, _innerGlow];
			
			updateFields();
		}
		
		private function updateFields():void
		{
			var arr:Array = _value.split("");
			arr = arr.reverse();
			var arr2:Array = new Array();
			trace(arr);
			var i:uint;
			var len:uint = arr.length;
			var commaInt:uint = 1;
			
			for(i = 0; i < len; i++)
			{
				arr2.push(arr[i].toString());
				trace(i);
				if(commaInt == 3 && i != len - 1)
				{
					arr2.push(",");
					commaInt = 1;
				}
				else
				{
					commaInt += 1;
				}
			}
			trace(arr2);
			
			var fgStr:String = "";
			var bgStr:String = "";
			len = arr2.length;
			arr2 = arr2.reverse();
			
			for(i = 0; i < len; i++)
			{
				fgStr += arr2[i];
				if(arr2[i] != ",")
				{
					bgStr += EIGHT;
				}
				else
				{
					bgStr += ",";
				}
			}
			
			_fgTextField.text = fgStr;
			_bgTextField.text = bgStr;
			arr.splice(0, arr.length);
			arr2.splice(0, arr2.length);
			arr = arr2 = null;
			i = commaInt = len = NaN;
		}
	}
}