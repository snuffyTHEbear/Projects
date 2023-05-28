package
{
	import com.gskinner.utils.PerformanceTest;
	
	import flash.display.Sprite;
	import flash.utils.setTimeout;
	
	[SWF(width=485, height=332, backgroundColor=0x000000, frameRate=30)]
	public class PT extends Sprite
	{
		[Embed(source="assets/bboy.jpg")]
		private var src:Class;
		
		private var pt:PixelTests;
		
		public function PT()
		{
			pt = new PixelTests(new src());
			addChild(pt.bm);
			setTimeout(startTest, 2000);
		}
		
		private function startTest():void
		{
			var perfTest:PerformanceTest = PerformanceTest.getInstance();
			perfTest.testSuite(pt);
		}
	}
}