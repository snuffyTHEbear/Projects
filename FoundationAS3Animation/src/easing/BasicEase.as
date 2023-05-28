package easing
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class BasicEase extends Sprite
	{
		private var circle:Sprite;
		private var targetPos:Object;
		
		public function BasicEase()
		{
			init();
		}
		private function init():void
		{
			circle = new Sprite();
			circle.graphics.beginFill(Math.random() * 0xffffff, 0.85);
			circle.graphics.drawCircle(0, 0, 30);
			circle.graphics.endFill();
			addChild(circle);
			
			targetPos = {x:Math.round(Math.random() * 640), y:Math.round(Math.random() * 480)};
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function ease(value:Number, targetValue:Number, easing:Number = 0.2):Number
		{
			return (targetValue - value) * easing;
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
		private function onEnterFrame(e:Event):void
		{
			circle.x += ease(circle.x, targetPos.x);
			circle.y += ease(circle.y, targetPos.y);
			
			//if(checkPosition(circle.x, targetPos.x) && checkPosition(circle.y, targetPos.y))
			if(checkPositions({x:circle.x, y:circle.y}, targetPos))
			{
				targetPos = {x:Math.random() * 640, y:Math.random() * 480};
			}			
		}
	}
}