package
{
	import com.arcticcode.greenFlames.graphics.CreateCircle;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class SpringPhysics extends Sprite
	{
		private var _circle:CreateCircle;
		private var _circleB:CreateCircle;
		
		public function SpringPhysics()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_circle = new CreateCircle(30, true, false, 0xcc0000, 1);
			addChild(_circle);
			_circle._object.xp = _circle._object.yp = 0;
			_circleB = new CreateCircle(20, true, false, 0x00CC00, 1);
			addChild(_circleB);
			_circleB._object.xp = _circleB._object.yp = 0;
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void
		{
			spring(_circle, stage.mouseX, stage.mouseY, 0.9, 0.1);
			spring(_circleB, _circle.x, _circle.y, 0.9, 0.1);
		}
		
		private function spring(obj:CreateCircle, centerX:Number, centerY:Number, inertia:Number, k:Number):void
		{
			var tempX:Number = -obj.x + centerX;
			var tempY:Number = -obj.y + centerY;
			
			obj._object.xp = obj._object.xp * inertia + tempX * k;
			obj._object.yp = obj._object.yp * inertia + tempY * k;
			
			obj.x += obj._object.xp;
			obj.y += obj._object.yp;
			
		}
	}
}