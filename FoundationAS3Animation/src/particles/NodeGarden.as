package particles
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	public class NodeGarden extends Sprite
	{
		private var particlesVector:Vector.<Particle> = new Vector.<Particle>();
		private var numParticles:int;
		private var bounds:Rectangle;
		
		public function NodeGarden(particles:int = 40)
		{
			numParticles = particles;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void
		{
			bounds = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			
			for(var i:int = 0; i < numParticles; i++)
			{
				var p:Particle = new Particle(Math.random() * 10 + 2, 0x000000);
				p.moveToRandomStageCoordinates(stage);
				p.vx = Math.random() * 6 - 3;
				p.vy = Math.random() * 6 - 3;
				p.mass = p.radius;
				addChild(p);
				particlesVector.push(p);
			}
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(e:Event):void
		{
			graphics.clear();
			for(var i:int = 0; i < numParticles; i++)
			{
				particlesVector[i].applyVelocity();
				ParticlePhysics.checkWalls(particlesVector[i], bounds, "wrap");
			}
			for(i = 0; i < numParticles; i++)
			{
				for(var j:int = i + 1; j < numParticles; j++)
				{
					ParticlePhysics.spring(particlesVector[i], particlesVector[j], 100, 0.0025, true, graphics, 0x000000);
				}
			}
		}
	}
}