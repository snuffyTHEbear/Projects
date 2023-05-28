package ThreeDee
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Containers extends Sprite
	{
		private var sprite:Sprite;
		private var n:Number = 0;
		private var texts:Array = new Array();
		
		public function Containers()
		{
			sprite = new Sprite();
			sprite.y = 290;
			
			for(var i:int = 0; i < 100; i++)
			{
				var tf:TextField = new TextField();
				tf.defaultTextFormat = new TextFormat("Arial", 40, Math.random() * 0xffffff);
				tf.text = String.fromCharCode(65 + Math.floor(Math.random() * 25));
				tf.selectable = false;
				tf.x = Math.random() * 300 - 150;
				tf.y = Math.random() * 300 - 150;
				tf.z = Math.random() * 1000;
				sprite.addChild(tf);
				texts.push(tf);
			}
			
			texts.sortOn("z", Array.NUMERIC | Array.DESCENDING);
			
			for(i = 0; i < texts.length; i++)
			{
				texts[i].parent.setChildIndex(texts[i], i);
			}
			
			addChild(sprite);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(e:Event):void
		{
			sprite.x = 290 + Math.cos(n) * 200;
			n += .05;
		}
	}
}