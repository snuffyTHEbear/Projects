package {
	import com.arcticcode.greenFlames.events.RobustEvent;
	
	import core.objects.BaseObject;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width=640,height=480,backgroundColor=0xffffff)]
	public class ASTests extends Sprite
	{
		private var _core:BaseObject;
		
		public function ASTests()
		{
			init();
		}
		private function init():void
		{
			_core = new BaseObject();
			_core.addEventListener(Event.COMPLETE, coreInit_Handler);
			_core.addEventListener(RobustEvent.EVENT_FIRE, coreEventFire_Handler);
		}
		private function coreInit_Handler(e:Event):void
		{
			trace(e);
		}
		private function coreEventFire_Handler(e:RobustEvent):void
		{
			trace(e, e._params.val);
		}
	}
}
