package
{
	import com.arcticcode.greenFlames.isometric.IsometricEngine;
	import com.arcticcode.greenFlames.isometric.IsometricObject;
	
	import flash.display.Sprite;

	public class BaseIsometrics extends Sprite
	{
		public function BaseIsometrics()
		{
			init();
		}
		private function init():void
		{
			var sprite:Sprite = new Sprite();
			var engine:IsometricEngine = new IsometricEngine(sprite.graphics,stage.stageWidth*0.5,stage.stageWidth*0.5,26.57,true,true);
			var block:IsometricObject = new IsometricObject(0,0,0,15,15,15,false,0,true,0xCCCCCC);
			engine.drawBox(block);
			addChild(sprite);
			//sprite.rotation = -engine.angle;
		}
	}
}