package{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	
	[SWF(backgroundColor="0x000000")]
	
	public class NodeGarden extends Sprite{
		
		private var particles:Array;
		private var numParticles:uint = 30;
		private var minDistance:Number = 100;
		private var springAmount:Number = .0025;
		
		public function NodeGarden(){
			init();
		}
		private function init():void{
			particles = new Array();
			for(var i:uint = 0; i < numParticles; i++)
			{
				var size:Number = Math.random()*5 +1;
				var particle:CreateCircle = new CreateCircle(size,size, 0xffffff);
				particle.x = Math.random() * stage.stageWidth;
				particle.y = Math.random() * stage.stageHeight;
				particle.vx = Math.random() * 6 - 3;
				particle.vy = Math.random() * 6 - 3;
				particle.mass = size;
				addChild(particle);
				particles.push(particle);
			}
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void{
			graphics.clear();
			for(var i:uint = 0; i< numParticles; i++)
			{
				var particle:CreateCircle = particles[i];
				particle.x += particle.vx;
				particle.y += particle.vy;
				if(particle.x > stage.stageWidth)
				{
					particle.x = 0;
				}
				else if(particle.x < 0)
				{
					particle.x = stage.stageWidth;
				}
				if(particle.y > stage.stageHeight)
				{
					particle.y = 0;
				}
				else if(particle.y < 0)
				{
					particle.y = stage.stageHeight;
				}
			}
			for(i = 0; i <numParticles - 1; i++)
			{
				var partA:CreateCircle = particles[i];
				for(var j:uint = i + 1;j<numParticles;j++)
				{
					var partB:CreateCircle = particles[j];
					spring(partA, partB);
				}
			}
		}
		private function spring(partA:CreateCircle, partB:CreateCircle):void{
			var dx:Number = partB.x - partA.x;
			var dy:Number = partB.y - partA.y;
			var distance:Number = Math.sqrt(dx*dx+dy*dy);
			if(distance < minDistance)
			{
				graphics.lineStyle(1, 0xffffff, 1 - distance/minDistance);
				graphics.moveTo(partA.x, partA.y);
				graphics.lineTo(partB.x, partB.y);
				var ax:Number = dx * springAmount;
				var ay:Number = dy * springAmount;
				partA.vx += ax / partA.mass;
				partA.vy += ay / partA.mass;
				partB.vx -= ax / partB.mass;
				partB.vy -= ay / partB.mass;
			}
		}
	}
}