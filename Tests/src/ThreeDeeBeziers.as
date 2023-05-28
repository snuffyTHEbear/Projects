package
{
	import com.arcticcode.greenFlames.ThreeDee.geom.Point3D;
	import com.arcticcode.greenFlames.components.MemFpsCount;
	import com.arcticcode.greenFlames.graphics.Curves.QuadBez3D;
	
	import flash.display.Sprite;
	import flash.events.Event;
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class ThreeDeeBeziers extends Sprite
	{
		private var fl:Number = 250;
		private var viewX:Number = stage.stageWidth * 0.5;
		private var viewY:Number = stage.stageHeight * 0.5;
		private var points:Array;
		private var radius:Number = 100;
		private var angle:Number = 0;
		private var colourInfo:Object = {lineColour:0,lineAlpha:1,thickness:3,line2Colour:0xffffff};
		
		public function ThreeDeeBeziers()
		{
			init();
		}
		private function init():void
		{
			var _fmMB:MemFpsCount = new MemFpsCount(MemFpsCount.KBUNITS,MemFpsCount.KB);
			addChild(_fmMB);
			
			points = new Array();
			
			for(var i:int=-50;i<50;i++)
			{
				/*var p:Point3D = new Point3D(Math.random()*200-100,Math.random()*200-100,i);
				points.push(p);
				p.setVanishingPoint(viewX, viewY);*/
				var valX:Number = viewX + Math.cos(angle) * radius;
				var valY:Number = viewY + Math.sin(angle) * radius;
				var p:Point3D = new Point3D(viewX/2-valX/2,viewY/2-valY/2,i);
				p.setVanishingPoint(viewX,viewY);
				points.push(p);
				angle += 1;
			}
			QuadBez3D.draw(this.graphics,points,colourInfo,false);
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
			QuadBez3D.draw(this.graphics,points,colourInfo,false);
		}
	}
}