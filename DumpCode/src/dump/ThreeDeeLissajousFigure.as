package
{
	import com.arcticcode.greenFlames.math.MathUtils;
	import com.arcticcode.greenFlames.ThreeDee.geom.Point3D;
	import com.bit101.components.HUISlider;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	[SWF(width=600,height=400,backgroundColor=0xFFFFFF)]
	public class ThreeDeeLissajousFigure extends Sprite
	{
		private var viewX:Number = stage.stageWidth * 0.5;
		private var viewY:Number = stage.stageHeight * 0.5;
		private var points:Array;
		private var theta:Number = MathUtils.degreesToRadians(35);
		private var phi:Number = MathUtils.degreesToRadians(24);
		private var rep:Number = 50;
		private var r:Number = 100;
		private var r2:Number = 2;
		private var thetaSlider:HUISlider;
		private var phiSlider:HUISlider;
		private var repSlider:HUISlider;
		private var rSlider:HUISlider;
		private var r2Slider:HUISlider;
		private var paused:Boolean = false;
		private var _rotationX:Number = 0;
		private var _rotationY:Number = 0;
		private var rotXSlider:HUISlider;
		private var rotYSlider:HUISlider;
		private var _controlX:Number = 0;
		private var _controlY:Number = 0;
		private var colour:uint = Math.random() * 0xffffff;
		
		public function ThreeDeeLissajousFigure()
		{
			init();
		}
		private function init():void
		{
			thetaSlider = new HUISlider(this,5,5,"Theta",onSlide);
			thetaSlider.maximum = 10000;
			thetaSlider.minimum = 1;
			thetaSlider.setSize(600,16);
			thetaSlider.alpha = 0.75;
			thetaSlider.value = theta;
			phiSlider = new HUISlider(this,5,20,"Phi",onSlide);
			phiSlider.maximum = 10000;
			phiSlider.minimum = 1;
			phiSlider.setSize(600,16);
			phiSlider.alpha = 0.75;
			phiSlider.value = phi;
			repSlider = new HUISlider(this,5,35,"Rep",onSlide);
			repSlider.maximum = 60;
			repSlider.setSize(600,16);
			repSlider.alpha = 0.75;
			repSlider.minimum = 1;
			repSlider.value = rep;
			rSlider = new HUISlider(this,5,50,"R",onSlide);
			rSlider.maximum = 200;
			rSlider.minimum = 1;
			rSlider.setSize(600,16);
			rSlider.alpha = 0.75;
			rSlider.value = r;
			r2Slider = new HUISlider(this,5,65,"R2",onSlide);
			r2Slider.maximum = 12;
			r2Slider.minimum = 1;
			r2Slider.setSize(600,16);
			r2Slider.value = r2;
			r2Slider.alpha = 0.75;
			//
			rotXSlider = new HUISlider(this,5,80,"RotX",onSlide);
			rotXSlider.maximum = 360;
			rotXSlider.minimum = -360;
			rotXSlider.setSize(300,16);
			rotXSlider.alpha = 0.75;
			rotXSlider.value = _rotationX;
			rotYSlider = new HUISlider(this,305,80,"RotY",onSlide);
			rotYSlider.maximum = 360;
			rotYSlider.minimum = -360;
			rotYSlider.setSize(300,16);
			rotYSlider.alpha = 0.75;
			rotYSlider.value = _rotationY;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
			
			points = new Array();
			//lissajous(0,0,0);
			update();
		}
		private function lissajous(X:Number=0,Y:Number=0,Z:Number=0):void
		{
			var p:Point3D;
			for(var t:Number = 0;t<rep*Math.PI;t+=1)
			{
				var xPos:Number = r * Math.sin(theta*t) * Math.cos(phi*t)+X;
				var zPos:Number = r * Math.cos(theta*t)+Z;
				var yPos:Number = r * Math.sin(theta*t) * Math.sin(phi*t)+Y;
				p=new Point3D(xPos,yPos,zPos);
				p.setVanishingPoint(viewX,viewY);
				points.push(p);
			}
			
			for(t=0;t<rep*Math.PI;t+=1)
			{
				xPos = r2 * Math.sin(100*theta*t) * Math.cos(100*phi*t) + r * Math.sin(theta*t) * Math.cos(phi*t)+X;
				zPos = r2 * Math.cos(100*theta*t) + r * Math.cos(theta*t)+Z;
				yPos = r2 * Math.sin(100*theta*t) * Math.sin(100*phi*t) + r * Math.sin(theta*t) * Math.sin(phi*t)+Y;
				p=new Point3D(xPos,yPos,zPos);
				p.setVanishingPoint(viewX,viewY);
				points.push(p)
			}
			//addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onSlide(e:Event):void{
			update();
		}
		private function update():void
		{
			if(!paused)
			{
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
			points.splice(0,points.length);
			theta = MathUtils.degreesToRadians(Math.floor(thetaSlider.value));
			phi = MathUtils.degreesToRadians(Math.floor(phiSlider.value));
			rep = repSlider.value;
			r = rSlider.value;
			r2 = r2Slider.value;
			lissajous(0,0,0);
			if(!paused)
			{
				addEventListener(Event.ENTER_FRAME, onEnterFrame);
				
			}
			else
			{
				_rotationX = MathUtils.degreesToRadians(rotXSlider.value);
				_rotationY = MathUtils.degreesToRadians(rotYSlider.value);
				render();
			}
		}
		private function onKey(e:KeyboardEvent):void
		{
			if(e.charCode == 99)
			{
				colour = Math.random()*0xffffff;
				return;
			}
			if(!paused)
			{
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				//_rotationX = MathUtils.degreesToRadians(rotXSlider.value);
				//_rotationY = MathUtils.degreesToRadians(rotYSlider.value);
				rotXSlider.value = 0;
				rotYSlider.value = 0;
				paused = true;
			}
			else
			{
				addEventListener(Event.ENTER_FRAME, onEnterFrame);
				paused = false;
			}
		}
		private function onEnterFrame(e:Event):void
		{
			var angleX:Number = (mouseY - viewY) * .001;
			var angleY:Number = (mouseX - viewX) * .001;
			_rotationX = angleX;
			_rotationY = angleY;
			rotXSlider.value = MathUtils.radiansToDegrees(_rotationX);
			rotYSlider.value = MathUtils.radiansToDegrees(_rotationY);
			render();
		}
		private function render():void
		{
			for(var i:uint=0;i<points.length;i++)
			{
				points[i].rotateX(_rotationX);
				points[i].rotateY(_rotationY);
			}
			//ThreeDeeUtils.SortZ("z",points,false);
			//QuadBez3D.draw(this.graphics,points,colourInfo,false,false);
			graphics.clear();
			graphics.lineStyle(0,colour);
			graphics.moveTo(points[0].screenX,points[0].screenY);
			trace(points.length);
			var val:uint;
			for(i = 0;i < points.length-1;i++)
			{
				val = Math.floor(points.length/2)
				//graphics.lineTo(points[i].screenX,points[i].screenY);
				if(i==(val)||i==(val-1))
				{
					graphics.lineStyle(0,0xffffff,1);
					_controlX = (points[i].screenX + points[i + 1].screenX) / 2;
					_controlY = (points[i].screenY + points[i + 1].screenY) / 2;
					graphics.curveTo(points[i].screenX,points[i].screenY, _controlX, _controlY);
				}
				else 
				{
					graphics.lineStyle(0,colour);
					_controlX = (points[i].screenX + points[i + 1].screenX) / 2;
					_controlY = (points[i].screenY + points[i + 1].screenY) / 2;
					graphics.curveTo(points[i].screenX,points[i].screenY, _controlX, _controlY);
				}
			}
			
			/*
			graphics.clear();
			graphics.lineStyle(0,0,1);
			graphics.moveTo(points[0].screenX,points[0].screenY);
			for(i=1;i<points.length;i++)
			{
				graphics.lineTo(points[i].screenX,points[i].screenY);
			}
			*/
		}
	}
}