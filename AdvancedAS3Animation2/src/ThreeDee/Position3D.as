package ThreeDee
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Position3D extends Sprite
	{
		private var shape:Shape;
		private var n:Number = 0;
		
		public function Position3D()
		{
			shape = new Shape();
			shape.graphics.beginFill(0x00cc00);
			shape.graphics.drawRect(-100, -100, 200, 200);
			shape.graphics.endFill();
			addChild(shape);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(e:Event):void
		{
			shape.x = mouseX;
			shape.y = mouseY;
			shape.z = 10000 + Math.sin(n += .1) * 10000;
		}
	}
}