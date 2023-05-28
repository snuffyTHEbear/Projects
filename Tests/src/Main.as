package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.ui.Keyboard;
	
	import org.tests.BitmapCircles;
	import org.tests.Coronas;
	import org.tests.KeyboardTests;
	import org.tests.MouseGrid;
	
	[SWF(width = 640, height = 480)]
	public class Main extends Sprite
	{
		private var _child:Sprite;
		
		public function Main()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void
		{
			removeEventListener(e.type, init);
			_child = addChild(new Coronas()) as Sprite;
		}
	}
}