package tests
{
	import flash.events.Event;
	
	import org.arctic3d.display.Arctic3DScene;
	import org.arctic3d.geom.Point3D;
	
	public class BasicPlane extends Arctic3DScene
	{
		private var _points:Vector.<Point3D>;
		private var _numPoints:uint;
		
		public function BasicPlane(w:Number=640, h:Number=480)
		{
			super(w, h);
		}
		
		override protected function init(e:Event) : void
		{
			_points = new Vector.<Point3D>();
			_points[0] = new Point3D(-100, -100, 0);
			_points[1] = new Point3D(100, -100, 0);
			_points[2] = new Point3D(100, 100, 0);
			_points[3] = new Point3D(-100, 100, 0);
			_numPoints = _points.length;
			
			for(var i:uint = 0; i < _numPoints; i++)
			{
				_points[i].setCenter(0, 0, 0);
				_points[i].setVanishingPoint(vpX, vpY);
			}
			
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
			
			super.onRenderTick(e);
		}
		
		override protected function render() : void
		{
			graphics.clear();
			graphics.lineStyle(0, 0);
			graphics.beginFill(0xCC0000);
			graphics.moveTo(_points[0].screenX, _points[0].screenY);
			for(var i:uint = 1; i < _numPoints; i++)
			{
				graphics.lineTo(_points[i].screenX, _points[i].screenY);
			}
			graphics.lineTo(_points[0].screenX, _points[0].screenY);
			graphics.endFill();
		}
	}
}