package
{
	import com.arcticcode.greenFlames.math.MathUtils;
	import com.arcticcode.greenFlames.sound.objects.AudioObject;
	import com.bit101.components.CheckBox;
	
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import org.papervision3d.core.geom.Particles;
	import org.papervision3d.core.geom.renderables.Particle;
	import org.papervision3d.materials.special.ParticleMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.view.BasicView;
	
	[SWF(width=640, height = 480, backgroundColor = 0x000000)]
	public class Corona3D extends BasicView
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;
		private var w:Number = stage.stageWidth;
		private var h:Number = stage.stageHeight;
		private var scale:Number = 0;
		private var cont:DisplayObject3D;
		private var particles:Particles;
		private var audio:AudioObject = new AudioObject();
		[Embed(source="assets/max.mp3", mimeType = "audio/mpeg")]
		private var audioFile:Class;
		private var sound:Sound;
		private var channel:SoundChannel;
		private var averagePeak:Number;
		private var radius:Number=200;
		
		private const SIN:String = "sin";
		private const COS:String = "cos";
		private const TAN:String = "tan";
		
		private var toggleA:CheckBox = new CheckBox(stage, 5, 5, COS, toggle_Handler);
		private var toggleB:CheckBox = new CheckBox(stage, 5, 30, SIN, toggle_Handler);
		private var toggleC:CheckBox = new CheckBox(stage, 5, 55, SIN, toggle_Handler);
		private var toggleD:CheckBox = new CheckBox(stage, 5, 80, SIN, toggle_Handler);
		private var toggleE:CheckBox = new CheckBox(stage, 5, 105, COS, toggle_Handler);
		
		
		public function Corona3D()
		{
			super(640, 480, true, true);
			
			trace();
			
			init();
		}
		
		private function calculate(type:String, val:Number):Number
		{
			var _val:Number = 0;
			if(type == SIN)
			{
				_val = Math.sin(val);
			}
			else if(type == COS)
			{
				_val = Math.cos(val);
			}
			else if(type == TAN)
			{
				_val = Math.tan(val) / 10;
			}
			return _val;
		}
		
		private function init():void
		{
			setUp();
			initSound();
			addEventListener(Event.ENTER_FRAME, onRenderTick);
		}
		
		private function initSound():void
		{
			sound = new audioFile();
			channel = sound.play();
		}
		
		private function toggle_Handler(e:Event):void
		{
			if(e.target.label == SIN)
			{
				e.target.label = COS;
			}
			else if(e.target.label == COS)
			{
				e.target.label = TAN;
			}
			else if(e.target.label == TAN)
			{
				e.target.label = SIN;
			}
			e.target.selected = false;
		}
		
		private function setUp():void
		{
			cont = new DisplayObject3D();
			scene.addChild(cont);
			cont.z -= 100;
			
			particles = new Particles();
			cont.addChild(particles);
			
			var pm:ParticleMaterial = new ParticleMaterial(0xffffff, 1, 0, 1);
			var phi:Number;
			var theta:Number;
			
			for (var i:uint = 0; i < 256; i++)
			{
				phi = Math.acos(-1 + (2 * i - 1) / 256);
				theta = Math.sqrt(256 * Math.PI) * phi;
				var p:Particle = new Particle(pm, 5, 0, 0, 0);
				p.x = radius * calculate(toggleA.label,theta) * calculate(toggleB.label,phi);
				p.y = radius * calculate(toggleC.label,theta) * calculate(toggleD.label,phi);
				p.z = radius * calculate(toggleE.label,phi);
				
				particles.addParticle(p);
			}
		}
		
		override protected function onRenderTick(event:Event=null):void
		{
			averagePeak = (channel.leftPeak + channel.rightPeak) / 2;
			averagePeak *= 500;
			radius = 250;
			if (radius > 300)
			{
				radius = 300;
			}
			else if (radius < 50)
			{
				radius = 50;
			}
			
			audio.tick();
			var angle:Number;
			var rawAv:Number = audio.rawAverage[0];
			var theta:Number;
			var phi:Number;
			
			for (var i:uint = 0; i < particles.particles.length; i++)
			{
				phi = Math.acos(-1 + (2 * i - 1) / 256);
				theta = Math.sqrt(256 * Math.PI) * phi;
				rawAv = audio.rawAverage[i];
				angle = i * 2 * Math.PI / 255;
				/* cont.graphics.drawRect(centreX + Math.cos(angle) * (radius * (1 + scale) + rawAv * w * 0.1),
				centreY + Math.sin(angle) * (radius * (1 + scale) + rawAv * h * 0.1),
				(averagePeak / 500)*8,(averagePeak/500)*8); */
				var p:Particle = particles.particles[i];
				//p.x = Math.cos(angle) * (radius * (1 + scale) + rawAv * w * 0.1);
				//p.y = Math.sin(angle) * (radius * (1 + scale) + rawAv * h * 0.1);
				/* p.x = (rawAv*50) + radius * Math.cos(theta) * Math.sin(phi);
				p.y = (rawAv*50) + radius * Math.sin(theta) * Math.sin(phi);
				p.z = (rawAv*50) + radius * Math.cos(phi); */
				p.x = (rawAv*50) + radius * calculate(toggleA.label,theta) * calculate(toggleB.label,phi);
				p.y = (rawAv*50) + radius * calculate(toggleC.label,theta) * calculate(toggleD.label,phi);
				p.z = (rawAv*50) + radius * calculate(toggleE.label,phi);
				//p.z = -averagePeak;
			}
			
			cont.rotationX += 1.37;
			cont.rotationY += -1.37;
			//cont.rotationZ += 1.12;
			//cont.z = -averagePeak;
			//cont.rotationX += (centreY - mouseY) * 0.01;
			//cont.rotationY += (centreX - mouseX) * 0.01;
			renderer.renderScene(scene, camera, viewport);
		}
	}
}