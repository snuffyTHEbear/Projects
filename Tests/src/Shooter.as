package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Shooter extends Sprite
	{
		
		
		public function Shooter()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(e.type, init);
			
			
		}
	}
}