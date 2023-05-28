package
{
	import com.arcticcode.greenFlames.graphics.CreateCircle;
	
	import flash.events.Event;
	
	public class AvoidTest extends BasicStage
	{
		private var circles:Array;
		private var v:SteeredVehicle;
		private var numCircles:uint=10;
		
		public function AvoidTest()
		{
			init();
		}
		private function init():void
		{
			v = new SteeredVehicle();
			v.edgeBehavior = "bounce";
			addChild(v);
			
			circles = new Array();
			for(var i:uint=0;i<numCircles;i++)
			{
				var c:CreateCircle = new CreateCircle(Math.random()*20+5,true,false,0,1,0,0);
				c.move(Math.random()*stage.stageWidth,Math.random()*stage.stageHeight);
				addChild(c);
				circles.push(c);
			}
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		private function loop(e:Event):void
		{
			v.wander();
			v.avoid(circles);
			v.update();
		}
	}
}