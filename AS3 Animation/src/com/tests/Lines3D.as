package com.tests
{
	import flash.events.Event;
	
	import org.fly3D.display.BasicScene;
	import org.fly3D.display.BasicShape3D;
	import org.fly3D.display.graphics.GraphicsOptions;
	import org.fly3D.geom.Point3D;
	
	public class Lines3D extends BasicScene
	{
		private var _numPoints:uint = 50;
		
		private var _lines:BasicShape3D;
		
		private var _go:GraphicsOptions;
		
		private var max:Number = 200;
		
		private var min:Number = max * 0.5;
		
		private var radius:Number = 100;
		
		public function Lines3D(w:Number, h:Number)
		{
			super(w * 0.5, h * 0.5);
			
			_lines = new BasicShape3D(null, false);
			_lines.move(0, 0, 0);
			_go = new GraphicsOptions(_lines.graphics);
			_go.fill = false;
			_go.setLineStyle(true, 0, 1, 1);
			add3DShape(_lines);
			_lines.graphicsOptions = _go;
			_lines.setCenterPoint(0, 0, 0);
			_lines.joinPoints = false;
			
			for(var i:Number = -_numPoints / 2; i < _numPoints / 2; i++)
			{
				//_lines.addPoint(new Point3D(Math.random() * max - min, Math.random() * max - min, Math.random() * max - min));
				_lines.addPoint(new Point3D(Math.cos(i) * Math.PI / 180, Math.cos(i) * 180 / Math.PI, i * 5));
			}
			
			//addEventListener(Event.ENTER_FRAME, loop);
			startRendering();
		}
		
		override protected function loop(e:Event):void
		{
			var angleX:Number = (mouseY - vanishingPointY) * .0005;
			var angleY:Number = (mouseX - vanishingPointX) * .0005;
			
			_lines.rotatePointsX(angleX);
			_lines.rotatePointsY(angleY);
			
			render();
		}
	}
}