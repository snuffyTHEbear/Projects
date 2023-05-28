package
{
	import com.arcticcode.greenFlames.geom.Vector2D;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class PathTest extends BasicStage
	{
		private var path:Array;
		private var v:SteeredVehicle;
		
		public function PathTest()
		{
			init();
		}
		private function init():void
		{
			path = new Array();
			v = new SteeredVehicle();
			addChild(v);
			
			stage.addEventListener(MouseEvent.CLICK, onClick);
			addEventListener(Event.ENTER_FRAME, loop);
		}
		private function onClick(e:MouseEvent):void
		{
			graphics.lineStyle(0,0,0.25);
			if(path.length == 0)
			{
				graphics.moveTo(mouseX,mouseY);
			}
			graphics.lineTo(mouseX,mouseY);
			graphics.drawCircle(mouseX,mouseY,10);
			graphics.moveTo(mouseX,mouseY);
			path.push(new Vector2D(mouseX,mouseY));
		}
		private function loop(e:Event):void
		{
			v.followPath(path,true);
			v.update();
		}
	}
}