package AdvancedPhysics
{
	import flash.display.Graphics;
	import flash.geom.Rectangle;

	public class VerletSquare
	{
		private var _constraints:Rectangle;
		public var _points:Vector.<VerletPoint> = new Vector.<VerletPoint>();
		public var _sticks:Vector.<VerletStick> = new Vector.<VerletStick>();
		
		public function VerletSquare(pointA:VerletPoint, pointB:VerletPoint, pointC:VerletPoint, pointD:VerletPoint,
									 constraints:Rectangle)
		{
			Verlet.makePoint(pointA.x, pointA.y, _points);
			Verlet.makePoint(pointB.x, pointB.y, _points);
			Verlet.makePoint(pointC.x, pointC.y, _points);
			Verlet.makePoint(pointD.x, pointD.y, _points);
			
			_constraints = constraints;
			
			Verlet.makeStick(_points[0], _points[1], -1, _sticks);
			Verlet.makeStick(_points[1], _points[2], -1, _sticks); 
			Verlet.makeStick(_points[2], _points[3], -1, _sticks); 
			Verlet.makeStick(_points[3], _points[0], -1, _sticks); 
			Verlet.makeStick(_points[0], _points[2], -1, _sticks);  
			Verlet.makeStick(_points[1], _points[3], -1, _sticks);
		}
		public function update(g:Graphics, velocities:Vector.<Object>=null):void
		{
			Verlet.updatePoints(_points, velocities);
			
			for(var i:int=0;i<1;i++)
			{
				Verlet.constrainPoints(_points, _constraints);
				Verlet.updateSticks(_sticks);
			}
			
			g.clear();
			Verlet.renderPoints(_points, g);
			Verlet.renderSticks(_sticks, g);
		}
	}
}