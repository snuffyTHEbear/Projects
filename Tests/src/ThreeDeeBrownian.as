package
{
	import com.arcticcode.greenFlames.ThreeDee.geom.Point3D;
	import com.arcticcode.greenFlames.components.MemFpsCount;
	import com.arcticcode.greenFlames.graphics.Curves.QuadBez3D;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Timer;
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class ThreeDeeBrownian extends Sprite
	{
		private var viewX:Number = stage.stageWidth * 0.5;
		private var viewY:Number = stage.stageHeight * 0.5;
		private var points:Array;
		private var timer:Timer = new Timer(500);
		private var point:Point3D;
		private var _fm:MemFpsCount;
		private var colourInfo:Object = {lineColour:0,lineAlpha:1,thickness:3,line2Colour:0xffffff};
		
		public function ThreeDeeBrownian()
		{
			init();
		}
		private function init():void
		{
			_fm = new MemFpsCount();
			_fm.autoUpdate = false;
			addChild(_fm);
			
			points = new Array();
			
			point = new Point3D();
			
			var p:Point3D = new Point3D(point.x,point.y,point.z);
			p.setVanishingPoint(viewX,viewY);
			points.push(p);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(e:Event):void
		{
			point.x += Math.random()*50-25;
			point.y += Math.random()*50-25;
			point.z += Math.random()*5-2.5;
			var p:Point3D = new Point3D(point.x,point.y,point.z);
			p.setVanishingPoint(viewX,viewY);
			points.push(p);
			
			var angleX:Number = (mouseY - viewY) * .001;
			var angleY:Number = (mouseX - viewX) * .001;
			
			point.rotateX(angleX);
			point.rotateY(angleY);
			
			for(var i:uint=0;i<points.length;i++)
			{
				points[i].rotateX(angleX);
				points[i].rotateY(angleY);
			}
			/*
			graphics.clear();
			graphics.lineStyle(0,0);
			graphics.moveTo(points[0].screenX,points[0].screenY);
			for(i=1;i<points.length;i++)
			{
				graphics.lineTo(points[i].screenX,points[i].screenY);
			}
			*/
			QuadBez3D.draw(this.graphics,points,colourInfo,false);
			if(points.length>=500)
			{
				points.splice(0,points.length);
				point.x = point.y = point.z = 0;
				var _p:Point3D = new Point3D(point.x,point.y,point.z);
				_p.setVanishingPoint(viewX,viewY);
				points.push(_p);
			}
			_fm.calculate();
		}
	}
}