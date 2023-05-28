package org.tutorials
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.osflash.signals.DeluxeSignal;
	import org.osflash.signals.Signal;
	import org.osflash.signals.events.GenericEvent;
	import org.osflash.signals.natives.NativeSignal;
	
	public class SuperHero extends Sprite
	{
		public var punched:Signal;
		
		public var kicked:DeluxeSignal;
		
		public var clicked:NativeSignal;
		
		public var run:NativeSignal;
		
		private var timer:Timer;
		
		public function SuperHero()
		{
			graphics.beginFill(0xCC0000);
			graphics.drawRect(0, 0, 100, 100);
			graphics.endFill();
			buttonMode = true;
			
			punched = new Signal(String);
			
			kicked = new DeluxeSignal(this);
			
			clicked = new NativeSignal(this, MouseEvent.CLICK, MouseEvent);
			
			timer = new Timer(1500);
			run = new NativeSignal(timer, TimerEvent.TIMER, TimerEvent);
			timer.start();
		}
		
		public function kick():void
		{
			kicked.dispatch(new GenericEvent());
		}
		
		public function punch():void
		{
			punched.dispatch("I hit the bad guy.");
		}
	}
}