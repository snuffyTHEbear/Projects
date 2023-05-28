package com.arcticcode.xbox360.display
{
	import com.arcticcode.greenFlames.xPreloader.XPreloader;
	import com.arcticcode.xbox360.utils.Xbox360Utils;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	//Add url, mouseover listeners to activate text on gamertag and click to go to game page on xbox.com
	public class SimpleXboxGameInfo extends Sprite
	{
		private var _image:Bitmap;
		
		private var _title:String;
		
		private var _xLoader:XPreloader;
		
		public var number:uint;
		
		private var _onReady:Function;
		
		public function SimpleXboxGameInfo(title:String, imageURL:String, number:uint, onReady:Function)
		{
			_title = title;
			this.number = number;
			_onReady = onReady;
			_xLoader = new XPreloader(imageURL, XPreloader.IMAGE, false);
			_xLoader.addEventListener(Event.COMPLETE, xLoaderComplete_Handler);
			_xLoader.load();
		}
		
		private function xLoaderComplete_Handler(e:Event):void
		{
			_xLoader.removeEventListener(e.type, arguments.callee);
			_image = _xLoader.content;
			addChild(_image);
			
			if(_onReady != null)
				_onReady(this);
		}
		
		public function get title():String
		{
			return _title;
		}
		
		public function set title(value:String):void
		{
			_title = value;
		}
	
	}
}