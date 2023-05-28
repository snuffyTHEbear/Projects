package
{
	import com.arcticcode.greenFlames.utils.DisplayUtils;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	[SWF(width=600,height=400,backgroundColor=0xFFFFFF)]
	public class TextScramble extends Sprite
	{
		private var tf:TextField;
		private var targetString:String="9999999999";
		private var currString:String;
		private var chars:String = "012345678";
		private var index:uint = 0;
		private var ind:uint = 0;
		
		public function TextScramble()
		{
			init();
		}
		private function init():void
		{
			tf = new TextField();
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.defaultTextFormat = new TextFormat("Verdana",12,0);
			addChild(tf);
			tf.selectable = false;
			
			currString = "0000000000";
			tf.text = currString;
			DisplayUtils.doCentreOne(tf,stage.stageWidth,stage.stageHeight);
		}
		private function scramble():void
		{
			addEventListener(Event.ENTER_FRAME,scrambleChars);
		}
		private function scrambleChars(e:Event):void
		{
			var str:String;
			
		}
		private function scrambleTo():void
		{
			
		}
	}
}