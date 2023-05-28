package
{
	import com.arcticcode.greenFlames.geom.Vector2D;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class PursueTest extends Sprite
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;	
		private var seeker:SteeredVehicle;
		private var pursuer:SteeredVehicle;
		private var target:Vehicle;
		
		public function PursueTest()
		{
			init();
		}
		private function init():void
		{
			stage.align = "topLeft";
			stage.scaleMode = "noScale";
			
			seeker = new SteeredVehicle();
			seeker.x = 400;
			addChild(seeker);
			
			pursuer = new SteeredVehicle();
			pursuer.x = 400;
			addChild(pursuer);
			
			target = new Vehicle();
			target.position = new Vector2D(200,200);
			target.velocity.length = 15;
			addChild(target);
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		private function loop(e:Event):void
		{
			seeker.seek(target.position);
			seeker.update();
			
			pursuer.pursue(target);
			pursuer.update();
			
			target.update();
		}
	}
}