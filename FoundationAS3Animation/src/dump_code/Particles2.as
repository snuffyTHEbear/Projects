package{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	[SWF(width="500", height="400")]
	public class Particles2 extends Sprite{
		
		private var particles:Array;
		private var numParticles:Number = 2;
		private var bounce:Number = -1.0;
		private var planet:CreateCircle;
		private var bmp:Bitmap;
		private var canvas:BitmapData;
		
		public function Particles2(){
			init();
		}
		private function init():void{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			particles = new Array();
			var sun:CreateCircle = new CreateCircle(0, 0xffff00);
			sun.x = stage.stageWidth / 2;
			sun.y = stage.stageHeight / 2;
			sun.mass = 10000;
			addChild(sun);
			particles.push(sun);
			
			planet = new CreateCircle(0, 0x00ff00);
			planet.x = stage.stageWidth / 2 + 200;
			planet.y = stage.stageWidth / 2;
			planet.vy = 7;
			planet.mass = 1;
			addChild(planet);
			particles.push(planet);
			
			graphics.lineStyle(1, 0x000000);
			graphics.moveTo(planet.x, planet.y);
			
			canvas = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0x00000000);
			bmp = new Bitmap(canvas);
			addChild(bmp);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void{
			canvas.setPixel32(planet.x, planet.y, 0xffff0000);
			//graphics.lineTo(planet.x, planet.y);
			for(var i:uint = 0; i< numParticles;i++)
			{
				var particle:CreateCircle = particles[i];
				particle.x += particle.vx;
				particle.y += particle.vy;
				//checkWalls(particle); 
			}
			for(i=0;i<numParticles-1;i++)
			{
				var partA:CreateCircle = particles[i];
				for(var j:uint = i + 1;j<numParticles;j++)
				{
					var partB:CreateCircle = particles[j];
					//checkCollision(partA, partB);
					gravitate(partA, partB);
				}
			}
		}
		private function gravitate(partA:CreateCircle, partB:CreateCircle):void{
			var dx:Number = partB.x - partA.x;
			var dy:Number = partB.y - partA.y;
			var distanceSQ:Number = dx * dx + dy * dy;
			var distance:Number = Math.sqrt(distanceSQ);
			var force:Number = partA.mass * partB.mass / distanceSQ;
			var ax:Number = force * dx / distance;
			var ay:Number = force * dy / distance;
			partA.vx += ax / partA.mass;
			partA.vy += ay / partA.mass;
			partB.vx -= ax / partB.mass;
			partB.vy -= ay / partB.mass;
		}
		private function checkWalls(particle:CreateCircle):void{
			if(particle.x + particle.radius > stage.stageWidth)
			{
				particle.x = stage.stageWidth - particle.radius;
				particle.vx *= bounce;
			}
			else if(particle.x - particle.radius < 0)
			{
				particle.x = particle.radius;
				particle.vx *= bounce;
			}
			if(particle.y + particle.radius > stage.stageHeight)
			{
				particle.y = stage.stageHeight - particle.radius;
				particle.vy *= bounce;
			}
			else if(particle.y - particle.radius < 0)
			{
				particle.y = particle.radius;
				particle.vy *= bounce;
			}
		}
		private function checkCollision(partA:CreateCircle, partB:CreateCircle):void{
			 var dx:Number = partB.x - partA.x;
			 var dy:Number = partB.y - partA.y;
			 var distance:Number = Math.sqrt(dx*dx+dy*dy);
			 if(distance < partA.radius + partB.radius)
			 {
			 	//calculate angle, sine and cosine
			 	var angle:Number = Math.atan2(dy, dx);
			 	var sin:Number = Math.sin(angle);
			 	var cos:Number = Math.cos(angle);
			 	//rotate partA's position
			 	var x0:Number = 0;
			 	var y0:Number = 0;
			 	//rotate partB's position
			 	var x1:Number = dx * cos + dy * sin;
			 	var y1:Number = dy * cos - dx * sin;
			 	//rotate partA's velocity
			 	var vx0:Number = partA.vx * cos + partA.vy * sin;
			 	var vy0:Number = partA.vy * cos - partA.vx * sin;
			 	//rotate partB's velocity
			 	var vx1:Number = partB.vx * cos + partB.vy * sin;
			 	var vy1:Number = partB.vy * cos - partB.vx * sin;
			 	//collision reaction
			 	var vxTotal:Number = vx0 - vx1;
			 	vx0 = ((partA.mass - partB.mass) * vx0 + 
			 			2 * partB.mass * vx1) / 
			 			(partA.mass + partB.mass);
			 	vx1 = vxTotal + vx0;
			 	x0 += vx0;
			 	x1 += vx1;
			 	//rotate positions back
			 	var x0Final:Number = x0 * cos - y0 * sin;
			 	var y0Final:Number = y0 * cos + x0 * sin;
			 	var x1Final:Number = x1 * cos - y1 * sin;
			 	var y1Final:Number = y1 * cos + x1 * sin;
			 	
			 	//adjust positions to actual screen positions
			 	partB.x = partA.x + x1Final;
			 	partB.y = partA.y + y1Final;
			 	partA.x = partA.x + x0Final;
			 	partA.y = partA.y + y0Final;
			 	
			 	//rotate velocities back
			 	partA.vx = vx0 * cos - vy0 * sin;
			 	partA.vy = vy0 * cos + vx0 * sin;
			 	partB.vx = vx1 * cos - vy1 * sin;
			 	partB.vy = vy1 * cos + vx1 * sin;
			 }
		}
	}
}