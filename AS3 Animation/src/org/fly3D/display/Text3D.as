package org.fly3D.display
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class Text3D extends BasicDisplayObject3D
	{
		public function Text3D(text:String, size:uint = 12, colour:uint = 0x000000)
		{
			var tf:TextField = new TextField();
			tf.defaultTextFormat = new TextFormat("_sans", size, colour);
			tf.autoSize = "left";
			tf.text = text;
			tf.x -= tf.width * 0.5;
			tf.y -= tf.height * 0.5;
			tf.selectable = tf.wordWrap = false;
			var cont:Sprite = new Sprite();
			cont.addChild(tf);
			addChild(cont);
		}
	}
}