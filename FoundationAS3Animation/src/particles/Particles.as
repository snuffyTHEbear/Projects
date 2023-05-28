package particles
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Particles extends Sprite
	{
		private var particlesVector:Vector.<Particle> = new Vector.<Particle>();
		
		private var numParticles:int;
		
		private var inc:int = 0;
		
		private var bounds:Rectangle;
		
		public function Particles(particles:int = 15)
		{
			numParticles = particles;
			
			addEventListener(Event.ADDED_TO_STAGE, init);;
		}
		
		private function init(e:Event):void
		{
			bounds = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			
			for(inc = 0; inc < numParticles; inc++)
			{
				var p:Particle = new Particle(Math.random() * 50 + 5);
				p.moveToRandomStageCoordinates(stage);
				p.mass = p.radius;
				p.vx = Math.random() * 7;
				p.vy = Math.random() * 4;
				addChild(p);
				particlesVector.push(p);
			}
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			for(inc = 0; inc < numParticles; inc++)
			{
				particlesVector[inc].applyVelocity();
				checkWalls(particlesVector[inc]);
			}
			
			for(var i:int = 0; i < numParticles - 1; i++)
			{
				var pA:Particle = particlesVector[i];
				
				for(var j:int = i + 1; j < numParticles; j++)
				{
					var pB:Particle = particlesVector[j];
					checkCollision(pA, pB);
					gravitate(pA, pB);
				}
			}
		}
		
		private function gravitate(partA:Particle, partB:Particle):void
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
		
		private function checkCollision(partA:Particle, partB:Particle):void
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
				var vel0F:Object = rotate(vel0.x, vel0.y, sin, cos, false);
				var vel1F:Object = rotate(vel1.x, vel1.y, sin, cos, false);
				partA.vx = vel0F.x;
				partA.vy = vel0F.y;
				partB.vx = vel1F.x;
				partB.vy = vel1F.y;
			}
		}
		
		private function rotate(x:Number, y:Number, sin:Number, cos:Number, reverse:Boolean):Point
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
		
		private function checkWalls(particle:Particle):void
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
	}
}