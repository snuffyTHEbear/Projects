package
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import hype.extended.behavior.FixedVibration;
	import hype.framework.core.TimeType;
	import hype.framework.display.BitmapCanvas;
	import hype.framework.rhythm.SimpleRhythm;
	
	import org.papervision3d.events.FileLoadEvent;
	import org.papervision3d.lights.PointLight3D;
	import org.papervision3d.materials.shadematerials.FlatShadeMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.parsers.DAE;
	import org.papervision3d.view.BasicView;
	
	[SWF(width = 640, height = 480)]
	public class TorusCanvas extends BasicView
	{
		private var w:Number = stage.stageWidth;
		private var h:Number = stage.stageHeight;
		private var centreX:Number = w * 0.5;
		private var centreY:Number = h * 0.5;
		
		private var _light:PointLight3D;
		private var _canvas:BitmapCanvas;
		private var _isRunning:Boolean = true;
		private var _numItems:uint = 5;
		private var _rhythm:SimpleRhythm;
		private var _torusKnots:Vector.<DAE> = new Vector.<DAE>();
		private var _vibs:Vector.<FixedVibration> = new Vector.<FixedVibration>();
		
		public function TorusCanvas(viewportWidth:Number=640, viewportHeight:Number=480, scaleToStage:Boolean=true, interactive:Boolean=false, cameraType:String="Target")
		{
			super(640, 480);
			
			init();
			initCanvas();
		}
		private function init():void
		{
			_light = new PointLight3D();
			
			_rhythm = new SimpleRhythm(createTorus);
			_rhythm.start(TimeType.TIME, 5000);
			createTorus(null);
			
			addEventListener(Event.ENTER_FRAME, onRenderTick);
			
		}
		private function stageClick(e:MouseEvent):void
		{
			var i:uint;
			if(_isRunning)
			{
				for(i = 0; i < _vibs.length; i++)
				{
					//_vibs[i].stop();
				}
				removeEventListener(Event.ENTER_FRAME, onRenderTick);
				_canvas.stopCapture();
				_isRunning = false;
			}
			else 
			{
				for(i = 0; i < _vibs.length; i++)
				{
					//_vibs[i].start();
				}
				addEventListener(Event.ENTER_FRAME, onRenderTick);
				_canvas.startCapture(viewport, true);
				_isRunning = true;
			}
		}
		private function initCanvas():void
		{
			_canvas = new BitmapCanvas(w, h);
			stage.addChild(_canvas);
			_canvas.startCapture(viewport, true);
			//addEventListener(Event.ENTER_FRAME, onRenderTick);
		}
		private function createTorus(rhythm:SimpleRhythm):void
		{
			trace(_torusKnots.length);
			
			if(_torusKnots.length == _numItems - 1)
			{
				stage.addEventListener(MouseEvent.CLICK, stageClick);
				_rhythm.stop();
			}
			var mat:FlatShadeMaterial = new FlatShadeMaterial(_light, Math.random() * 0xFFFFFF, Math.random() * 0xFFFFFF);
			var matList:MaterialsList = new MaterialsList();
			matList.addMaterial(mat, "all");
			var tk:DAE = new DAE();
			_torusKnots.push(tk as DAE);
			tk.scale = Math.random() * 5 + 0.9;
			tk.addEventListener(FileLoadEvent.LOAD_COMPLETE, daeLoaded);
			tk.load("../assets/TorusKnot.DAE", matList);
		}
		private function daeLoaded(e:FileLoadEvent):void
		{
			scene.addChild(e.target as DisplayObject3D);
			initVibrations(e.target);
		}
		private function initVibrations(target:Object):void
		{
			var xv:FixedVibration = new FixedVibration(target, "x", 0.9, 0.03, -w, w, false);
			var yv:FixedVibration = new FixedVibration(target, "y", 0.9, 0.03, -h, h, false);
			var zv:FixedVibration = new FixedVibration(target, "z", 0.9, 0.03, -centreX, centreX, false);
			var rxv:FixedVibration = new FixedVibration(target, "rotationX", 0.9, 0.03, -360, 360, false);
			var ryv:FixedVibration = new FixedVibration(target, "rotationY", 0.9, 0.03, -360, 360, false);
			xv.start();
			yv.start();
			zv.start();
			rxv.start();
			ryv.start();
			_vibs.push(xv);
			_vibs.push(yv);
			_vibs.push(zv);
			_vibs.push(rxv);
			_vibs.push(ryv);
		}
		override protected function onRenderTick(event:Event=null) : void
		{
			renderer.renderScene(scene, camera, viewport);
		}
	}
}