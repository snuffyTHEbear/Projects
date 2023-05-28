package
{
	import com.arcticcode.greenFlames.graphics.CreateCircle;
	import com.arcticcode.greenFlames.graphics.CreateRect;
	import com.arcticcode.greenFlames.isometric.core.IsometricEngine;
	import com.arcticcode.greenFlames.isometric.math.IsoMath;
	import com.arcticcode.greenFlames.math.MathUtils;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width=600, height = 400, backgroundColor = 0xffffff)]
	public class IsometricExp2 extends Sprite
	{
		private var engine:IsometricEngine;
		
		private var circle:CreateCircle;
		
		private var rect:CreateRect;
		
		//
		private var centreX:Number = stage.stageWidth * 0.5;
		
		private var centreY:Number = stage.stageHeight * 0.5;
		
		//
		
		public function IsometricExp2()
		{
			init();
		}
		
		private function init():void
		{
			engine = new IsometricEngine(null, centreX, centreY, 144, false, true);
			circle = new CreateCircle(10, true, false, Math.random() * 0xffffff, 1);
			rect = new CreateRect(10, 10, true, false, Math.random() * 0xFFFFFF, 1, true);
			addChild(circle);
			addChild(rect);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			engine.angle += 1;
			
			for (var i:Number = -2; i < 4; i++)
			{
				for (var j:Number = -8; j < 5; j++)
				{
					var _x:Number = IsoMath.xFlash(i * 10, 0, j * 10, engine.angle, engine.xOrigin);
					var _y:Number = IsoMath.yFlash(i * 10, 0, j * 10, engine.angle, engine.yOrigin);
					circle.x = Math.tan(MathUtils.degreesToRadians(_x));
					circle.y = Math.tan(MathUtils.degreesToRadians(_y));
				}
			}
		}
	}
}