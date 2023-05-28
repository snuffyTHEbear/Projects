package
{
	import com.arcticcode.objects.primitives.Ring3D;
	import com.arcticcode.objects.primitives.Triangle;
	
	import flash.events.Event;
	
	import hype.extended.behavior.FixedVibration;
	import hype.extended.behavior.VariableVibration;
	import hype.framework.display.BitmapCanvas;
	
	import org.papervision3d.core.geom.TriangleMesh3D;
	import org.papervision3d.events.FileLoadEvent;
	import org.papervision3d.lights.PointLight3D;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.materials.shadematerials.FlatShadeMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.parsers.DAE;
	import org.papervision3d.view.BasicView;
	
	public class PVExamples extends BasicView
	{
		private var w:Number = stage.stageWidth;
		private var h:Number = stage.stageHeight;
		private var centreX:Number = w * 0.5;
		private var centreY:Number = h * 0.5;
		
		private var _light:PointLight3D;
		private var _mat:FlatShadeMaterial;
		private var _materialsList:MaterialsList = new MaterialsList();
		private var _wireMat:WireframeMaterial = new WireframeMaterial(Math.random() * 0xFFFFFF);
		private var _mesh:TriangleMesh3D;
		private var _dae:DAE;
		private var _object:Object;
		private var _canvas:BitmapCanvas;
		private var _vibs:Vector.<VariableVibration> = new Vector.<VariableVibration>();
		
		public function PVExamples()
		{
			super(w, h, true, true);
			
			init();
		}
		private function init():void
		{
			_light = new PointLight3D();
			_mat = new FlatShadeMaterial(_light, Math.random() * 0xFFFFFF, Math.random() * 0xFFFFFF);
			_materialsList.addMaterial(_mat, "all");
			//viewport.visible = false;
			
			initTorusKnot();
			//initMesh();
			//initTriangle();
			initCanvas();
		}
		private function initCanvas():void
		{
			_canvas = new BitmapCanvas(w, h);
			stage.addChild(_canvas);
			_canvas.startCapture(viewport, true);
			//addEventListener(Event.ENTER_FRAME, onRenderTick);
		}
		private function initTriangle():void
		{
			var t:Triangle = new Triangle(_mat, 300, 150);
			t.material.doubleSided = true;
			scene.addChild(t);
			_object = t;
			//addEventListener(Event.ENTER_FRAME, onRenderTick);
		}
		private function initTorusKnot():void
		{
			_dae = new DAE();
			_dae.scale = 5.0;
			_dae.addEventListener(FileLoadEvent.LOAD_COMPLETE, daeLoaded);
			_dae.load("../assets/TorusKnot.DAE", _materialsList);
			
			//addEventListener(Event.ENTER_FRAME, onRenderTick);
		}
		private function daeLoaded(e:FileLoadEvent):void
		{
			scene.addChild(_dae);
			_object = _dae;
			initVibrations();
			addEventListener(Event.ENTER_FRAME, onRenderTick);
		}
		private function initVibrations():void
		{
			var xv:FixedVibration = new FixedVibration(_dae, "x", 0.9, 0.03, -450, 450, false);
			var yv:FixedVibration = new FixedVibration(_dae, "y", 0.9, 0.03, -350, 350, false);
			var zv:FixedVibration = new FixedVibration(_dae, "z", 0.9, 0.03, -150, 150, false);
			var rxv:FixedVibration = new FixedVibration(_dae, "rotationX", 0.9, 0.03, -360, 360, false);
			var ryv:FixedVibration = new FixedVibration(_dae, "rotationY", 0.9, 0.03, -360, 360, false);
			xv.start();
			yv.start();
			zv.start();
			rxv.start();
			ryv.start();
		}
		private function initMesh():void
		{
			//_mesh = new Circle(_mat, 300, 16);
			//_mesh = new Ring2D(_mat, 150, 300, 16);
			_mesh = new Ring3D(_mat, 280, 300, 50, 32);
			_mesh.material.doubleSided = true;
			scene.addChild(_mesh);
			_object = _mesh;
			addEventListener(Event.ENTER_FRAME, onRenderTick);
		}
		override protected function onRenderTick(event:Event=null) : void
		{
			/*_object.$width += 1;
			_object.$height += 1;
			_object.rotationX += 1.4;
			_object.rotationY += 2.3;*/
			
			renderer.renderScene(scene, camera, viewport);
		}
	}
}