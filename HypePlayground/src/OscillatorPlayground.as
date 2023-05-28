package
{
	import flash.display.Sprite;
	
	import hype.extended.behavior.Oscillator;
	import hype.extended.color.ColorPool;
	
	public class OscillatorPlayground extends Sprite
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;
		
		private var _colorPool:ColorPool;
		private var _numItems:uint = 10;
		private var _frequency:Number = 300;
		
		public function OscillatorPlayground()
		{
			initColorPool();
			init();
		}
		private function init():void
		{
			for(var i:uint = 0; i < _numItems; i++)
			{
				var shape:Sprite = new Sprite();
				shape.graphics.beginFill(0, 0.8);
				shape.graphics.drawRect(- 10, -10, 20, 20);
				shape.graphics.endFill();
				shape.x = i / _numItems * stage.stageWidth;
				shape.y = centreY;
				_colorPool.colorObject(shape);
				addChild(shape);
				
				var oscY:Oscillator = new Oscillator(shape, 'y', Oscillator.sineWave, _frequency, centreY - 50, centreY + 50, i / (_frequency / 2));
				var oscS:Oscillator = new Oscillator(shape, 'scaleY', Oscillator.sineWave, _frequency, 0.5, 15, i / (_frequency / 2));
				var oscR:Oscillator = new Oscillator(shape, 'rotation', Oscillator.sineWave, _frequency, 90, 0, i / (_frequency / 2));
				oscY.start();	
				oscS.start();
				oscR.start();
			}
		}
		private function initColorPool():void
		{
			_colorPool = new ColorPool(0x6F7B1D, 0x9E9F2B, 0xBDBC35, 0xDDCB3A, 0xF6D16A, 0xF4DF9F, 0xF7EFD2, 0x422811, 0x853711, 0xC4520A, 0xE55F0A, 0xF67605, 0xF09724);
			//_colorPool = new ColorPool(0xE7854C, 0xE7714C, 0xE0491B, 0x63B2B9 , 0xACE5EB);
		}
	}
}