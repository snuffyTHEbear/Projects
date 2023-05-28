package Assets.Visual
{
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class SimpleButton extends Sprite
	{
		[Embed(source="/assets/pf_ronda_seven.ttf", fontName="PF Ronda Seven", mimeType="application/x-font")]
		private var Ronda:Class;
		
		private var _tf:TextField;
		private var _text:String;
		private var _b:Bitmap;
		private var __b:Bitmap;
		private var _sprite:Sprite;
		private var _x:Number;
		private var _y:Number
		private var _downIcon:Boolean = false;
		
		public function SimpleButton(parent:DisplayObjectContainer, icon:Bitmap, text:String,x:Number,y:Number, defaultHandler:Function, downIcon:Bitmap)
		{
			_x = x;
			_y = y;
			_b = icon;
			
			if(downIcon != null)
			{
				__b = downIcon;
				_downIcon = true;
			}
			
			_text = text;
			
			if(parent != null)
			{
				parent.addChild(this);
			}
			
			if(defaultHandler != null)
			{
				addEventListener(MouseEvent.CLICK, defaultHandler);
			}
			
			init();
		}
		private function init():void
		{
			this.x = _x;
			this.y = _y;
			_sprite = new Sprite();
			_sprite.addChild(_b);
			if(_downIcon)
			{
				__b.visible = false;
				_sprite.addChild(__b);
			}
			addChild(_sprite);
			_sprite.buttonMode = true;
			addText();
		}
		private function addText():void
		{
			if(_text != "")
			{
				_tf = new TextField();
				_tf.mouseEnabled = false;
				_tf.defaultTextFormat = new TextFormat("PF Ronda Seven", 8, 0x666666);
				_tf.autoSize = TextFieldAutoSize.LEFT;
				_tf.text = _text;
				_b.x = _tf.width;
				if(_downIcon)
				{
					__b.x = _tf.width;
				}
				_tf.y  = -1
				_sprite.addChild(_tf);
			}
			_sprite.graphics.beginFill(0xcccccc,0);
			_sprite.graphics.drawRect(0,0,_sprite.width, _sprite.height);
			_sprite.graphics.endFill();
			/*
			_sprite.graphics.beginFill(0xffffff,1);
			_sprite.graphics.drawRect(-3,-1,_sprite.width-2, _sprite.height-2);
			_sprite.graphics.endFill();
			*/
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		public function set text(val:String):void
		{
			_text = val;
			if(_tf != null)
			{
				_sprite.removeChild(_tf);
			}	
			addText();
		}
		public function get text():String
		{
			return _text;
		}
		private function onMouseDown(e:MouseEvent):void
		{
			if(_downIcon)
			{
				__b.visible = true;
				_b.visible = false;
			}
			else
			{
				var _glow:GlowFilter = new GlowFilter(0x5b9fde,0.75,3,3,2,1);
				_b.filters = [_glow];
			}
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		private function onMouseUp(e:MouseEvent):void
		{
			if(_downIcon)
			{
				__b.visible = false;
				_b.visible = true;
			}
			else
			{
				_b.filters = [];
			}
		}
	}
}