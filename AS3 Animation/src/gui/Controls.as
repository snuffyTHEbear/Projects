package gui
{
	import com.bit101.components.Slider;
	
	import flash.display.Sprite;
	
	public class Controls extends Sprite
	{
		public function Controls()
		{
			super();
		}
		
		public function drawBG():void
		{
		
		}
		
		public function setMaxMin(slider:*, max:Number, min:Number):void
		{
			slider.maximum = max;
			slider.minimum = min;
		}
		
		public function closeControls():void
		{
			this.visible = false;
		}
	}
}