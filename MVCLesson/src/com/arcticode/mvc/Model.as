package com.arcticode.mvc
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * 
	 * @author Rob
	 * 
	 * Model stores data says "Hi, Ive updated, so change view"
	 */
	public class Model extends EventDispatcher
	{
		public var textForView:String = "Text from model";
		
		private var savedText:String = textForView;
		private var timeFromLastUpdate:Number = 0;
		
		public function saveText(textToSave:String):void
		{
			savedText = textToSave;
			trace(savedText);
			timeFromLastUpdate = 0;
		}
		
		public function Model()
		{
			var timer:Timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, timer_timerHandler);
			timer.start();
		}
		private function timer_timerHandler(e:TimerEvent):void
		{
			timeFromLastUpdate+=1;
			textForView = String(savedText + " " + timeFromLastUpdate);
			
			var changeEvent:Event = new Event(Event.CHANGE);
			dispatchEvent(changeEvent);
		}
	}
}