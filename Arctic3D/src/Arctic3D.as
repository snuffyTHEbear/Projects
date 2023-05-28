package
{
	import flash.display.Sprite;
	
	import net.hires.debug.Stats;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	import tests.Terrains;
	
	[SWF(width = 640, height = 480)]
	public class Arctic3D extends Sprite
	{
		public var debugger:MonsterDebugger;
		private var _test:Sprite;
		
		public function Arctic3D()
		{
			stage.scaleMode = "noScale";
			stage.frameRate = 30;
			
			addChild(new Stats());
			
			_test = addChild(new Terrains(640, 480)) as Sprite;
		}
	}
}