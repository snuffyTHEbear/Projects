package com.tests
{
	import flash.events.Event;
	
	import org.fly3D.display.BasicScene;
	import org.fly3D.display.BasicShape3D;
	import org.fly3D.display.Plane;
	import org.fly3D.display.graphics.GraphicsOptions;
	import org.fly3D.geom.Light;
	
	public class PlaneTests extends BasicScene
	{
		private var angle:Number = 0;
		
		private var _plane:Plane;
		
		private var _light:Light = new Light(-250, -250, 0);
		
		private var _shape:BasicShape3D;
		
		private var _go:GraphicsOptions;
		
		private var _go2:GraphicsOptions;
		
		public function PlaneTests(w:Number, h:Number)
		{
			super(w * 0.5, h * 0.5);
			
			_plane = new Plane(250, 250, Plane.VERY_HIGH, _light, true);
			_plane.move(0, 0, 0);
			_plane.setCenterPoint(0, 0, 0);
			add3DShape(_plane);
			_plane.doubleSided = true;
			
			_go2 = new GraphicsOptions(_plane.graphics, GraphicsOptions.FACES);
			_go2.setBeginFill(true);
			
			for (var i:uint = 0; i < _plane.triangles.length; i++)
			{
				_plane.triangles[i].color = 0xcfeda3;
			}
			
			_plane.graphicsOptions = _go2;
			
			/**
			 **/
			
			_shape = new BasicShape3D(_light, true);
			_shape.move(0, 0, 0);
			add3DShape(_shape);
			
			_shape.addPoints([[-50, -50, 0], [50, -50, 0], [50, 50, 0], [-50, 50, 0]]);
			_shape.buildTriangles([[0, 1, 2], [2, 3, 0]], true);
			
			for (i = 0; i < _shape.triangles.length; i++)
			{
				_shape.triangles[i].doubleSided = true;
			}
			
			_go = new GraphicsOptions(_shape.graphics, GraphicsOptions.SOLID_COLOR);
			_go.fill = true;
			_go.fillAlpha = 1;
			_go.type = GraphicsOptions.SOLID_COLOR;
			_go.fillColour = 0xe4a3cb;
			_shape.graphicsOptions = _go;
			
			_light.color = 0x00CC00;
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		override protected function loop(e:Event):void
		{
			_plane.rotatePointsY(0.02);
			_shape.rotatePointsX(0.02);
			_shape.z = Math.sin(angle) * 50;
			trace(_shape.z);
			angle += 0.1;
			depthSort();
			render();
		}
	}
}