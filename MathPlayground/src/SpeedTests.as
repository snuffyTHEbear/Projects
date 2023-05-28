package
{
	import flash.display.Sprite;
	import flash.utils.getTimer;

	public class SpeedTests extends Sprite
	{
		private var start:Number=0;
		private var end:Number=0;
		private var total:uint = 1000;
		private var num:Number = 0;
		private var s:Sprite = new Sprite();
		
		public function SpeedTests()
		{
			start = getTimer();
			
			for(var i:Number = 0;i < total; i++)
			{
				s = new Sprite();
				s = null;
			}
			
			end = getTimer() - start;
			trace("Number:", end);
			
			start = getTimer();
			
			for(var j:int = 0;j<total; j++)
			{
				s = new Sprite();
				s = null;
			}
			
			end = getTimer() - start;
			trace("Int:",end);
			
			start = getTimer();
			
			for(var k:uint = 0;k < total;k++)
			{
				s = new Sprite();
				s = null;
			}
			
			end = getTimer() - start;
			trace("Uint:",end);
		}
	}
}