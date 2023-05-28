package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	
	import org.osflash.signals.events.GenericEvent;
	import org.tutorials.SuperHero;
	
	public class AS3Signals extends Sprite
	{
		private var robert:SuperHero;
		
		public function AS3Signals()
		{
			robert = new SuperHero();
			addChild(robert);
			
			robert.punched.addOnce(robertFirstPunched);
			robert.punched.add(robertPunched);
			robert.punch();
			
			robert.kicked.add(robertKicked);
			robert.kick();
			
			robert.clicked.add(robertClicked);
			
			robert.run.add(robertRun);
		}
		
		private function robertRun(event:TimerEvent):void
		{
			trace("robert is running");
		}
		
		private function robertClicked(event:MouseEvent):void
		{
			trace("robert clicked");
		}
		
		private function robertKicked(event:GenericEvent):void
		{
			trace(event.target);
			trace(event.signal);
		}
		
		private function robertFirstPunched(action:String):void
		{
			trace("First punch!");
		}
		
		private function robertPunched(action:String):void
		{
			trace(action);
		}
	}
}