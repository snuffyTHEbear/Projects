package
{
	import com.arcticcode.greenFlames.string.StringUtils;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	[SWF(width=600, height = 400, backgroundColor = 0xFFFFFF)]
	public class TextScramble extends Sprite
	{
		private var tf:TextField;
		
		private var targetString:String = "My Text 2008";
		
		private var count:uint = targetString.length;
		
		private var currString:String;
		
		private var chars:String = StringUtils.ALPHABET;
		
		private var arr:Array;
		
		private var char:String = "";
		
		public function TextScramble()
		{
			init();
		}
		
		private function init():void
		{
			tf = new TextField();
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.defaultTextFormat = new TextFormat("Verdana", 12, 0);
			addChild(tf);
			tf.selectable = false;
			tf.text = "            ";
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void
		{
			tf.text = StringUtils.unscramble(tf.text, targetString, true, true, false, true, " ");
			tf.text == targetString ? removeEventListener(Event.ENTER_FRAME, loop) : null;
		}
	}
}