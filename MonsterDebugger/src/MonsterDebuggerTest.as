package {
	import flash.display.Sprite;
	
	import nl.demonsters.debugger.MonsterDebugger;

	public class MonsterDebuggerTest extends Sprite
	{
		private var debugger:MonsterDebugger;
		private var circle:Sprite;
		
		public function MonsterDebuggerTest()
		{			
			circle = new Sprite();
			circle.graphics.beginFill(0xffffff);
			circle.graphics.drawCircle(0,0,50);
			circle.graphics.endFill();
			circle.x = circle.y = 150;
			addChild(circle);
			
			debugger = new MonsterDebugger(circle);
		}
	}
}
