package
{
	import com.arcticcode.greenFlames.geom.Vector2D;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class SeekFleeTest extends Sprite
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;	
		private var seeker:SteeredVehicle;
		private var fleer:SteeredVehicle;
		
		public function SeekFleeTest()
		{
			init();
		}
		private function init():void
		{
			stage.align = "topLeft";
			stage.scaleMode = "noScale";
			
			seeker = new SteeredVehicle();
			seeker.position = new Vector2D(200,200);
			seeker.edgeBehavior = "bounce";
			//seeker.mass = 3;
			addChild(seeker);
			
			fleer = new SteeredVehicle();
			fleer.position = new Vector2D(centreX,300);
			fleer.edgeBehavior = "bounce";
			addChild(fleer);	
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		private function loop(e:Event):void
		{
			fleer.flee(seeker.position);
			seeker.seek(fleer.position);
			seeker.update();
			fleer.update();
		}
	}
}