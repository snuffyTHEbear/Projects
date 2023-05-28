package
{
	
	import AdvancedCollisionDetection.BitmapCollision2;
	
	import flash.display.Sprite;
	
	import net.hires.debug.Stats;
	
	[SWF(width=800, height=600, frameRate=30)]
	public class AvancedAS3Animation extends Sprite
	{
		private var _child:Sprite;
		
		public function AvancedAS3Animation()
		{
			stage.align = "topLeft";
			stage.scaleMode = "noScale";
			
			_child = new BitmapCollision2();
			addChild(_child);
			
			addChild(new Stats());
		}
	}
}