package
{
	import com.arcticcode.greenFlames.geom.Vector2D;
	
	import flash.events.Event;
	
	public class FlockTest extends BasicStage
	{
		private var vehicles:Array;
		private var numVehicles:uint=20;
		
		public function FlockTest()
		{
			init();
		}
		private function init():void
		{
			vehicles = new Array();
			
			for(var i:uint=0;i<numVehicles;i++)
			{
				var v:SteeredVehicle = new SteeredVehicle();
				v.position = new Vector2D(Math.random()*stage.stageWidth,Math.random()*stage.stageHeight);
				v.velocity = new Vector2D(Math.random()*20-10,Math.random()*20-10);
				v.edgeBehavior = "bounce";
				vehicles.push(v);
				addChild(v);
			}
			addEventListener(Event.ENTER_FRAME, loop);
		}
		private function loop(e:Event):void
		{
			for(var i:uint=0;i<numVehicles;i++)
			{
				vehicles[i].flock(vehicles);
				vehicles[i].update();
			}
		}
	}
}