package tests
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.arctic3d.display.Arctic3DScene;
	import org.arctic3d.geom.Light;
	import org.arctic3d.geom.Point3D;
	import org.arctic3d.geom.Triangle;
	
	public class Cube extends Arctic3DScene
	{
		private var _points:Vector.<Point3D>;
		private var _triangles:Vector.<Triangle>;
		private var _numPoints:uint;
		private var _numTriangles:uint;
		private var _light:Light;
		
		public function Cube(w:Number=640, h:Number=480)
		{
			super(w, h);
		}
		
		override protected function init(e:Event) : void
		{
			_points = new Vector.<Point3D>();
			_triangles = new Vector.<Triangle>();
			
			// front four corners
			_points[0] = new Point3D(-100, -100, -100);
			_points[1] = new Point3D( 100, -100, -100);
			_points[2] = new Point3D( 100,  100, -100);
			_points[3] = new Point3D(-100,  100, -100);
			// back four corners
			_points[4] = new Point3D(-100, -100,  100);
			_points[5] = new Point3D( 100, -100,  100);
			_points[6] = new Point3D( 100,  100,  100);
			_points[7] = new Point3D(-100,  100,  100);
			
			// front
			_triangles[0] = new Triangle(_points[0], _points[1],_points[2]);
			_triangles[1] = new Triangle(_points[0], _points[2],_points[3]);
			// top
			_triangles[2] = new Triangle(_points[0], _points[5], _points[1]);
			_triangles[3] = new Triangle(_points[0], _points[4], _points[5]);
			//back
			_triangles[4] = new Triangle(_points[4], _points[6],_points[5]);
			_triangles[5] = new Triangle(_points[4], _points[7],_points[6]);
			// bottom
			_triangles[6] = new Triangle(_points[3], _points[2],_points[6]);
			_triangles[7] = new Triangle(_points[3], _points[6],_points[7]);
			// right
			_triangles[8] = new Triangle(_points[1], _points[5],_points[6]);
			_triangles[9] = new Triangle(_points[1], _points[6],_points[2]);
			// left
			_triangles[10] = new Triangle(_points[4], _points[0],_points[3]);
			_triangles[11] = new Triangle(_points[4], _points[3],_points[7]);
			
			_numPoints = _points.length;
			_numTriangles = _triangles.length;
			_light = new Light();
			
			for(var i:uint = 0; i  < _numPoints; i++)
			{
				_points[i].setVanishingPoint(vpX, vpY);
				_points[i].setCenter(0, 0, 200);
			}
			
			for(i=0;i<_numTriangles;i++)
			{
				_triangles[i].light = _light;
				_triangles[i].color = Math.random() * 0xFFFFFF;
			}
			
			triangleRenderer.alpha = 0.3;
			
			stage.addEventListener(MouseEvent.CLICK, stageClick_Handler);
			
			startRendering();
		}
		
		override protected function onRenderTick(e:Event) : void
		{
			var angleX:Number = (mouseY - vpY) * .001;
			var angleY:Number = (mouseX - vpX) * .001;
			
			for(var i:uint = 0 ; i < _numPoints; i++)
			{
				_points[i].rotateX(angleX);
				_points[i].rotateY(angleY);
			}
			
			triangleRenderer.depthSort(_triangles);
			
			super.onRenderTick(e);
		}
		
		override protected function render() : void
		{
			triangleRenderer.renderTriangles(_triangles);
		}
		
		private function stageClick_Handler(e:MouseEvent):void
		{
			triangleRenderer.debug =! triangleRenderer.debug;
		}
	}
}