package com.tests
{
	import flash.events.Event;
	
	import org.fly3D.display.BasicScene;
	import org.fly3D.display.BasicShape3D;
	import org.fly3D.display.graphics.GraphicsOptions;
	import org.fly3D.geom.Light;
	import org.fly3D.geom.Point3D;
	import org.fly3D.geom.Triangle;
	
	public class Polygons extends BasicScene
	{
		private var _polygons:BasicShape3D;
		
		private var _go:GraphicsOptions;
		
		private var _light:Light;
		
		private var _width:Number;
		
		private var _height:Number;
		
		private var _angle:Number = 0;
		
		private var _sin:Function = Math.sin;
		
		private var _cos:Function = Math.cos;
		
		private var _colours:Array = new Array(0xC1BD7F, 0xC9BD42, 0xD7A730, 0xE68732, 0xF36540);
		
		public function Polygons(w:Number, h:Number)
		{
			//AUDIO based movement / Visualizer
			super(w * 0.5, h * 0.5);
			
			_width = w * 0.5;
			_height = h * 0.5;
			
			_light = new Light();
			
			_polygons = new BasicShape3D(_light, true);
			var _a:Number = 0;
			var _r:Number = 3;
			for (var i:uint = 0; i < 130; i++)
			{
				var c:uint = _colours[Math.floor(Math.random() * _colours.length)];
				var posX:Number = Math.cos(_a) * _r; //Math.random() * _width - (_width / 2);
				var posY:Number = Math.sin(_a) * _r; //Math.random() * _height - (_height / 2);
				var pA:Point3D = new Point3D(posX + Math.random() * 30 - 15, posY + Math.random() * 30 - 15, Math.random() * 30 - 15);
				var pB:Point3D = new Point3D(posX + Math.random() * 30 - 15, posY + Math.random() * 30 - 15, Math.random() * 30 - 15);
				var pC:Point3D = new Point3D(posX + Math.random() * 30 - 15, posY + Math.random() * 30 - 15, Math.random() * 30 - 15);
				var t:Triangle = new Triangle(pA, pB, pC, c, _light);
				t.doubleSided = true;
				_polygons.addTriangle(t);
				
				_a += 0.1;
				_r += (1.6 / 3.14) * 4.2;
			}
			
			_go = new GraphicsOptions(_polygons.graphics, GraphicsOptions.FACES);
			_go.setBeginFill(true);
			_polygons.graphicsOptions = _go;
			
			add3DShape(_polygons);
			
			startRendering();
			//addEventListener(Event.ENTER_FRAME, loop);
		}
		
		override protected function loop(e:Event):void
		{
			for (var i:uint = 0; i < _polygons.triangles.length; i++)
			{
				var t:Triangle = _polygons.triangles[i];
				
				//t.pointA.z += _sin(_angle) * 10;
				//t.pointB.z += _sin(_angle) * 10;
				t.pointC.z += _sin(_angle) * 150;
				
				/*t.pointA.rotateY(0.04);
				   t.pointB.rotateY(0.03);
				 t.pointC.rotateX(0.03);*/
				
				/*t.pointA.rotateY(0.04);
				   t.pointB.rotateY(0.04);
				 t.pointC.rotateY(0.04);*/
				
				/*t.pointA.rotateZ(0.04);
				   t.pointB.rotateZ(0.04);
				 t.pointC.rotateZ(0.04);*/
			}
			
			_angle += 0.2;
			
			render();
		}
	}
}