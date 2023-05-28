package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import tutorials.BitmapDecoding;
	
	[SWF(width=640, height = 480, backgroundColor = 0xFFFFFF)]
	public class Main extends Sprite
	{
		private var _tutorial:Sprite;
		
		public function Main()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(e.type, init);
			
			_tutorial = new BitmapDecoding(stage);
			addChild(_tutorial);
		}
	}
}