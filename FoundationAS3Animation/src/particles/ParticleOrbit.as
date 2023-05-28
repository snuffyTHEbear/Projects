package particles
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	public class ParticleOrbit extends Sprite
	{
		private var particlesVector:Vector.<Particle> = new Vector.<Particle>();
		private var bounds:Rectangle;
		
		public function ParticleOrbit()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void
		{
			bounds = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			
			var sun:Particle = new Particle(100, [0xcc0000, 0xcccccc]);
			sun.mass = 10000;
			sun.move(stage.stageWidth * 0.5, stage.stageHeight * 0.5);
			addChild(sun);
			particlesVector.push(sun);
			
			var planet:Particle = new Particle(10, [0x00cc00, 0xfcfcfc]);
			planet.mass = 1;
			planet.vy = 0.9;
			planet.vx = 0.2;
			planet.move(sun.x + 200, sun.y);
			addChild(planet);
			particlesVector.push(planet);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(e:Event):void
		{
			for(var i:int = 0; i < particlesVector.length; i++)
			{
				particlesVector[i].applyVelocity();
			}
			
			for(i = 0; i < particlesVector.length; i++)
			{
				for(var j:int = i + 1; j < particlesVector.length; j++)
				{
					ParticlePhysics.checkCollision(particlesVector[i], particlesVector[j]);
					ParticlePhysics.gravitate(particlesVector[i], particlesVector[j]);
				}
			}
		}
	}
}