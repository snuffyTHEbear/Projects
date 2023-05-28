package
{
	import com.arcticcode.greenFlames.isometric.math.IsoMath;
	
	import flash.events.Event;
	
	import org.papervision3d.core.geom.Particles;
	import org.papervision3d.core.geom.renderables.Particle;
	import org.papervision3d.materials.special.ParticleMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.view.BasicView;

	[SWF(width=700, height = 600, backgroundColor = 0x000000)]
	public class ParticleSystem extends BasicView
	{
		private var angle:Number = 0;
		private var cont:DisplayObject3D;
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;
		private var parts:Particles;
		private var points:Array;

		public function ParticleSystem()
		{
			super(640, 480, true, true);
			initPoints();
			init();
		}

		private function initPoints():void
		{
			points = new Array();
			for (var i:Number = -70; i < 70; i += 1.87)
			{
				for (var j:Number = -15; j < 15; j += 2.7)
				{
					points.push({x:IsoMath.xFlash(i * 10, 0, j * 10, angle, 0),
									y:IsoMath.yFlash(i * 10, 0, j * 10, angle, 0),
									z:(i / j) * 10});
				}
			}
			points.splice(0,2);
		}

		private function init():void
		{
			cont = new DisplayObject3D();
			scene.addChild(cont);

			parts = new Particles("Particles");
			cont.addChild(parts);

			var pm:ParticleMaterial = new ParticleMaterial(0xffffff, 1, 0, 1);
			for (var i:uint = points.length - 1; i > 0; i--)
			{
				var m:ParticleMaterial = new ParticleMaterial((i) * 1000000, 1, 0, 2);
				var p:Particle = new Particle(m, 2);
				p.x = points[i].x;
				p.y = points[i].y;
				p.z = points[i].z;
				parts.addParticle(p);

			}
			
			trace(points.length,parts.particles.length);

			addEventListener(Event.ENTER_FRAME, onRenderTick);
		}

		override protected function onRenderTick(event:Event=null):void
		{
			super.onRenderTick(event);

			for (var i:uint = parts.particles.length - 1; i > 0; i--)
			{
				points[i].x += 0.5;
				points[i].y -= 0.5;
				points[i].z += 0.3;
				var p:Particle = parts.particles[i];
				//trace(p);
				p.x = points[i].x;
				p.y = points[i].y;
				p.z = points[i].z;
			}

			//cont.rotationX += (centreY - mouseY) * 0.01;
			//cont.rotationY -= (centreX - mouseX) * 0.01;
		}
	}
}