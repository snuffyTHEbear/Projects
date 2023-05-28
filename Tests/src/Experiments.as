package
{
	import com.arcticcode.greenFlames.math.MathUtils;
	import com.arcticcode.greenFlames.isometric.core.IsometricEngine;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width=600, height = 400, backgroundColor = 0xffffff)]
	public class Experiments extends Sprite
	{
		private var engine:IsometricEngine;
		
		private var cont:Sprite;
		
		private var centreX:Number = stage.stageWidth * 0.5;
		
		private var centreY:Number = stage.stageHeight * 0.5;
		
		private var bmd:BitmapData;
		
		private var b:Bitmap;
		
		public function Experiments()
		{
			init();
		}
		
		private function init():void
		{
			const n:Number = Math.random() * 1000 + 500
			trace(n, Math.round(n / 10) * 10, Math.ceil(n / 10) * 10, Math.floor(n / 10) * 10);
			trace(n, MathUtils.round(n), MathUtils.ceil(n), MathUtils.floor(n));
		}
		
		private function cards():void
		{
			var startDeck:Array = new Array();
			var shuffDeck:Array = new Array();
			
			for (var i:uint = 0; i < 52; i++)
			{
				startDeck.push(i);
			}
			
			while (startDeck.length > 0)
			{
				i = Math.floor(Math.random() * startDeck.length);
				shuffDeck.push(startDeck[i]);
				startDeck.splice(i, 1);
			}
		}
	}
}