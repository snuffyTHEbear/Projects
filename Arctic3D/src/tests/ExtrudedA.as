package tests
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.arctic3d.display.Arctic3DScene;
	import org.arctic3d.geom.Light;
	import org.arctic3d.geom.Point3D;
	import org.arctic3d.geom.Triangle;
	
	public class ExtrudedA extends Arctic3DScene
	{
		private var _points:Vector.<Point3D>;
		private var _triangles:Vector.<Triangle>;
		private var _numPoints:uint;
		private var _numTriangles:uint;
		
		private var _offsetX:Number = 0;
		private var _offsetY:Number = 0;
		
		private var _light:Light = new Light();
		
		public function ExtrudedA(w:Number=640, h:Number=480)
		{
			super(w, h);
		}
		
		override protected function init(e:Event) : void
		{
			_points = new Vector.<Point3D>();
			_triangles = new Vector.<Triangle>();
			
			_points[0] = new Point3D( -50, -250,  -50);
			_points[1] = new Point3D(  50, -250,  -50);
			_points[2] = new Point3D( 200,  250,  -50);
			_points[3] = new Point3D( 100,  250,  -50);
			_points[4] = new Point3D(  50,  100,  -50);
			_points[5] = new Point3D( -50,  100,  -50);
			_points[6] = new Point3D(-100,  250,  -50);
			_points[7] = new Point3D(-200,  250,  -50);
			_points[8] = new Point3D(   0, -150,  -50);
			_points[9] = new Point3D(  50,    0,  -50);
			_points[10] = new Point3D( -50,   0,  -50);
			_points[11] = new Point3D( -50, -250,  50);
			_points[12] = new Point3D(  50, -250,  50);
			_points[13] = new Point3D( 200,  250,  50);
			_points[14] = new Point3D( 100,  250,  50);
			_points[15] = new Point3D(  50,  100,  50);
			_points[16] = new Point3D( -50,  100,  50);
			_points[17] = new Point3D(-100,  250,  50);
			_points[18] = new Point3D(-200,  250,  50);
			_points[19] = new Point3D(   0, -150,  50);
			_points[20] = new Point3D(  50,    0,  50);
			_points[21] = new Point3D( -50,    0,  50);
			
			_triangles[0] =new Triangle(_points[0],   _points[1],_points[8], 0xCC0000);
			_triangles[1] =new Triangle(_points[1],   _points[9],_points[8], 0xCC0000);
			_triangles[2] =new Triangle(_points[1],   _points[2],_points[9], 0xCC0000);
			_triangles[3] =new Triangle(_points[2],   _points[4],_points[9], 0xCC0000);
			_triangles[4] =new Triangle(_points[2],   _points[3],_points[4], 0xCC0000);
			_triangles[5] =new Triangle(_points[4],   _points[5],_points[9], 0xCC0000);
			_triangles[6] =new Triangle(_points[9],   _points[5],_points[10], 0xCC0000);
			_triangles[7] =new Triangle(_points[5],   _points[6],_points[7], 0xCC0000);
			_triangles[8] =new Triangle(_points[5],   _points[7],_points[10], 0xCC0000);
			_triangles[9] =new Triangle(_points[0],   _points[10],_points[7], 0xCC0000);
			_triangles[10] = new Triangle(_points[0], _points[8],_points[10], 0xCC0000);
			
			_triangles[11] = new Triangle(_points[11], _points[19],	_points[12], 0x00CC00);
			_triangles[12] = new Triangle(_points[12], _points[19],	_points[20], 0x00CC00);
			_triangles[13] = new Triangle(_points[12], _points[20],_points[13], 0x00CC00);
			_triangles[14] = new Triangle(_points[13], _points[20],_points[15], 0x00CC00);
			_triangles[15] = new Triangle(_points[13], _points[15],	_points[14], 0x00CC00);
			_triangles[16] = new Triangle(_points[15], _points[20],	_points[16], 0x00CC00);
			_triangles[17] = new Triangle(_points[20], _points[21],	_points[16], 0x00CC00);
			_triangles[18] = new Triangle(_points[16], _points[18],	_points[17], 0x00CC00);
			_triangles[19] = new Triangle(_points[16], _points[21],	_points[18], 0x00CC00);
			_triangles[20] = new Triangle(_points[11], _points[18],	_points[21], 0x00CC00);
			_triangles[21] = new Triangle(_points[11], _points[21],	_points[19], 0x00CC00);
			
			_triangles[22] = new Triangle(_points[0],  _points[11],	_points[1], 0x0000CC);
			_triangles[23] = new Triangle(_points[11], _points[12],	_points[1], 0x0000CC);
			_triangles[24] = new Triangle(_points[1],  _points[12],	_points[2], 0x0000CC);
			_triangles[25] = new Triangle(_points[12], _points[13],	_points[2], 0x0000CC);
			_triangles[26] = new Triangle(_points[3],  _points[2],	_points[14], 0x0000CC);
			_triangles[27] = new Triangle(_points[2],  _points[13],	_points[14], 0x0000CC);
			_triangles[28] = new Triangle(_points[4],  _points[3],_points[15], 0x0000CC);
			_triangles[29] = new Triangle(_points[3],  _points[14],	_points[15], 0x0000CC);
			_triangles[30] = new Triangle(_points[5],  _points[4],	_points[16], 0x0000CC);
			_triangles[31] = new Triangle(_points[4],  _points[15],	_points[16], 0x0000CC);
			_triangles[32] = new Triangle(_points[6],  _points[5],_points[17], 0x0000CC);
			_triangles[33] = new Triangle(_points[5],  _points[16],	_points[17], 0x0000CC);
			_triangles[34] = new Triangle(_points[7],  _points[6],_points[18], 0x0000CC);
			_triangles[35] = new Triangle(_points[6],  _points[17],	_points[18], 0x0000CC);
			_triangles[36] = new Triangle(_points[0],  _points[7],_points[11], 0x0000CC);
			_triangles[37] = new Triangle(_points[7],  _points[18],	_points[11], 0x0000CC);
			
			_triangles[38] = new Triangle(_points[8],  _points[9],	_points[19], 0xC0C0C0);
			_triangles[39] = new Triangle(_points[9],  _points[20],	_points[19], 0xC0C0C0);
			_triangles[40] = new Triangle(_points[9],  _points[10],	_points[20], 0xC0C0C0);
			_triangles[41] = new Triangle(_points[10], _points[21],	_points[20], 0xC0C0C0);
			_triangles[42] = new Triangle(_points[10], _points[8],_points[21], 0xC0C0C0);
			_triangles[43] = new Triangle(_points[8],  _points[19], _points[21], 0xC0C0C0);
			
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
			
			stage.addEventListener(MouseEvent.CLICK, stageClick_Handler);
			
			startRendering();
		}
		
		private function stageClick_Handler(e:MouseEvent):void
		{
			triangleRenderer.debug =! triangleRenderer.debug;
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
			//triangleRenderer.renderTriangle(_triangles[0]);
			triangleRenderer.renderTriangles(_triangles);
		}
	}
}