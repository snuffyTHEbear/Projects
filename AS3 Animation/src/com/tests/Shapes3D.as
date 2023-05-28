package com.tests
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import org.fly3D.display.BasicScene;
	import org.fly3D.display.BasicShape3D;
	import org.fly3D.display.graphics.GraphicsOptions;
	import org.fly3D.geom.Point3D;
	
	public class Shapes3D extends BasicScene
	{
		private var _shape:BasicShape3D;
		
		private var _go:GraphicsOptions;
		
		public function Shapes3D(w:Number, h:Number)
		{
			super(w * 0.5, h * 0.5);
			
			_shape = new BasicShape3D();
			_shape.move(0, 0, 0);
			add3DShape(_shape);
			
			_go = new GraphicsOptions(_shape.graphics);
			_go.fill = true;
			_go.fillAlpha = 1.0;
			_go.fillColour = 0xcc0000;
			_go.type = GraphicsOptions.SOLID_COLOR;
			_go.line = true;
			_go.lineAlpha = 1.0;
			_go.lineColour = 0;
			_go.lineThickness = 0;
			_shape.graphicsOptions = _go;
			
			_shape.addPoints([[-50, -250, 0], [50, -250, 0], [200, 250, 0],
							  [100, 250, 0], [50, 100, 0], [-50, 100, 0],
							  [-100, 250, 0], [-200, 250, 0], [0, -150, 0],
							  [50, 0, 0], [-50, 0, 0]]);
			
			_shape.buildTriangles([[0, 1, 8], [1, 9, 8], [1, 2, 9], [2, 4, 9], 
								   [2, 3, 4], [4, 5, 9], [9, 5, 10], [5, 6, 7], 
								   [5, 7, 10], [0, 10, 7], [0, 8, 10]]);
			
			//_shape.addPoints([[-50, -50, 0], [50, -50, 0], [50, 50, 0], [-50, 50, 0]]);
			//_shape.buildTriangles([[0, 1, 2], [2, 3, 0]]);
			
			_shape.setCenterPoint(0, 0, 200);
			_shape.setVanishingPoint(w * 0.5, h * 0.5);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			e.target.removeEventListener(e.type, arguments.callee);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, stageKey);
			startRendering();
		}
		
		private function stageKey(e:KeyboardEvent):void
		{
			if(e.keyCode == 76)
			{
				_go.line = !_go.line;
			}
		}
		
		override protected function loop(e:Event):void
		{
			var angleX:Number = (mouseY - vanishingPointY) * .001;
			var angleY:Number = (mouseX - vanishingPointX) * .001;
			_shape.rotatePointsX(angleX);
			_shape.rotatePointsY(angleY);
			//_shape.rotateX(angleX);
			//_shape.rotateY(angleY);
			depthSort();
			render();
		}
	}
}