package com.tests
{
	import flash.events.Event;
	
	import org.fly3D.display.BasicScene;
	import org.fly3D.display.BasicShape3D;
	import org.fly3D.display.graphics.GraphicsOptions;
	import org.fly3D.geom.Point3D;
	
	public class SphericalLissajousLine extends BasicScene
	{
		private var _go:GraphicsOptions;
		
		private var _sl:BasicShape3D;
		
		private var theta:Number = degreesToRadians(1);
		
		private var phi:Number = degreesToRadians(1);
		
		private var rep:Number = 60;
		
		private var pi:Number = Math.PI;
		
		private var radius:Number = 100;
		
		private var radius2:Number = 2;
		
		private var sin:Function = Math.sin;
		
		private var cos:Function = Math.cos;
		
		private var _angleX:Number = 0;
		
		private var _angleY:Number = 0;
		
		private var _half:uint = 0;
		
		public function SphericalLissajousLine(w:Number, h:Number)
		{
			super(w * 0.5, h * 0.5, 250);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_sl = new BasicShape3D(null, false);
			_sl.move(0, 0, 0);
			add3DShape(_sl);
			
			_go = new GraphicsOptions(_sl.graphics, GraphicsOptions.CURVE);
			_go.setLineStyle(true, 0xcc0000);
			_go.fill = false;
			_sl.graphicsOptions = _go;
			
			initPoints();
			lissajous();
			startRendering();
		}
		
		private function initPoints():void
		{
			var i:uint = 0;
			var len:Number = rep * pi;
			_half = len;
			var p:Point3D;
			
			for(i = 0; i < len; i += 1)
			{
				p = new Point3D(0, 0, 0);
				p.setVanishingPoint(0, 0);
				_sl.addPoint(p);
			}
			
			//Wrapping curve
			for(i = 0; i < len; i += 1)
			{
				p = new Point3D(0, 0, 0);
				p.setVanishingPoint(0, 0);
				_sl.addPoint(p);
			}
		}
		
		private function lissajous():void
		{
			var i:uint = 0;
			var len:Number = _sl.points.length;
			var p:Point3D;
			
			//Initial Curve
			for(i = 0; i < _half; i += 1)
			{
				p = _sl.points[i];
				p.x = radius * sin(theta * i) * cos(phi * i);
				p.z = radius * cos(theta * i);
				p.y = radius * sin(theta * i) * sin(phi * i);
			}
			
			//Wrapping curve
			for(i = _half; i < len; i += 1)
			{
				p = _sl.points[i];
				p.x = radius2 * sin(100 * theta * i) * cos(100 * phi * i) + radius * sin(theta * i) * cos(phi * i);
				p.z = radius2 * cos(100 * theta * i) + radius * cos(theta * i);
				p.y = radius2 * sin(100 * theta * i) * sin(100 * phi * i) + radius * sin(theta * i) * sin(phi * i);
			}
		}
		
		override protected function loop(e:Event):void
		{
			_angleX = (mouseY - vanishingPointX) * .0001;
			_angleY = (mouseX - vanishingPointY) * .0001;
			_sl.rotatePointsX(_angleX);
			_sl.rotatePointsY(_angleY);
			
			//theta += 0.005;
			//phi += 0.002;
			//lissajous();
			
			render();
		}
	}
}