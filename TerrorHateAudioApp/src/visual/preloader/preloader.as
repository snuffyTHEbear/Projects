package visual.preloader
{
	import com.arcticcode.greenFlames.graphics.CreateRect;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class preloader extends Sprite
	{
		private var _bar:CreateRect;
		private var _tf:TextField;
		private var _f:TextFormat;
		private var _bmd:BitmapData;
		private var _font:Font;
		
		public function preloader(font:Font)
		{
			_font = font;
			
			_tf = new TextField();
			_tf.autoSize = "left";
			_tf.embedFonts = true;
			_f = new TextFormat(_font.fontName,15,0xffffff);
			_tf.defaultTextFormat = _f;
			addChild(_tf);
			_tf.y = 30;
			
			_bar = new CreateRect(0,7.5,0xffffff,1,true,null);
			addChild(_bar);
			
			_bmd = new BitmapData(210,50,true,0);
		}
		public  function barWidth(val:Number):void
		{
			_bar.width = val;
		}
		public function setText(val:String):void
		{
			_tf.text = val;
		}
		public function get bitmapData():BitmapData
		{
			_bmd.draw(this,this.transform.matrix);
			return _bmd;
		}
	}
}