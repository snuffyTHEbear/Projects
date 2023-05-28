package
{
	import flash.events.Event;
	
	import org.papervision3d.events.FileLoadEvent;
	import org.papervision3d.lights.PointLight3D;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.materials.shadematerials.FlatShadeMaterial;
	import org.papervision3d.objects.parsers.Ase;
	import org.papervision3d.view.BasicView;
	
	[SWF(width=640,height=480,backgroundColor=0x000000)]
	public class ASETests extends BasicView
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;
		private var aseCube:Ase;	
		
		public function ASETests()
		{
			super(640,480,true,true);
			init();
		}
		private function init():void
		{
			var light:PointLight3D = new PointLight3D(true,true);
			light.copyPosition(camera);
			//var cubeMaterial:GouraudMaterial = new GouraudMaterial(light);
			var flatMat:FlatShadeMaterial = new FlatShadeMaterial(light,0xcc0000,0xffffff,0);
			var wmat:WireframeMaterial = new WireframeMaterial(0xcc0000,100,3);
			aseCube = new Ase(wmat, "assets/PLANE.ASE", .09);
			aseCube.material.doubleSided = true;
			aseCube.addEventListener(FileLoadEvent.LOAD_ERROR, error);
			scene.addChild(aseCube);
			
			addEventListener(Event.ENTER_FRAME, onRenderTick);
		}
		private function error(e:FileLoadEvent):void
		{
			trace(e.message);
		}
		override protected function onRenderTick(event:Event=null):void
		{
			super.onRenderTick(event);
			/* aseCube.rotationX += 2.3;
			aseCube.rotationY += 1.7; */
			
			aseCube.rotationX += (centreY - mouseY) * .03;
			aseCube.rotationY -= (centreX - mouseX) * .06;
		}
	}
}