package
{
	import com.arcticcode.greenFlames.ThreeDee.geom.Point3D;
	import com.arcticcode.greenFlames.graphics.Curves.QuadBez3D;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	[SWF(width=600,height=400,backgroundColor=0xFFFFFF)]
	public class LorenzAttractor extends Sprite
	{
		private var h:Number = 0.01;
		private var cont:Shape;
		private var frac:Number = 8/3;
		private var viewX:Number = stage.stageWidth * 0.5;
		private var viewY:Number = stage.stageHeight * 0.5;
		private var points:Array;
		private var colourInfo:Object = {lineColour:0,lineAlpha:1,thickness:0,line2Colour:0xffffff};
		
		public function LorenzAttractor()
		{
			init();
		}
		private function init():void
		{
			points = new Array();
			
			//cont = new Shape();
			//DisplayUtils.doCentreOne(cont,stage.stageWidth,stage.stageHeight);
			//addChild(cont);
			lorenz();
		}
		private function lorenz(X:Number=0.6,Y:Number=0.6,Z:Number=0.6,numPoints:uint=1000):void
		{
			//cont.graphics.clear();
			//cont.graphics.lineStyle(0,0,1);
			for(var i:uint = 1;i<numPoints;i++)
			{
				var newX:Number = X + h * 10 *(Y-X);
				var newY:Number = Y + h * ((-X*Z) + 28 * X - Y);
				var newZ:Number = Z + h * (X*Y - frac*Z);
				X = newX;
				Y = newY;
				Z = newZ;
				var p:Point3D = new Point3D(newX,newY,newZ);
				p.setVanishingPoint(viewX,viewY);
				points.push(p);
				//cont.graphics.lineTo(newX,newY);
			}
			//QuadBez3D.draw(this.graphics,points,colourInfo,false,false);
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		private function onEnterFrame(e:Event):void
		{
			var angleX:Number = (mouseY - viewY) * .001;
			var angleY:Number = (mouseX - viewX) * .001;
			for(var i:uint=0;i<points.length;i++)
			{
				points[i].rotateX(angleX);
				points[i].rotateY(angleY);
			}
			//ThreeDeeUtils.SortZ("z",points,false);
			QuadBez3D.draw(this.graphics,points,colourInfo,false,false);
			
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