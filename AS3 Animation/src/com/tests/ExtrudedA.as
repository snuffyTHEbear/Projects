package com.tests
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import org.fly3D.display.BasicScene;
	import org.fly3D.display.BasicShape3D;
	import org.fly3D.display.graphics.GraphicsOptions;
	import org.fly3D.geom.Light;
	
	public class ExtrudedA extends BasicScene
	{
		private var _go:GraphicsOptions;
		
		private var _extrudedA:BasicShape3D;
		
		private var _light:Light = new Light(-50, 0, 10, 1, 0xFFFFFF);
		
		public function ExtrudedA(w:Number, h:Number)
		{
			super(w * 0.5, h * 0.5, 250);
			
			_extrudedA = new BasicShape3D(_light);
			_extrudedA.move(0, 0, 0);
			add3DShape(_extrudedA);
			
			_go = new GraphicsOptions(_extrudedA.graphics);
			_go.line = true;
			_go.lineAlpha = 1.0;
			_go.lineColour = 0x000000;
			_go.lineThickness = 0;
			_go.fill = true;
			_go.fillAlpha = 1.0;
			_go.type = GraphicsOptions.FACES;
			_extrudedA.graphicsOptions = _go;
			
			_extrudedA.addPoints([[-50, -250, -25], [50, -250, -25], [200, 250, -25], [100, 250, -25], [50, 100, -25], [-50, 100, -25], [-100, 250, -25], [-200, 250, -25], [0, -150, -25], [50, 0, -25],
								  [-50, 0, -25], [-50, -250, 25], [50, -250, 25], [200, 250, 25], [100, 250, 25], [50, 100, 25], [-50, 100, 25], [-100, 250, 25], [-200, 250, 25], [0, -150, 25], [50, 0,25], [-50,0,25]]);
			
			_extrudedA.buildTriangles([[0, 1, 8], [1, 9, 8], [1, 2, 9], [2, 4, 9], [2, 3, 4], [4, 5, 9], [9, 5, 10], [5, 6, 7], [5, 7, 10], [0, 10, 7], [0, 8, 10], [11, 19, 12], [12, 19, 20], [12, 20, 13], [13,20,15],
									   [13, 15, 14], [15, 20, 16], [20, 21, 16], [16, 18, 17], [16, 21, 18], [11, 18, 21], [11, 21, 19], [0, 11, 1], [11, 12, 1], [1, 12, 2], [12, 13, 2], [3, 2, 14], [2,13,14],
									   [4, 3, 15], [3, 14, 15], [5, 4, 16], [4, 15, 16], [6, 5, 17], [5, 16, 17], [7, 6, 18], [6, 17, 18], [0, 7, 11], [7, 18, 11], [8, 9, 19], [9, 20, 19], [9, 10, 20],[10, 21, 20], [10, 8, 21], [8, 19, 21]]);
			
			_extrudedA.setCenterPoint(0, 0, 200);
			
			var cA:uint = 0x6666cc;
			var cB:uint = 0xcc6666;
			var cC:uint = 0xcccc66;
			var c:uint = cA;
			
			for(var i:uint = 0; i < _extrudedA.numTriangles; i++)
			{
				if(i == 11)
					c = cB;
				else if(i == 22)
					c = cC;
				_extrudedA.triangles[i].color = (cA + cB - cC * cC / cB) + i;
			}
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			e.target.removeEventListener(e.target, arguments.callee);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			startRendering();
		}
		
		private function keyDown(e:KeyboardEvent):void
		{
			if(e.keyCode == 76)
			{
				_go.line = !_go.line;
			}
		}
		
		override protected function loop(e:Event):void
		{
			var angleX:Number = (mouseY - vanishingPointY) * .0006;
			var angleY:Number = (mouseX - vanishingPointX) * .0006;
			_extrudedA.rotatePointsX(angleX);
			_extrudedA.rotatePointsY(angleY);
			render();
		}
	}
}