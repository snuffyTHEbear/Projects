package tests
{
	import flash.display.BitmapData;
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
		private var rows:uint = 10;
		private var cols:uint = 10;
		private var _numPoints:uint;
		private var _numTriangles:uint;
		private var _bmd:BitmapData;
		
		private var _light:Light;
		
		private var _theta:Number = 0;
		private var _angle:Number = 0;
		
		//GUI / Controls
		
		public function Terrains(w:Number=640, h:Number=480)
		{
			super(w, h);
		}
		
		private function setupControls():void
		{
			
		}
		/**
		 * Adds a point to the Points Vector
		 * @param x
		 * @param y
		 * @param z
		 * 
		 */		
		private function addPoint(x:Number, y:Number, z:Number):void
		{
			_points[_numPoints] = new Point3D(x,y,z);
			_numPoints++;
		}
		/**
		 * Adds a triangle to the Triangle Vector
		 * @param a - Point A Index
		 * @param b - Point B Index
		 * @param c - Point C Index
		 * 
		 */		
		private function addTriangle(a:Number, b:Number, c:Number):void
		{
			_triangles[_numTriangles] = new Triangle(_points[a], _points[b], _points[c]);
			_numTriangles++;
		}
		/**
		 * Create's and adds Point3D's to the points vector from and array of positions
		 * [0,0,0][10,10,10][50,50,50] 
		 * @param pointPositions
		 * 
		 */		
		private function createPoints(...rest):void
		{
			var i:uint, len:uint = rest.length;
			for(i=0;i<len;i++)
			{
				addPoint(rest[i][0], rest[i][1], rest[i][2]);
			}
		}
		/**
		 * Create's and adds Triangles to the triangles vector from and array of indexes
		 * [0,1,2], [1,3,2]
		 * @param trianglePoints
		 * 
		 */	
		private function createTriangles(...rest):void
		{
			var i:uint, len:uint = rest.length;
			for(i=0;i<len;i++)
			{
				addTriangle(rest[i][0], rest[i][1], rest[i][2]);
			}
		}
		
		private function makeTriangles():void
		{
			var res:Number = 50;
			for(var i:int = 0; i < rows; i++)
			{
				for(var j:int = 0; j < cols; j++)
				{
					//positions
					addPoint(j * res - (cols * res) / 2, i * res - (rows * res) / 2, 0);
					
				}
			}
			
			for(i = 0; i < rows; i++)
			{
				for(j = 0; j < cols; j++)
				{
					
					if(i < rows - 1 && j < cols - 1)
					{
						// first triangle
						addTriangle(i * cols + j, i * cols + j + 1, (i + 1) * cols + j);
						// second triangle
						addTriangle(i * cols + j + 1,(i + 1) * cols + j + 1,(i + 1) * cols + j);
					}
				}
			}
		}
		
		override protected function init(e:Event):void
		{
			setupControls();
			
			_bmd = new BitmapData(250,250, false, 0);
			_bmd.perlinNoise(10, 10, 2, Math.random(), true, true, 3);
			
			_light = new Light();
			_points = new Vector.<Point3D>();
			_triangles = new Vector.<Triangle>();
			
			//createPoints([-100, -100, 0], [100, -100, 0], [-100, 100, 0], [100, 100, 0]);
			//createTriangles([0, 1, 2], [1,3,2]);
			
			makeTriangles();
			
			_numPoints = _points.length;
			_numTriangles = _triangles.length;
			var i:uint;
			for(i = 0; i  < _numPoints; i++)
			{
				_points[i].setVanishingPoint(vpX, vpY);
				_points[i].setCenter(0, 0, 200);
				_points[i].rotateX(-45);
			}
			
			for(i=0;i<_numTriangles;i++)
			{
				_triangles[i].light = _light;
				_triangles[i].doubleSided = true;
				_triangles[i].color = 0xc5df72;
			}
			
			triangleRenderer.debug = true;
			
			//stage.addEventListener(MouseEvent.CLICK, stageClick_Handler);
			
			//singleRender();
			
			startRendering();
		}
		
		private function stageClick_Handler(e:MouseEvent):void
		{
			triangleRenderer.debug =! triangleRenderer.debug;
		}
		
		override protected function onRenderTick(e:Event):void
		{			
			triangleRenderer.depthSort(_triangles);
			
			var i:uint, j:uint;
			for(i = 0; i < rows; i++)
			{
				for(j = 0; j < cols; j++)
				{
					
					if(i < rows - 1 && j < cols - 1)
					{
						_theta+=1;
						_angle = Math.sin(_theta) * 10;
						// first triangle
						//addTriangle(i * cols + j, i * cols + j + 1, (i + 1) * cols + j);
						_points[i * cols + j].z += _angle;
						_points[i * cols + j + 1].z += _angle;
						_points[(i + 1) * cols + j].z += _angle;
						// second triangle
						//addTriangle(i * cols + j + 1,(i + 1) * cols + j + 1,(i + 1) * cols + j);
						_points[i * cols + j + 1].z += _angle;
						_points[(i + 1) * cols + j + 1].z += _angle;
						_points[(i + 1) * cols + j].z += _angle;
					}
				}
			}
			
			super.onRenderTick(e);
		}
		
		override protected function render():void
		{
			triangleRenderer.renderTriangles(_triangles, false, _bmd);
		}
	}
}