package com.tests
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import org.fly3D.display.BasicScene;
	import org.fly3D.display.BasicShape3D;
	import org.fly3D.display.graphics.GraphicsOptions;
	import org.fly3D.geom.Light;
	import org.fly3D.geom.Point3D;
	
	public class Cylinder extends BasicScene
	{
		private var _light:Light = new Light();
		private var _cylinder:BasicShape3D;
		private var _go:GraphicsOptions;
		private var _numFaces:uint = 10;
		private var _radius:Number = 300;
		
		public function Cylinder(w:Number, h:Number)
		{
			super(w * 0.5, h * 0.5);
			
			_cylinder = new BasicShape3D();
			_cylinder.move(0, 0, 0);
			add3DShape(_cylinder);
			
			_go = new GraphicsOptions(_cylinder.graphics);
			_go.fill = true;
			_go.fillAlpha = 0.5;
			_go.fillColour = 0x6666cc;
			_go.type = GraphicsOptions.SOLID_COLOR;
			
			_go.line = true;
			_go.lineAlpha = 0.5;
			_go.lineColour = 0;
			_go.lineThickness = 0;
			
			_cylinder.graphicsOptions = _go;
			
			for(var i:uint = 0; i < _numFaces; i++)
			{
				var angle:Number = Math.PI * 2 / _numFaces * i;
				var xpos:Number = Math.cos(angle) * _radius;
				var ypos:Number = Math.sin(angle) * _radius;
				_cylinder.addPoint(new Point3D(xpos, ypos, 100));
				_cylinder.addPoint(new Point3D(xpos, ypos, -100));
			}
			
			_cylinder.rotatePointsX(90);
			_cylinder.light = _light;
			_cylinder.setCenterPoint(0, 0, 200);
			
			var index:uint = 0;
			var buildArr:Array = new Array();
			for(i = 0; i < _numFaces - 1; i++)
			{
				buildArr.push([index, index + 3, index + 1], [index, index + 2, index + 3]);
				
				index += 2;
			}
			
			buildArr.push([index, 1, index + 1], [index, 0, 1]);
			
			_cylinder.buildTriangles(buildArr);
			
			
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			e.target.removeEventListener(e.type, arguments.callee);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function keyDown(e:KeyboardEvent):void
		{
			var i:uint = 0;
			
			if(e.keyCode == 76)
			{
				_go.line = !_go.line;
			}
			else if(e.keyCode == 68)
			{
				for(i = 0; i < _cylinder.numTriangles; i++)
				{
					_cylinder.triangles[i].doubleSided = !_cylinder.triangles[i].doubleSided;
				}
			}
		}
		
		private function loop(e:Event):void
		{
			var angleX:Number = (mouseY - vanishingPointY) * .0001;
			var angleY:Number = (mouseX - vanishingPointX) * .0001;
			_cylinder.rotatePointsX(angleX);
			_cylinder.rotatePointsY(angleY);
			render();
		}
	}
}