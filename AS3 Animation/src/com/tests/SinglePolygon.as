package com.tests
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import org.fly3D.display.BasicScene;
	import org.fly3D.display.BasicShape3D;
	import org.fly3D.display.graphics.GraphicsOptions;
	import org.fly3D.geom.Light;
	
	public class SinglePolygon extends BasicScene
	{
		private var _light:Light;
		
		private var _polygon:BasicShape3D;
		
		private var _go:GraphicsOptions;
		
		public function SinglePolygon(w:Number, h:Number)
		{
			super(w * 0.5, h * 0.5);
			
			_light = new Light(-100, -100, -100, 1);
			
			_polygon = new BasicShape3D(_light);
			_polygon.move(0, 0, 0);
			add3DShape(_polygon);
			
			_go = new GraphicsOptions(_polygon.graphics);
			_go.fill = true;
			_go.fillAlpha = 1.0;
			_go.type = "faces";
			_go.fillColour = 0;
			
			_go.line = false;
			_go.lineAlpha = 1.0;
			_go.lineColour = 0xcc0000;
			_go.lineThickness = 5;
			
			_polygon.graphicsOptions = _go;
			
			_polygon.addPoints([[-100, -50, 0], [100, -25, 0], [0, 100, 0]]);
			_polygon.buildTriangles([[0, 1, 2]]);
			
			_polygon.setCenterPoint(0, 0, 0);
			_polygon.triangles[0].color = 0xCC0000;
			_polygon.triangles[0].doubleSided = true;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			e.target.removeEventListener(e.target, arguments.callee);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function keyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == 76)
			{
				_go.line = !_go.line;
			}
		}
		
		private function loop(e:Event):void
		{
			var angleX:Number = (mouseY - vanishingPointY) * .001;
			var angleY:Number = (mouseX - vanishingPointX) * .001;
			_polygon.rotatePointsX(angleX);
			_polygon.rotatePointsY(angleY);
			render();
		}
	}
}