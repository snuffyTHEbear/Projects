package springing
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import objects.BasicObject;
	import objects.Position;
	
	public class ChainedSpringing extends Sprite
	{
		private var balls:Vector.<BasicObject> = new Vector.<BasicObject>();
		private var gravity:Number = 5;
		private var friction:Number = 0.7;
		private var _drawSpring:Boolean;
		private var inc:int = 0;
		private var numBalls:int;
		
		public function ChainedSpringing(numBalls:int = 4, drawSpring:Boolean = false)
		{
			_drawSpring = drawSpring;
			this.numBalls = numBalls;
			
			init();
		}
		private function init():void
		{
			for(inc = 0; inc < numBalls; inc++)
			{
				var ball:BasicObject = new BasicObject();
				ball.vx = 0;
				ball.vy = 0;
				ball.drawCircle();
				addChild(ball);
				balls.push(ball);
			}
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function spring(value:Number, target:Number, spring:Number = 0.1):Number
		{
			return (target - value) * spring;
		}
		private function springObject(obj:BasicObject, targetPosition:Position):void
		{
			obj.vx += spring(obj.x, targetPosition.x);
			obj.vy += spring(obj.y, targetPosition.y);
			obj.vy += gravity;
			obj.vx *= friction;
			obj.vy *= friction;
			obj.x += obj.vx;
			obj.y += obj.vy;
		}
		private function onEnterFrame(e:Event):void
		{
			if(_drawSpring)
			{
				graphics.clear();
				graphics.lineStyle(0);
				graphics.moveTo(mouseX, mouseY);
			}
			
			springObject(balls[0], new Position(mouseX, mouseY));
			_drawSpring ? graphics.lineTo(balls[0].x, balls[0].y) : {};
			
			for(inc = 1; inc < numBalls; inc++)
			{
				springObject(balls[inc], new Position(balls[inc - 1].x, balls[inc - 1].y));
				_drawSpring ? graphics.lineTo(balls[inc].x, balls[inc].y) : {};
			}
		}
	}
}