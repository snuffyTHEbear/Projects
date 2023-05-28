package com.tests
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import org.fly3D.display.BasicScene;
	import org.fly3D.display.BasicShape3D;
	import org.fly3D.display.graphics.GraphicsOptions;
	import org.fly3D.geom.Light;
	
	public class LightTests extends BasicScene
	{
		private var _light:Light;
		
		private var _shape:BasicShape3D;
		
		private var _go:GraphicsOptions;
		
		public function LightTests(w:Number, h:Number)
		{
			super(w * 0.5, h * 0.5);
			
			_light = new Light(0, 0, -100, 1);
			
			_shape = new BasicShape3D(_light);
			_shape.move(0, 0, 0);
			add3DShape(_shape);
			
			_go = new GraphicsOptions(_shape.graphics);
			_go.fill = true;
			_go.fillColour = 0xcc0000;
			_go.fillAlpha = 1.0;
			_go.type = GraphicsOptions.FACES;
			_shape.graphicsOptions = _go;
			
			_shape.addPoints([[-100, -100, -100], [100, -100, -100], [100, 100, -100], [-100, 100, -100], [-100, -100, 100], [100, -100, 100], [100, 100, 100], [-100, 100, 100]]);
			
			_shape.buildTriangles([[0, 1, 2], [0, 2, 3], [0, 5, 1], [0, 4, 5], [4, 6, 5], [4, 7, 6], [3, 2, 6], [3, 6, 7], [1, 5, 6], [1, 6, 2], [4, 0, 3], [4, 3, 7]]);
			
			_shape.setCenterPoint(0, 0, 0);
			
			for(var i:uint = 0; i < _shape.numTriangles; i++)
			{
				_shape.triangles[i].color = _go.fillColour;
			}
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			e.target.removeEventListener(e.target, arguments.callee);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, stageKey);
			//addEventListener(Event.ENTER_FRAME, loop);
			startRendering();
		}
		
		private function stageKey(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.UP)
			{
				_light.z += 10;
			}
			else if(e.keyCode == Keyboard.DOWN)
			{
				_light.z -= 10;
			}
		}
		
		override protected function loop(e:Event):void
		{
			_light.move(mouseX - vanishingPointX, mouseY - vanishingPointY, -100);
			_shape.rotatePointsX(0.01);
			_shape.rotatePointsY(0.01);
			render();
		}
	}
}