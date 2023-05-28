package
{
	import com.arcticcode.greenFlames.xPreloader.XPreloader;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	
	[SWF(width = 640, height = 480, backgroundColor = 0xFFFFFF)]
	public class XPreloaderTests extends Sprite
	{
		private var _buttonA:Sprite;
		private var _buttonB:Sprite;
		
		private var _loader:XPreloader;
		private var _urlA:String = "http://skysoftwarehouse.com/newskyp/audio/wordsoundtest/lair2.mp3";
		private var _urlB:String = "http://skysoftwarehouse.com/newskyp/audio/alive.mp3";
		private var _sound:Sound;
		
		//Finding an error with loading sound with the XPreloader
		
		public function XPreloaderTests()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function createButton(x:Number, y:Number, name:String):Sprite
		{
			var sprite:Sprite = new Sprite();
			sprite.graphics.beginFill(Math.random() * 0xFFFFFF);
			sprite.graphics.lineStyle(0);
			sprite.graphics.drawRect(0,0,100,30);
			sprite.graphics.endFill();
			sprite.buttonMode = true;
			sprite.addEventListener(MouseEvent.CLICK, buttonClick);
			sprite.name = name;
			sprite.x = x;
			sprite.y = y;
			addChild(sprite);
			return sprite;
		}
		
		private function buttonClick(e:Event):void
		{
			trace(e.target.name);
			if(e.target.name == _buttonA.name)
			{
				loadSound(_urlA);
			}
			else
			{
				loadSound(_urlB);
			}
			_buttonA.mouseEnabled = _buttonB.mouseEnabled = false;
		}
		
		private function init(e:Event):void
		{
			removeEventListener(e.type, init);
			stage.scaleMode = "noScale";
			
			_buttonA = createButton(10, 10, "buttonA");
			_buttonB = createButton(10, 50, "buttonB");
			_loader = new XPreloader("", XPreloader.AUTO_RECOGNISE, false);
			_loader.addEventListener(Event.COMPLETE, loaded);
		}
		private function loadSound(url:String):void
		{
			trace(url);
			_loader.loadURL(url, XPreloader.MP3, true);
		}
		private function loaded(e:Event):void
		{
			_sound = _loader.content as Sound;
			_sound.play();
			
			trace(_loader.url, ": Loaded");
			_buttonA.mouseEnabled = _buttonB.mouseEnabled = true;
		}
	}
}