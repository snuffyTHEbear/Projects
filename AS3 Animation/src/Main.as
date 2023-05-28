package
{
	import com.tests.BitmapTests;
	import com.tests.Cube;
	import com.tests.PlaneTests;
	
	import flash.display.Sprite;
	
	import springing.DoubleSpring;
	import springing.OffsetSpring;
	import springing.SpringingMultipleObjects;
	import springing.SpringingMultipleTargets;
	import springing.SpringingTests;
	
	/**
	   [TODO] - Add controls for multiple modifiers e.g. lights, positions etc.
	 *
	 */
	
	[SWF(width=720, height = 560, frameRate = 30)]
	public class Main extends Sprite
	{
		private var _test:Sprite;
		
		private var w:Number = stage.stageWidth;
		
		private var h:Number = stage.stageHeight;
		
		private var centreX:Number = stage.stageWidth * 0.5;
		
		private var centreY:Number = stage.stageHeight * 0.5;
		
		public function Main()
		{
			stage.scaleMode = "noScale";
			
			_test = new Cube(720, 560);
			addChild(_test);
		}
	}
}