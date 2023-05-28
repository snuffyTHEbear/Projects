package
{
	import com.arcticcode.greenFlames.isometric.ComplexIsometricObject;
	import com.arcticcode.greenFlames.isometric.IsometricEngine;
	import com.arcticcode.greenFlames.isometric.IsometricUtils;
	import com.gskinner.motion.GTween;
	
	import flash.display.Sprite;

	public class TweenTests extends Sprite
	{
		private var engine:IsometricEngine;
		private var grid:ComplexIsometricObject;
		private var tween:GTween;
		//
		private const centreX:Number = stage.stageWidth*0.5;
		private const centreY:Number = stage.stageHeight*0.5;
		
		public function TweenTests()
		{
			init();
		}
		private function init():void
		{
			grid = new ComplexIsometricObject();
			engine = new IsometricEngine(grid.graphics,centreX,centreY+100,IsometricEngine.RIGHT,false,true);
			addChild(grid);
			
			IsometricUtils.createXZGrid(grid,10,10,5,5,5,false,0,true,Math.random()*0xffffff);
			engine.drawBoxes(grid.boxes,grid,grid.graphics,true);
		}
	}
}