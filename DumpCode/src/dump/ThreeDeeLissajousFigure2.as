package
{
	import com.arcticcode.greenFlames.math.MathUtils;
	import com.arcticcode.greenFlames.ThreeDee.CreateCircle3D;
	import com.arcticcode.greenFlames.ThreeDee.ThreeDeeUtils;
	import com.arcticcode.greenFlames.ThreeDee.geom.Point3D;
	import com.arcticcode.greenFlames.graphics.ColourUtils;
	import com.bit101.components.HUISlider;
	
	import flash.display.Sprite;
	import flash.events.Event;
	[SWF(width=600,height=400,backgroundColor=0xFFFFFF)]
	public class ThreeDeeLissajousFigure2 extends Sprite
	{
		private var viewX:Number = stage.stageWidth * 0.5;
		private var viewY:Number = stage.stageHeight * 0.5;
		private var points:Array;
		private var theta:Number = MathUtils.degreesToRadians(35);
		private var phi:Number = MathUtils.degreesToRadians(24);
		private var rep:Number = 50;
		private var r:Number = 100;
		private var r2:Number = 2;
		private var colourInfo:Object = {lineColour:0,lineAlpha:1,thickness:3,line2Colour:0xffffff};
		private var thetaSlider:HUISlider;
		private var phiSlider:HUISlider;
		private var repSlider:HUISlider;
		private var rSlider:HUISlider;
		private var r2Slider:HUISlider;
		private var colours:Array=new Array();
		private var circles:Array = new Array();
		
		public function ThreeDeeLissajousFigure2()
		{
			trace(5*.001);
			init();
		}
		private function init():void
		{
			thetaSlider = new HUISlider(this,5,5,"Theta",onSlide);
			thetaSlider.maximum = 1000;
			thetaSlider.minimum = 1;
			thetaSlider.setSize(600,16);
			thetaSlider.alpha = 0.75;
			thetaSlider.value = theta;
			phiSlider = new HUISlider(this,5,20,"Phi",onSlide);
			phiSlider.maximum = 1000;
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
			
			for(var i:uint=0;i<5000;i++)
			{
				colours.push(ColourUtils.getRanColor());
				//points[i].setVanishingPoint(viewX,viewY);
			}
			circles = new Array();
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
		private function onSlide(e:Event):void
		{
			update();
		}
		private function update():void
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			if(points!=null)
			{
				for(var j:uint = 0;j<circles.length;j++)
				{
					circles[j].parent.removeChild(circles[j]);
				}
				//points.splice(0,points.length);
				circles.splice(0,circles.length);
			}
			
			points.splice(0,points.length);
			points = null;
			points = new Array();
			
			theta = MathUtils.degreesToRadians(Math.floor(thetaSlider.value));
			phi = MathUtils.degreesToRadians(Math.floor(phiSlider.value));
			rep = repSlider.value;
			r = rSlider.value;
			r2 = r2Slider.value;
			lissajous(0,0,0);
			
			for(var i:uint=0;i<points.length;i++)
			{
				var c:CreateCircle3D = new CreateCircle3D(3,0,colours[i],1,points[i].x,points[i].y,points[i].z);
				circles.push(c);
				addChild(c);		
			}
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(e:Event):void
		{
			//var angleX:Number = (mouseY - viewY) * .001;
			//var angleY:Number = (mouseX - viewX) * .001;
			//var angleX:Number = 5 * .001;
			//var angleY:Number = 5 * .001;
			for(var i:uint=0;i<points.length;i++)
			{
				points[i].rotateX(.005);
				points[i].rotateY(.005);
				circles[i].xpos = points[i].x;
				circles[i].ypos = points[i].y;
				circles[i].zpos = points[i].z;
				ThreeDeeUtils.renderObject(circles[i],250,viewX,viewY);
			}
						
			ThreeDeeUtils.SortZ("zpos",circles,true);
			ThreeDeeUtils.SortZ("z",points,false);
			
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
	}
}