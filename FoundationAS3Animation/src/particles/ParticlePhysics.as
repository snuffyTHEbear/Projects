package particles
{
	import flash.display.Graphics;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class ParticlePhysics
	{
		public static const FRICTION:Number = 0.8;
		public static const SPRING:Number = 0.1;
		public static const GRAVITY:Number = 5;
		public static const BOUNCE:String = "bounce";
		public static const WRAP:String = "wrap";
		
		public static function gravitate(partA:Particle, partB:Particle):void
		{
			var dx:Number = partB.x - partA.x;
			var dy:Number = partB.y - partA.y;
			var distSQ:Number = dx * dx + dy * dy;
			var dist:Number = Math.sqrt(distSQ);
			var force:Number = partA.mass * partB.mass / distSQ;
			var ax:Number = force * dx / dist;
			var ay:Number = force * dy / dist;
			partA.vx += ax / partA.mass;
			partA.vy += ay / partA.mass;
			partB.vx -= ax / partB.mass;
			partB.vy -= ay / partB.mass;
		}
		
		public static function spring(partA:Particle, partB:Particle, minDistance:Number = 100, springAmount:Number = 0.001, drawSpring:Boolean = false, g:Graphics = null, lineColour:uint = 0xffffff, lineThickness:Number = 1):void
		{
			var dx:Number = partB.x - partA.x;
			var dy:Number = partB.y - partA.y;
			var dist:Number = Math.sqrt(dx * dx + dy * dy);
			if(dist < minDistance)
			{
				g.lineStyle(lineThickness, lineColour, 1 - dist / minDistance);
				g.moveTo(partA.x, partA.y);
				g.lineTo(partB.x, partB.y);
				var ax:Number = dx * springAmount;
				var ay:Number = dy * springAmount;
				partA.vx += ax / partA.mass;
				partA.vy += ay / partA.mass;
				partB.vx -= ax / partB.mass;
				partB.vy -= ay / partB.mass;
			}
		}
		
		public static function checkCollision(partA:Particle, partB:Particle):void
		{
			var dx:Number = partB.x - partA.x;
			var dy:Number = partB.y - partA.y;
			var dist:Number = Math.sqrt(dx * dx + dy * dy);
			
			if(dist < partA.radius + partB.radius)
			{
				// calculate angle, sine and cosine
				var angle:Number = Math.atan2(dy, dx);
				var sin:Number = Math.sin(angle);
				var cos:Number = Math.cos(angle);
				
				// rotate ball0's position
				var pos0:Point = new Point(0, 0);
				
				// rotate ball1's position
				var pos1:Point = rotate(dx, dy, sin, cos, true);
				
				// rotate ball0's velocity
				var vel0:Point = rotate(partA.vx, partA.vy, sin, cos, true);
				
				// rotate ball1's velocity
				var vel1:Point = rotate(partB.vx, partB.vy, sin, cos, true);
				
				//swap velocities - Same mass objects
				/*var temp:Point = vel0;
				vel0 = vel1;
				vel1 = temp;*/
				
				//collision reaction - Generic mass objects
				var vxTotal:Number = vel0.x - vel1.x;
				vel0.x = ((partA.mass - partB.mass) * vel0.x + 2 * partB.mass * vel1.x) / (partA.mass + partB.mass);
				vel1.x = vxTotal + vel0.x;
				
				// update position
				var absV:Number = Math.abs(vel0.x) + Math.abs(vel1.x);
				var overlap:Number = (partA.radius + partB.radius) - Math.abs(pos0.x - pos1.x);
				pos0.x += vel0.x / absV * overlap;
				pos1.x += vel1.x / absV * overlap;
				
				// rotate positions back
				var pos0F:Object = rotate(pos0.x, pos0.y, sin, cos, false);
				
				var pos1F:Object = rotate(pos1.x, pos1.y, sin, cos, false);
				
				// adjust positions to actual screen positions
				partB.x = partA.x + pos1F.x;
				partB.y = partA.y + pos1F.y;
				partA.x = partA.x + pos0F.x;
				partA.y = partA.y + pos0F.y;
				
				// rotate velocities back
				var vel0F:Point = rotate(vel0.x, vel0.y, sin, cos, false);
				var vel1F:Point = rotate(vel1.x, vel1.y, sin, cos, false);
				partA.vx = vel0F.x;
				partA.vy = vel0F.y;
				partB.vx = vel1F.x;
				partB.vy = vel1F.y;
			}
		}
		
		public static function rotate(x:Number, y:Number, sin:Number, cos:Number, reverse:Boolean):Point
		{
			var result:Point = new Point();
			
			if(reverse)
			{
				result.x = x * cos + y * sin;
				result.y = y * cos - x * sin;
			}
			else
			{
				result.x = x * cos - y * sin;
				result.y = y * cos + x * sin;
			}
			return result;
		}
		
		public static function checkWalls(particle:Particle, bounds:Rectangle, type:String = ParticlePhysics.BOUNCE):void
		{
			if(type == ParticlePhysics.BOUNCE)
			{
				if(particle.x + particle.radius  > bounds.right)
				{
					particle.x = bounds.right - particle.radius;
					particle.vx *= -1;
				}
				else if(particle.x - particle.radius < bounds.left)
				{
					particle.x = bounds.left + particle.radius;
					particle.vx *= -1;
				}
				if(particle.y + particle.radius > bounds.bottom)
				{
					particle.y = bounds.bottom - particle.radius;
					particle.vy *= -1;
				}
				else if(particle.y - particle.radius < bounds.top)
				{
					particle.y = bounds.top + particle.radius;
					particle.vy *= -1;
				}
			}
			else 
			{
				if(particle.x > bounds.right)
				{
					particle.x = 0;
				}
				else if(particle.x < 0)
				{
					particle.x = bounds.right;
				}
				if(particle.y > bounds.bottom)
				{
					particle.y = 0;
				}
				else if(particle.y < 0)
				{
					particle.y = bounds.bottom;
				}
			}
		}
	}
}