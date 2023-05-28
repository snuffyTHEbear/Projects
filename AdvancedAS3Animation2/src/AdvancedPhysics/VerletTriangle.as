package AdvancedPhysics
{
	import flash.display.Graphics;
	import flash.geom.Rectangle;

	public class VerletTriangle
	{
		private var _pointA:VerletPoint;
		private var _pointB:VerletPoint;
		private var _pointC:VerletPoint;
		private var _stickA:VerletStick;
		private var _stickB:VerletStick;
		private var _stickC:VerletStick;
		private var _constraints:Rectangle;
		private var _inc:int = 0;
		public var iterations:int = 1;
		
		public function VerletTriangle(pointA:VerletPoint, pointB:VerletPoint, pointC:VerletPoint,
										constraints:Rectangle)
		{
			_pointA = pointA;
			_pointB = pointB;
			_pointC = pointC;
			_constraints = constraints;
			
			_stickA = new VerletStick(_pointA, _pointB);
			_stickB = new VerletStick(_pointB, _pointC);
			_stickC = new VerletStick(_pointC, _pointA);
		}
		public function update(g:Graphics, velocities:Vector.<Number>):void
		{
			_pointA.x += velocities[0];
			_pointA.y += velocities[1];
			_pointA.update();
			_pointB.x += velocities[2];
			_pointB.y += velocities[3];
			_pointB.update();
			_pointC.x += velocities[4];
			_pointC.y += velocities[5];
			_pointC.update();
			
			for(_inc = 0;_inc < iterations;_inc++)
			{
				_pointA.constrain(_constraints);
				_pointB.constrain(_constraints);
				_pointC.constrain(_constraints);
				_stickA.update();
				_stickB.update();
				_stickC.update();
			}
			
			g.clear();
			_pointA.render(g);
			_pointB.render(g);
			_pointC.render(g);
			_stickA.render(g);
			_stickB.render(g);
			_stickC.render(g);
		}
	}
}