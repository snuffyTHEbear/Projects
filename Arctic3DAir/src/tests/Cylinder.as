package tests
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.arctic3d.display.Arctic3DScene;
	import org.arctic3d.geom.Light;
	import org.arctic3d.geom.Point3D;
	import org.arctic3d.geom.Triangle;
	
	public class Cylinder extends Arctic3DScene
	{
		private var _points:Vector.<Point3D>;
		private var _triangles:Vector.<Triangle>;
		private var _numPoints:uint;
		private var _numTriangles:uint;
		private var _numFaces:uint = 15;
		private var _light:Light = new Light();
		
		public function Cylinder(w:Number=640, h:Number=480)
		{
			super(w, h);
		}
		
		override protected function init(e:Event) : void
		{
			_points = new Vector.<Point3D>();
			_triangles = new Vector.<Triangle>();
			
			var index:uint = 0;
			var angle:Number;
			var xpos:Number;
			var ypos:Number;
			
			for(var i:uint = 0; i < _numFaces; i++)
			{
				angle = Math.PI * 2 / _numFaces * i;
				xpos = Math.cos(angle) * 200;
				ypos = Math.sin(angle) * 200;
				_points[index] = new Point3D(xpos, ypos, 100);
				_points[index + 1] = new Point3D(xpos, ypos, -100);
				index += 2;
			}
			
			_numPoints = _points.length;
			
			for(i = 0; i  < _numPoints; i++)
			{
				_points[i].setVanishingPoint(vpX, vpY);
				_points[i].setCenter(0, 0, 200);
			}
			
			index = 0;
			
			for(i = 0; i < _numFaces -1; i++)
			{
				_triangles[index] = new Triangle(_points[index], _points[index + 3], _points[index + 1]);
				_triangles[index + 1] = new Triangle(_points[index], _points[index + 2], _points[index + 3]);
				index += 2;
			}
			
			_triangles[index] = new Triangle(_points[index], _points[1], _points[index + 1]);
			_triangles[index + 1] = new Triangle(_points[index], _points[0], _points[1]);
			
			_numTriangles = _triangles.length;
			
			for(i=0;i<_numTriangles;i++)
			{
				_triangles[i].light = _light;
				_triangles[i].doubleSided = false;
			}
			
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