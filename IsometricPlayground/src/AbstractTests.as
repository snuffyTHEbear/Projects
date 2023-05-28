package
{
	import com.arcticcode.greenFlames.display.DisplayUtils;
	import com.arcticcode.greenFlames.graphics.CreateCircle;
	import com.arcticcode.greenFlames.isometric.core.IsometricEngine;
	import com.arcticcode.greenFlames.isometric.math.IsoMath;
	import com.arcticcode.greenFlames.isometric.view.BaseIsometricView;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	[SWF(width=640,height=480,backgroundColor=0xffffff)]
	public class AbstractTests extends BaseIsometricView
	{
		private var angle:Number = IsometricEngine.RIGHT;
		private var circles:Array = new Array();
		private var cont:Sprite = new Sprite();
		
		public function AbstractTests()
		{
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, onScroll);
			super.init();
		}
		
		private function onScroll(e:MouseEvent):void
		{
			trace(e.delta);
			cont.scaleX -= e.delta/10;
			cont.scaleY -= e.delta/10;
			DisplayUtils.doCentreTwo(cont,centreX,centreY);
		}
		
		override protected function init():void
		{
			addChild(cont);
			
			for(var i:Number=-500;i<500;i+=1)
			{
				for(var j:Number=0;j<10;j+=2)
				{
					var c:CreateCircle = new CreateCircle((3),true,false,j*100000,0.8,0,0);
					c.move(IsoMath.xFlash(i*5,0,j*5,angle,0),IsoMath.yFlash(i*5,0,j*5,angle, 0));
					cont.addChild(c);
					circles.push({circle:c,z:j*5});
				}
				angle+=0.05;
			}
			circles.sortOn("z", Array.DESCENDING | Array.NUMERIC);
			
			for(i= 0;i<circles.length;i++)
			{
				var obj:CreateCircle = circles[i].circle;
				cont.setChildIndex(obj, i);
			}
			
			DisplayUtils.doCentreTwo(cont,centreX,centreY);
		}
	}
}