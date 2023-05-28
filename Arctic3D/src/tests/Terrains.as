package tests
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.arctic3d.display.Arctic3DScene;
	import org.arctic3d.geom.Light;
	import org.arctic3d.geom.Point3D;
	import org.arctic3d.geom.Triangle;
	
	public class Terrains extends Arctic3DScene
	{		
		private var _points:Vector.<Point3D>;
		private var _triangles:Vector.<Triangle>;
		
		private var _numPoints:uint;
		private var _numTriangles:uint;
		
		private var _light:Light;
		
		public function Terrains(w:Number=640, h:Number=480)
		{
			super(w, h);
		}
		
		override protected function init(e:Event):void
		{
			_light = new Light();
			_points = new Vector.<Point3D>();
			_triangles = new Vector.<Triangle>();
			
			_points[0] = (new Point3D(-100, -100, 50));
			_points[1] = (new Point3D(100, -100, 0));
			_points[2] = (new Point3D(-100, 100, -75));
			_points[3] = (new Point3D(100, 100, 0));
			
			_triangles[0] = (new Triangle(_points[0], _points[1], _points[2]));
			_triangles[1] = (new Triangle(_points[1], _points[3], _points[2]));
			
			_numPoints = _points.length;
			_numTriangles = _triangles.length;
			
			for(var i:uint = 0; i  < _numPoints; i++)
			{
				_points[i].setVanishingPoint(vpX, vpY);
				_points[i].setCenter(0, 0, 200);
			}
			
			for(i=0;i<_numTriangles;i++)
			{
				_triangles[i].light = _light;
				//_triangles[i].color = 0x880000;
			}
			
			triangleRenderer.debug = true;
			
			stage.addEventListener(MouseEvent.CLICK, stageClick_Handler);
			
			startRendering();
		}
		
		private function stageClick_Handler(e:MouseEvent):void
		{
			triangleRenderer.debug =! triangleRenderer.debug;
		}
		
		override protected function onRenderTick(e:Event):void
		{
			super.onRenderTick(e);
		}
		
		override protected function render():void
		{
			triangleRenderer.renderTriangles(_triangles);
		}
	}
}