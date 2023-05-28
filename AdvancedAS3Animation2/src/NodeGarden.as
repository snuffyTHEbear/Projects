package
{
	import __AS3__.vec.Vector;
	
	import com.arcticcode.greenFlames.graphics.CreateCircle;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	[SWF(width=600,height=400,backgroundColor=0x000000)]
	public class NodeGarden extends Sprite
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;	
		private var particles:Vector.<DisplayObject>;
		private var numParticles:Number = 100;
		private var grid:CollisionGrid;
		private var minDist:Number = 50;
		private var springAmount:Number = .001;
		
		public function NodeGarden()
		{
			init();
		}
		private function init():void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			grid = new CollisionGrid(stage.stageWidth,stage.stageHeight,100);
			
			particles = new Vector.<DisplayObject>();
			for(var i:int=0;i<numParticles;i++)
			{
				var b:CreateCircle = new CreateCircle(3,true,false,0xffffff);
				b.move(Math.random()*stage.stageWidth,Math.random()*stage.stageHeight);
				b._object.vx = Math.random() * 6-3;
				b._object.vy = Math.random() * 6-3;
				addChild(b);
				particles.push(b);
			}
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		private function loop(e:Event):void
		{
			graphics.clear();
			for(var i:int=0;i<numParticles;i++)
			{
				var p:CreateCircle = particles[i] as CreateCircle;
				p.x += p._object.vx;
				p.y += p._object.vy;
				if(p.x>stage.stageWidth)
				{
					p.x = 0;
				}
				else if(p.x<0)
				{
					p.x = stage.stageWidth;
				}
				if(p.y > stage.stageHeight)
				{
					p.y = 0;
				}
				else if(p.y <0)
				{
					p.y = stage.stageHeight;
				}
			}
			
			grid.check(particles);
			var checks:Vector.<DisplayObject> = grid.checks;
			
			var numChecks:int = checks.length;
			
			for(i=0;i<numChecks-1;i+=2)
			{
				var partA:CreateCircle = checks[i] as CreateCircle;
				var partB:CreateCircle = checks[i+1] as CreateCircle;
				spring(partA,partB);
			}
		}
		private function spring(pa:CreateCircle,pb:CreateCircle):void
		{
			var dx:Number = pb.x-pa.x;
			var dy:Number = pb.y-pa.y;
			var dist:Number=Math.sqrt(dx*dx+dy*dy)
			if(dist < minDist)
			{
				graphics.lineStyle(1,0xffffff,1-dist/minDist);
				graphics.moveTo(pa.x,pa.y);
				graphics.lineTo(pb.x,pb.y);
				var ax:Number = dx *springAmount;
				var ay:Number = dy *springAmount;
				pa._object.vx += ax;
				pa._object.vy += ay;
				pb._object.vx -= ax;
				pb._object.vy -= ay;
			}
		}
	}
}