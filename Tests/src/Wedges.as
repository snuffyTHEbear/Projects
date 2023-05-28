package
{
	import com.arcticcode.greenFlames.geom.LWPoint;
	import com.arcticcode.greenFlames.graphics.Wedge;
	import com.arcticcode.greenFlames.display.DisplayUtils;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width=600, height = 400, backgroundColor = 0xffffff)]
	public class Wedges extends Sprite
	{
		private var cont:Sprite;
		
		private var pa:LWPoint;
		
		private var pb:LWPoint;
		
		private var centreX:Number = stage.stageWidth * 0.5;
		
		private var centreY:Number = stage.stageHeight * 0.5;
		
		private var arc:Number = 0;
		
		public function Wedges()
		{
			init();
		}
		
		private function init():void
		{
			cont = new Sprite();
			DisplayUtils.doCentreOne(cont, stage.stageWidth, stage.stageHeight);
			addChild(cont);
			cont.graphics.beginFill(Math.random() * 0xffffff);
			Wedge.draw(cont.graphics, 0, 0, 100, 45);
			cont.graphics.endFill();
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void
		{
			cont.graphics.clear();
			//cont.graphics.lineStyle(1,0);
			cont.graphics.beginFill(0xf76bca);
			Wedge.draw(cont.graphics, 0, 0, 100, arc);
			cont.graphics.endFill();
			arc += 5;
			arc >= 360 ? arc = -360 : null;
		}
	}
}