package AdvancedPhysics
{
	import flash.display.Graphics;
	import flash.geom.Rectangle;

	public class Verlet
	{
		public static const FORWARD:String = "forward";

		public static const REVERSE:String = "reverse";

		public static function linkPoints(points:Vector.<VerletPoint>, sticks:Vector.<VerletStick>, order:String = Verlet.FORWARD):void
		{
			var i:int = 0;

			if(order == Verlet.FORWARD)
			{
				for(i = 1; i < points.length; i++)
				{
					makeStick(points[i - 1], points[i], -1, sticks);
				}
				makeStick(points[i - 1], points[0], -1, sticks);
			}
			else
			{
				for(i = points.length - 2; i > 1; i--)
				{
					makeStick(points[i], points[i + 1], -1, sticks);
				}
			}
		}

		public static function completeUpdateRender(points:Vector.<VerletPoint>, sticks:Vector.<VerletStick>, constraints:Rectangle, g:Graphics, iterations:int = 1, velocities:Vector.<Object> = null):void
		{
			updatePoints(points, velocities);

			for(var i:int = 0; i < iterations; i++)
			{
				constrainPoints(points, constraints);
				updateSticks(sticks);
			}

			g.clear();
			renderPoints(points, g);
			renderSticks(sticks, g);
		}

		public static function makeConstraints(width:Number, height:Number):Rectangle
		{
			return new Rectangle(0, 0, width, height);
		}

		public static function makePoint(x:Number, y:Number, points:Vector.<VerletPoint> = null, type:String = VerletPoint.FREE):VerletPoint
		{
			var vp:VerletPoint = new VerletPoint(x, y, type);

			if(points != null)
				points.push(vp);
			return vp;
		}

		public static function makeStick(pointA:VerletPoint, pointB:VerletPoint, length:Number = -1, sticks:Vector.<VerletStick> = null):VerletStick
		{
			var vs:VerletStick = new VerletStick(pointA, pointB, length);

			if(sticks != null)
				sticks.push(vs);
			return vs;
		}

		//Use friction?
		public static function updatePoints(points:Vector.<VerletPoint>, velocities:Vector.<Object>):void
		{
			for(var i:int = 0; i < points.length; i++)
			{
				if(velocities != null)
				{
					points[i].x += velocities[i].x;
					points[i].y += velocities[i].y;
				}
				points[i].update();
			}
		}

		//Use bounce?
		public static function constrainPoints(points:Vector.<VerletPoint>, constraints:Rectangle):void
		{
			for(var i:int = 0; i < points.length; i++)
			{
				points[i].constrain(constraints);
			}
		}

		public static function updateSticks(sticks:Vector.<VerletStick>):void
		{
			for(var i:int = 0; i < sticks.length; i++)
			{
				sticks[i].update();
			}
		}

		public static function renderPoints(points:Vector.<VerletPoint>, g:Graphics):void
		{
			for(var i:int = 0; i < points.length; i++)
			{
				points[i].render(g);
			}
		}

		public static function renderSticks(sticks:Vector.<VerletStick>, g:Graphics):void
		{
			for(var i:int = 0; i < sticks.length; i++)
			{
				sticks[i].render(g);
			}
		}
	}
}