package
{
	import com.arcticcode.greenFlames.display.userInterface.Button;
	import com.arcticcode.greenFlames.text.SimpleInputTextField;
	import com.arcticcode.greenFlames.xPreloader.XPreloader;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextFormat;
	
	[SWF(width=640, height = 480, backgroundColor = 0x000000)]
	public class Preloaders extends Sprite
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		
		private var centreY:Number = stage.stageHeight * 0.5;
		
		private var _loader:XPreloader;
		
		private var _input:SimpleInputTextField;
		
		private var _loadBtn:Button;
		
		private var _barA:Sprite = new Sprite;
		
		private var _barB:Sprite = new Sprite;
		
		public function Preloaders()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(e.type, arguments.callee);
			
			_input = new SimpleInputTextField(new TextFormat("arial", 12), "left", "normal", false);
			_input.move(10, 10);
			addChild(_input);
			_input.text = "http://arctic-code.com/dump/JI.mp3";
			_input.background = true;
			
			_loadBtn = new Button("Load", "left", new TextFormat("arial", 12, 0xFFFFFF), new TextFormat("arial", 12, 0x939393), new TextFormat("arial", 12, 0x535353), false);
			addChild(_loadBtn);
			_loadBtn.move(10, 30);
			_loadBtn.addEventListener(MouseEvent.CLICK, load);
			
			_loader = new XPreloader("", XPreloader.AUTO_RECOGNISE, false);
			_loader.addEventListener(Event.COMPLETE, loaderComplete_Handler);
			_loader.addEventListener(ProgressEvent.PROGRESS, loaderProgress_Handler);
			
			addChild(_barA);
			addChild(_barB);
			_barB.filters = [new GlowFilter(0xFFFFFF, 0.75, 2, 2, 1, 3)];
		}
		
		private function loaderProgress_Handler(e:ProgressEvent):void
		{
			_barA.graphics.clear();
			_barA.graphics.beginFill(0xFFFFFF, 0.5);
			_barA.graphics.drawRect(centreX - 200, stage.stageHeight - 30, 400, 2);
			_barA.graphics.endFill();
			_barB.graphics.beginFill(0xFFFFFF);
			_barB.graphics.drawRect(centreX - 200, stage.stageHeight - 30, e.bytesLoaded / e.bytesTotal * 400, 2);
			_barB.graphics.endFill();
			
			_input.text = _loader.url + " : Loading...";
		}
		
		private function loaderComplete_Handler(e:Event):void
		{
			_input.text = _loader.url + " : Loaded";
		}
		
		private function load(e:MouseEvent):void
		{
			_loader.loadURL(_input.text);
		}
	}
}