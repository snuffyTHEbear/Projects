package
{
	import flash.events.Event;
	
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.view.BasicView;
	
	[SWF(width=640,height=480,backgroundColor=0x000000)]
	public class PlanesTest extends BasicView
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;	
		
		public function PlanesTest(viewportWidth:Number=640, viewportHeight:Number=480, scaleToStage:Boolean=true, interactive:Boolean=false, cameraType:String="Target")
		{
			super(640,480,true,true);
			init();
		}
		private function init():void
		{
			for(var i:uint=0;i<50;i++)
			{
				var wm:WireframeMaterial = new WireframeMaterial(Math.random()*0xffffff,100,1);
				var p:Plane = new Plane(wm,50,50,2,2);
				p.rotationX = Math.random()*360-180;
				p.rotationY = Math.random()*360-180;
				p.rotationZ = Math.random()*360-180;
				p.x = Math.random()*500-250;
				p.y = Math.random()*500-250;
				wm.doubleSided = true;
				//p.z = Math.random()*500-250;
				scene.addChild(p);
			}
			
			addEventListener(Event.ENTER_FRAME, onRenderTick);		
		}
		override protected function onRenderTick(event:Event=null):void
		{
			camera.x += (centreX - mouseX);
			
			super.onRenderTick(event);
		}
	}
}