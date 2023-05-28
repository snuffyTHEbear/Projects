package
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class FibonacciNumbers extends Sprite
	{
		private var tf:TextField;
		
		public function FibonacciNumbers()
		{
			tf = new TextField();
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.defaultTextFormat = new TextFormat("Verdana",10,0);
			tf.x = 5;
			tf.y = 5;
			addChild(tf);
			fibbonacci();
		}
		private function fibbonacci():void
		{
			var fib:Array = new Array(1,1);
			for(var i:uint=0;i<30;i++)
			{
				fib[i+2] = fib[i+1] + fib[i];
				tf.appendText(fib[i]+"\n");
				//trace(fib[i]);
			}
		}
	}
}