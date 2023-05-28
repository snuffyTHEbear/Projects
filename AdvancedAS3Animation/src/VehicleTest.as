package
{
	import com.arcticcode.greenFlames.geom.Vector2D;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class VehicleTest extends Sprite
	{
		private var _v:SteeredVehicle;
		private var mousePos:Vector2D = new Vector2D();
		
		public function VehicleTest()
		{
			init();
		}
		private function init():void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			_v = new SteeredVehicle();
			addChild(_v);
			_v.position.x = 100;
			_v.position.y = 200;
			_v.edgeBehavior = "bounce";
			/*
			_v.position = new Vector2D(100,100);
			
			_v.velocity.length = 5;
			_v.velocity.angle = Math.PI / 4;*/
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		private function loop(e:Event):void
		{
			mousePos.x = mouseX;
			mousePos.y = mouseY;
			_v.flee(mousePos);
			_v.update();
		}
	}
}