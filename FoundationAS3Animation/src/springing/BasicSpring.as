package springing
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class BasicSpring extends Sprite
	{
		private var circle:Sprite;
		private var pos:Object;
		private var targetPos:Object;
		private var friction:Number = 0.95;
		private var _drawSpring:Boolean;
		
		public function BasicSpring(drawSpring:Boolean = false)
		{
			_drawSpring = drawSpring;
			
			init();
		}
		private function init():void
		{
			circle = new Sprite();
			circle.graphics.beginFill(Math.random() * 0xffffff, 0.85);
			circle.graphics.drawCircle(0,0,30);
			circle.graphics.endFill();
			addChild(circle);
			pos = {x:50, y:75};
			
			targetPos = {x:640*0.5, y:480*0.5};
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function checkPosition(value:Number, valueTarget:Number, checkValue:Number = 0.1):Boolean
		{
			return Math.abs(valueTarget - value) < checkValue;
		}
		private function checkPositions(position:Object, targetPosition:Object, checkValue:Number = 0.1):Boolean
		{
			var dx:Number = position.x - targetPosition.x;
			var dy:Number = position.y - targetPosition.y;
			return Math.abs(Math.sqrt(dx * dx + dy * dy)) < checkValue;
		}
		private function spring(value:Number, target:Number, spring:Number = 0.1):Number
		{
			return (target - value) * spring;
		}
		private function onEnterFrame(e:Event):void
		{
			pos.x += spring(circle.x, targetPos.x);
			pos.y += spring(circle.y, targetPos.y);
			
			pos.x *= friction;
			pos.y *= friction;
			
			circle.x += pos.x;
			circle.y += pos.y;
			
			if(_drawSpring)
			{
				graphics.clear();
				graphics.lineStyle(0);
				graphics.moveTo(targetPos.x, targetPos.y);
				graphics.lineTo(circle.x, circle.y);
			}
			
			//if(checkPosition(circle.x, targetPos.x) && checkPosition(circle.y, targetPos.y))
			if(checkPositions({x:circle.x, y:circle.y}, targetPos, 0.1))
			{
				targetPos = {x:Math.random() * 640, y:Math.random() * 480};
			}
		}
	}
}