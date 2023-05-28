package
{
	import com.arcticcode.greenFlames.components.Slider;
	import com.arcticcode.greenFlames.components.Toggle;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width=640, height=480,backgroundColor=0)]
	public class Components extends Sprite
	{
		private var _toggle:Toggle;
		private var _slider:Slider;
		
		private var _circle:Sprite;
		
		public function Components()
		{
			_slider = new Slider(200, 75, 0, 10);
			addChild(_slider);
			_slider.move(10, 10);
			
			_toggle = new Toggle();
			addChild(_toggle);
			_toggle.move(50, 50);
			
			_circle = addChild(new Sprite()) as Sprite;
			_circle.x = stage.stageWidth * 0.5;
			_circle.y = stage.stageHeight * 0.5;
			
			addEventListener(Event.ENTER_FRAME, enterFrame_Handler);
		}
		private function enterFrame_Handler(e:Event):void
		{
			if(_toggle.selected)
			{
				_circle.graphics.clear();
				_circle.graphics.beginFill(0xCC0000);
				_circle.graphics.drawCircle(0,0,_slider.value);
				_circle.graphics.endFill();
			}
			else
			{
				_circle.graphics.clear();
			}
		}
	}
}