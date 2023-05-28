package springing
{
	import com.arcticcode.greenFlames.math.Springing;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import objects.BasicObject;
	
	public class OffsetSpring extends Sprite
	{
		private var obj:BasicObject;
		private var springLength:Number = 100;
		
		public function OffsetSpring()
		{
			init();
		}
		private function init():void
		{
			obj = new BasicObject();
			obj.drawSquare();
			addChild(obj);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(e:Event):void
		{
			var dx:Number = obj.x - mouseX;
			var dy:Number = obj.y - mouseY;
			var angle:Number = Math.atan2(dy, dx);
			var tx:Number = mouseX + Math.cos(angle) * springLength;
			var ty:Number = mouseY + Math.sin(angle) * springLength;
			obj.vx += Springing.spring(obj.x, tx);
			obj.vy += Springing.spring(obj.y, ty);
			obj.applyFriction(0.95);
			obj.applyVelocity();
			graphics.clear();
			graphics.lineStyle(0);
			graphics.moveTo(obj.x, obj.y);
			graphics.lineTo(mouseX, mouseY);
		}
	}
}