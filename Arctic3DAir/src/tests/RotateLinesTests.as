package tests
{
	import flash.events.Event;
	
	import org.arctic3d.display.Arctic3DScene;
	import org.arctic3d.geom.Point3D;
	
	public class RotateLinesTests extends Arctic3DScene
	{
		private var _points:Vector.<Point3D>;
		private var _numPoints:uint = 50;
		
		public function RotateLinesTests(w:Number=640, h:Number=480)
		{
			super(w, h);
		}
		
		override protected function init(e:Event) : void
		{
			_points = new Vector.<Point3D>();
			for(var i:uint = 0 ;i < _numPoints; i ++)
			{
				var p:Point3D = new Point3D(Math.random() * 200 - 100, Math.random() * 200 - 100, Math.random() * 200 - 100);
				p.setCenter(0, 0, 0);
				p.setVanishingPoint(vpX, vpY);
				_points[i] = p;
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
			graphics.lineStyle(0, 0xC30d4A);
			graphics.moveTo(_points[0].screenX, _points[0].screenY);
			for(var i:uint = 1; i < _numPoints; i++)
			{
				graphics.lineTo(_points[i].screenX, _points[i].screenY);
			}
		}
	}
}