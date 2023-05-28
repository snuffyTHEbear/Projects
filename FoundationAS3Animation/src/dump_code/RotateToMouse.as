package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import robDaniels.greenFlames.src.graphics.Arrow;
	
	public class RotateToMouse extends Sprite
	{
		private var arrow:Arrow;
		
		public function RotateToMouse()
		{
			init();
		}
		
		private function init():void{
			arrow = new Arrow();
			addChild(arrow);
			arrow.x = stage.stageWidth / 2;
			arrow.y = stage.stageHeight / 2;
			addEventListener(Event.ENTER_FRAME, onStageEnterFrame);
		}
		public function onStageEnterFrame(event:Event):void{
			var dx:Number = mouseX - arrow.x;
			var dy:Number = mouseY - arrow.y;
			var radians:Number = Math.atan2(dy, dx);
			arrow.rotation = radians * 180 / Math.PI;
		}

	}
}