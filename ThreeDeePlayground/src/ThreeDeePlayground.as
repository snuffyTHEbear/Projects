package
{
	import com.tests.Planes;
	
	import flash.display.Sprite;
	
	public class ThreeDeePlayground extends Sprite
	{
		private var _child:Sprite;
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;
		
		public function ThreeDeePlayground()
		{
			stage.scaleMode = "noScale";
			init();
		}
		private function init():void
		{
			_child = new Planes(centreX, centreY);
			addChild(_child);
		}
	}
}