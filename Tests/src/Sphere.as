package
{
	import com.arcticcode.greenFlames.ThreeDee.CreateCircle3D;
	import com.arcticcode.greenFlames.ThreeDee.ThreeDeeUtils;
	import com.arcticcode.greenFlames.ThreeDee.geom.SpherePoints;
	import com.arcticcode.greenFlames.components.MemFpsCount;
	import com.arcticcode.greenFlames.graphics.ColourUtils;
	import com.bit101.components.HUISlider;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	[SWF(width=700,height=600,backgroundColor=0xFFFFFF)]
	public class Sphere extends Sprite
	{
		private var points:Array;
		private var viewX:Number = stage.stageWidth * 0.5;
		private var viewY:Number = stage.stageHeight * 0.5;
		private var colours:Array=new Array();
		private var circles:Array = new Array();
		private var numPoints:uint = 50;
		private var radius:Number = 50;
		private var radSlider:HUISlider;
		private var numSlider:HUISlider;
		private var pointRadius:Number=2;
		private var pradSlider:HUISlider;
		
		public function Sphere()
		{
			init();
		}
		private function init():void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			radSlider = new HUISlider(this,5,30,"Radius: ",onSlide);
			radSlider.maximum = 250;
			radSlider.minimum = -250;
			radSlider.setSize(300,16);
			radSlider.value = radius;
			numSlider = new HUISlider(this,5,50,"Number of points: ",onSlide);
			numSlider.maximum = 1000;
			numSlider.minimum = 5;
			numSlider.setSize(300,16);
			numSlider.value = numPoints;
			pradSlider = new HUISlider(this,5,70,"Point radius: ", onSlide);
			pradSlider.maximum = 10;
			pradSlider.minimum = 0.5;
			pradSlider.value = pointRadius;
			pradSlider.setSize(300,16);
			
			var _fm:MemFpsCount = new MemFpsCount();
			addChild(_fm);
			
			points = SpherePoints.plot(1000,radius);
			
			for(var i:uint=0;i<1000;i++)
			{
				colours.push(ColourUtils.getRanColor());
				points[i].setVanishingPoint(viewX,viewY);
			}
			
			render();
		}
		private function onSlide(e:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			radius = radSlider.value;
			numPoints = numSlider.value;
			pointRadius = pradSlider.value;
			
			//pradSlider.label = "Point Rad
			
			render();
		}
		private function render():void
		{
			//removeEventListener(Event.ENTER_FRAME,onEnterFrame);
			
			if(points!=null)
			{
				for(var j:uint = 0;j<circles.length;j++)
				{
					circles[j].parent.removeChild(circles[j]);
				}
				//points.splice(0,points.length);
				circles.splice(0,circles.length);
			}
			
			points = SpherePoints.plot(numPoints,radius);
			
			for(var i:uint=0;i<numPoints;i++)
			{
				var c:CreateCircle3D = new CreateCircle3D(pointRadius,0,colours[i],1,points[i].x,points[i].y,points[i].z);
				circles.push(c);
				addChild(c);		
			}
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(e:Event):void
		{
			var angleX:Number = (mouseY - viewY) * .0005;
			var angleY:Number = (mouseX - viewX) * .0005;
			graphics.clear();
			for(var i:uint=0;i<points.length;i++)
			{
				points[i].rotateX(angleX);
				points[i].rotateY(angleY);
				
				circles[i].xpos = points[i].x;
				circles[i].ypos = points[i].y;
				circles[i].zpos = points[i].z;
				ThreeDeeUtils.renderObject(circles[i],250,viewX,viewY);
			}
						
			ThreeDeeUtils.SortZ("zpos",circles,true);
			ThreeDeeUtils.SortZ("z",points,false);
			//graphics.clear();
			//graphics.lineStyle(0,colours[0]);
			//graphics.moveTo(viewX,viewY);
			//graphics.moveTo(points[0].screenX,points[0].screenY);
			/*for(i=0;i<points.length;i++)
			{
				graphics.lineStyle(0,colours[i]);
				graphics.beginFill(colours[i],1);
				graphics.drawCircle(points[i].screenX,points[i].screenY,3);
				graphics.endFill();
				//graphics.lineTo(points[i].screenX, points[i].screenY);
				//graphics.moveTo(viewX,viewY);
			}*/
		}
	}
}