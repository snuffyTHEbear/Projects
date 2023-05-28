package
{
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class Button extends SimpleButton
	{
		private var _upState:Sprite;
		private var _downState:Sprite;
		private var _icon:DisplayObject;
		private var _iconDown:DisplayObject;
		private var _text:String;
		private var _useIcon:Boolean;
		private var _useText:Boolean;
		
		[Embed(source="dadhand.ttf", fontName="dadhand", mimeType="application/x-font-truetype")]
		private var Dadhand:Class;
				
		public function Button(icon:DisplayObject=null,text:String=null,iconDown:DisplayObject=null)
		{
			if(icon == null && iconDown == null)
			{
				_useIcon = false;
			}
			else
			{
				_useIcon = true;
				_icon = icon;
				_iconDown = iconDown;
			}
			if(text == null)
			{
				_useText = false;
			}
			else
			{
				_useText = true;
				_text = text;
			}
			
			upState = createUpState();
			downState = createDownState();
			super(upState,upState,downState,downState);	
		}
		private function createUpState():Sprite
		{
			var s:Sprite = new Sprite();
			if(_useIcon)
			{
				s.addChild(_icon);
			}
			if(_useText)
			{
				if(_text != "")
				{
					var _tf:TextField = new TextField();
					_tf.mouseEnabled = false;
					_tf.defaultTextFormat = new TextFormat("dadhand", 12, 0x666666);
					_tf.autoSize = TextFieldAutoSize.LEFT;
					_tf.embedFonts = true;
					_tf.text = _text;
					if(_useIcon)
					{
						_icon.x = _tf.width;
					}
					_tf.y  = -1
					s.addChild(_tf);
				}
			}
			
			return s;
		}
		private function createDownState():Sprite
		{
			var s:Sprite = new Sprite();
			if(_useIcon && _iconDown != null)
			{
				s.addChild(_iconDown);
			}
			if(_useText)
			{
				if(_text != "")
				{
					var _tf:TextField = new TextField();
					_tf.mouseEnabled = false;
					_tf.defaultTextFormat = new TextFormat("dadhand", 12, 0x666666);
					_tf.autoSize = TextFieldAutoSize.LEFT;
					_tf.embedFonts = true;
					_tf.text = _text;
					if(_useIcon && _iconDown != null)
					{
						_icon.x = _tf.width;
					}
					_tf.y  = -1
					s.addChild(_tf);
				}
			}
			
			return s;
		}
	}
}