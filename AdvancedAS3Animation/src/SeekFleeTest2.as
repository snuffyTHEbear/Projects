package
{
	import com.arcticcode.greenFlames.geom.Vector2D;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class SeekFleeTest2 extends Sprite
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;	
		private var va:SteeredVehicle;
		private var vb:SteeredVehicle;
		private var vc:SteeredVehicle;
		
		public function SeekFleeTest2()
		{
			init();
		}
		private function init():void
		{
			stage.align = "topLeft";
			stage.scaleMode = "noScale";
			
			va = new SteeredVehicle();
			va.position = new Vector2D(500,400);
			va.edgeBehavior = "wrap";
			addChild(va);
			
			vc = new SteeredVehicle();
			vc.position = new Vector2D(100,200);
			vc.edgeBehavior = "wrap";
			addChild(vc);
			
			vb = new SteeredVehicle();
			vb.position = new Vector2D(300,400);
			vb.edgeBehavior = "wrap";
			addChild(vb);
			
			addEventListener(Event.ENTER_FRAME,loop);
		}
		private function loop(e:Event):void
		{
			va.seek(vb.position);
			va.flee(vc.position);
			vb.seek(vc.position);
			vb.flee(va.position);
			vc.seek(va.position);
			vc.flee(vb.position);
			
			va.update();
			vb.update();
			vc.update();
		}
	}
}