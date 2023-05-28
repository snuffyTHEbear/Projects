package com.tests
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import org.fly3D.display.BasicScene;
	import org.fly3D.display.BasicShape3D;
	import org.fly3D.display.graphics.GraphicsOptions;
	import org.fly3D.geom.Light;
	
	public class Cube extends BasicScene
	{
		//[TODO BasicModel3D]
		private var _cube:BasicShape3D;
		
		private var _go:GraphicsOptions;
		
		private var _light:Light = new Light(-250, -250, -100, 1);
		
		private var _offsetX:Number = 0;
		
		private var _offsetY:Number = 0;
		
		public function Cube(w:Number, h:Number)
		{
			super(w * 0.5, h * 0.5);
			
			_cube = new BasicShape3D(_light);
			_cube.move(0, 0, 0);
			add3DShape(_cube);
			
			_go = new GraphicsOptions(_cube.graphics);
			_go.fill = true;
			_go.fillAlpha = 1;
			_go.type = GraphicsOptions.FACES;
			_go.fillColour = 0xffffff;
			_cube.graphicsOptions = _go;
			
			_cube.addPoints([[-100, -100, -100], [100, -100, -100], [100, 100, -100], [-100, 100, -100], [-100, -100, 100], [100, -100, 100], [100, 100, 100], [-100, 100, 100]]);
			
			_cube.buildTriangles([[0, 1, 2], [0, 2, 3], [0, 5, 1], [0, 4, 5], [4, 6, 5], [4, 7, 6], [3, 2, 6], [3, 6, 7], [1, 5, 6], [1, 6, 2], [4, 0, 3], [4, 3, 7]]);
			
			//Move the cube back on the Z axis
			_cube.setCenterPoint(0, 0, 100);
			
			for(var i:uint = 0; i < _cube.numTriangles; i++)
			{
				_cube.triangles[i].color = 0xcc0000;
			}
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			e.target.removeEventListener(e.type, arguments.callee);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, stageKey);
			//addEventListener(Event.ENTER_FRAME, loop);
			
			startRendering();
		}
		
		private function stageKey(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
				case Keyboard.LEFT:
					//_offsetX = -5;
					_offsetX -= 5;
					break;
				
				case Keyboard.RIGHT:
					//_offsetX = 5;
					_offsetX += 5;
					break;
				
				case Keyboard.UP:
					//_offsetY = -5;
					_offsetY -= 5;
					break;
				
				case Keyboard.DOWN:
					//_offsetX = 5;
					_offsetY += 5;
					break;
			}
			
			/*_cube.incrementPoints('x', _offsetX);
			 _cube.incrementPoints('y', _offsetY);*/
			_cube.setCenterPoint(_offsetX, _offsetY, 0);
		}
		
		override protected function loop(e:Event):void
		{
			var angleX:Number = (mouseY - vanishingPointY) * .0005;
			var angleY:Number = (mouseX - vanishingPointX) * .0005;
			_cube.rotatePointsX(angleX);
			_cube.rotatePointsY(angleY);
			//Breakpoint
			//depthSort();
			render();
		}
	}
}