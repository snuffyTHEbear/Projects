package
{
	import com.arcticcode.greenFlames.geom.Vector2D;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class ArriveTest extends Sprite
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;	
		private var _v:SteeredVehicle;
		private var mousePos:Vector2D= new Vector2D();
		
		public function ArriveTest()
		{
			init();
		}
		private function init():void
		{
			stage.align = "topLeft";
			stage.scaleMode = "noScale";
			
			_v = new SteeredVehicle();
			_v.position = new Vector2D(100,100);
			_v.edgeBehavior = "bounce";
			addChild(_v);
			
			addEventListener(Event.ENTER_FRAME, loop);	
		}
		private function loop(e:Event):void
		{
			mousePos.x = mouseX;
			mousePos.y = mouseY;
			_v.arrive(mousePos);
			_v.update();
		}
	}
}