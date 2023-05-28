package
{
	import com.arcticcode.greenFlames.ThreeDee.ThreeDeeUtils;
	import com.arcticcode.greenFlames.ThreeDee.geom.SpherePoints;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	[SWF(width=600,height=400,backgroundColor=0xFFFFFF)]
	public class SphereModel extends Sprite
	{
		private var points:Array;
		private var viewX:Number = stage.stageWidth * 0.5;
		private var viewY:Number = stage.stageHeight * 0.5;
		
		public function SphereModel()
		{
			init();
		}
		private function init():void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			points = SpherePoints.plot(5,50);
			
			for(var i:uint=0;i<points.length;i++)
			{
				points[i].setVanishingPoint(viewX,viewY);
			}
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(e:Event):void
		{
			var angleX:Number = (mouseY - viewY) * .0005;
			var angleY:Number = (mouseX - viewX) * .0005;
			graphics.clear();
			graphics.lineStyle(1,0);
			//graphics.moveTo(viewX,viewY);
			graphics.moveTo(points[0].screenX,points[0].screenY);
			for(var i:uint=0;i<points.length;i++)
			{
				points[i].rotateX(angleX);
				points[i].rotateY(angleY);
				graphics.lineTo(points[i].screenX,points[i].screenY);
				//graphics.moveTo(viewX,viewY);
			}
			//graphics.lineTo(points[points.length-1].screenX,points[points.length-1].screenY);
			
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