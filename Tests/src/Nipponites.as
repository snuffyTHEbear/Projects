package
{
	import com.arcticcode.greenFlames.ThreeDee.geom.Point3D;
	import com.arcticcode.greenFlames.graphics.Curves.QuadBez3D;
	import com.arcticcode.greenFlames.utils.DisplayUtils;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class Nipponites extends Sprite
	{
		private var alph:Number = .1;
		private var beta:Number = .1;
		private var eps:Number = .2;
		private var gam:Number = 3;
		private var f:Number = .3; 
		//
		private var bmd:BitmapData;
		private var b:Bitmap;
		private var cont:Sprite;
		private var viewX:Number = stage.stageWidth * 0.5;
		private var viewY:Number = stage.stageHeight * 0.5;
		private var points:Array;
		private var colourInfo:Object = {lineColour:0,lineAlpha:1,thickness:0,line2Colour:0xffffff};
		
		public function Nipponites()
		{
			init();
		}
		private function init():void
		{
			bmd = new BitmapData(stage.stageWidth,stage.stageHeight,false,0xffffff);
			b = new Bitmap(bmd);
			//addChild(b);
			
			cont = new Sprite();
			DisplayUtils.doCentreOne(cont, stage.stageWidth,stage.stageHeight);
			
			points = new Array();
			
			nipponite();
		}
		private function nipponite():void
		{
			cont.graphics.clear();
			cont.graphics.lineStyle(0,0,1);
			for(var theta:Number=-Math.PI;theta<(2*Math.PI);theta+=(Math.PI/30.1))
			{
				var X:Number = Math.exp(alph*theta)*(100+eps*Math.cos(2*gam*theta)) * Math.cos(theta-f*Math.sin(200*gam*theta));
				var Y:Number = Math.exp(alph*theta)*(100+eps*Math.cos(2*gam*theta)) * Math.sin(theta-f*Math.sin(200*gam*theta));
				var Z:Number = Math.exp(beta*theta)*Math.sin(2*gam*theta);
				var pc:Point3D = new Point3D(0,0,0);
				pc.setVanishingPoint(viewX,viewY);
				var p:Point3D = new Point3D(X,Y,Z);
				p.setVanishingPoint(viewX, viewY);
				points.push(pc);
				points.push(p);
				//cont.graphics.lineTo(X,Y);
				//bmd.draw(cont,cont.transform.matrix);
			}
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
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