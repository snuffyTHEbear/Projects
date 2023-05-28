package
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	
	import net.hires.debug.Stats;
	
	import tests.Cube;
	import tests.ExtrudedA;
	import tests.Terrains;
	
	[SWF(width = 740, height = 580, backgroundColor = 0xFFFFFF)]
	public class Arctic3DAir extends Sprite
	{
		private var _test:Sprite;
		
		public function Arctic3DAir()
		{
			stage.nativeWindow.visible = true;
			stage.scaleMode = "noScale";
			stage.frameRate = 30;
			
			//trace(NativeApplication.nativeApplication.runtimeVersion);
			
			addChild(new Stats());
			
			_test = addChild(new Cube(stage.stageWidth, stage.stageHeight)) as Sprite;
		}
	}
}