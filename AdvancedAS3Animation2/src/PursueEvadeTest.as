package
{
	import com.arcticcode.greenFlames.geom.Vector2D;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class PursueEvadeTest extends Sprite
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;	
		private var pursuer:SteeredVehicle;
		private var evader:SteeredVehicle;
		
		public function PursueEvadeTest()
		{
			init();
		}
		private function init():void
		{
			stage.align = "topLeft";
			stage.scaleMode = "noScale";	
			
			pursuer = new SteeredVehicle();
			pursuer.position = new Vector2D(200,200);
			pursuer.edgeBehavior = "bounce";
			addChild(pursuer);
			
			evader = new SteeredVehicle();
			evader.position = new Vector2D(400,300);
			evader.edgeBehavior = "wrap";
			addChild(evader);
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		private function loop(e:Event):void
		{
			evader.evade(pursuer);
			pursuer.pursue(evader);
			evader.update();
			pursuer.update();
		}
	}
}