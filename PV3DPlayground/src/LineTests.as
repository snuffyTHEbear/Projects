package
{
	import flash.events.Event;
	
	import org.papervision3d.core.geom.Lines3D;
	import org.papervision3d.core.geom.renderables.Line3D;
	import org.papervision3d.core.geom.renderables.Vertex3D;
	import org.papervision3d.core.render.command.RenderLine;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.materials.special.LineMaterial;
	import org.papervision3d.view.BasicView;
	
	[SWF(width=640,height=480,backgroundColor=0x000000)]
	public class LineTests extends BasicView
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;	
		
		public function LineTests(viewportWidth:Number=640, viewportHeight:Number=480, scaleToStage:Boolean=true, interactive:Boolean=false, cameraType:String="Target")
		{
			super(640, 480, true, true, "Target");
			init();
		}
		private function init():void
		{
			var wmat:WireframeMaterial = new WireframeMaterial(0xcc0000,100,2);
			
			var line:Line3D = new Line3D(new Lines3D(new LineMaterial(0xffffff,1),"Lines"),new LineMaterial(0xcc0000,1),2,new Vertex3D(-200,0,0),new Vertex3D(200,0,0));
			
			addEventListener(Event.ENTER_FRAME, onRenderTick);
		}
		override protected function onRenderTick(event:Event=null):void
		{
			renderer.renderScene(scene,camera,viewport);
		}
	}
}