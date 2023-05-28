package physics
{
	import com.arcticcode.greenFlames.geom.SimpleBounds;
	import com.arcticcode.greenFlames.math.SimplePhysics;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import objects.BasicObject;
	
	public class Throwing extends Sprite
	{
		private var _ball:BasicObject;
		private var _simpleBounds:SimpleBounds;
		private var _gravity:Number = 0.5;
		private var _friction:Number = 0.99;
		private var _trackVelocity:Boolean = false;
		private var _oldX:Number = 0;
		private var _oldY:Number = 0;
		
		public function Throwing()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void
		{
			_simpleBounds = new SimpleBounds(SimpleBounds.rectangleFromStage(stage));
			_ball = new BasicObject();
			_ball.drawCircle(30);
			_ball.move(stage.stageWidth * 0.5, stage.stageHeight * 0.5);
			addChild(_ball);
			
			_ball.vx = Math.random() * 10 - 5;
			_ball.vy = -10;
			
			_ball.addEventListener(MouseEvent.MOUSE_DOWN, ballMouseDown_Handler);
			addEventListener(Event.ENTER_FRAME, loop);
		}
		private function ballMouseDown_Handler(e:MouseEvent):void
		{
			_oldX = _ball.x;
			_oldY = _ball.y;
			_ball.startDrag();
			_ball.addEventListener(MouseEvent.MOUSE_UP, ballMouseUp_Handler);
			_trackVelocity = true;
		}
		private function ballMouseUp_Handler(e:MouseEvent):void
		{
			_ball.stopDrag();
			_ball.removeEventListener(MouseEvent.MOUSE_UP, ballMouseUp_Handler);
			_trackVelocity = false;
		}
		private function loop(e:Event):void
		{			
			if(_trackVelocity)
			{
				_ball.vx = _ball.x - _oldX;
				_ball.vy = _ball.y - _oldY;
				_oldX = _ball.x;
				_oldY = _ball.y;
			}
			else
			{
				_ball.addForce(_gravity, "vy");
				_ball.multiplyForce(_friction, "vx");
				_ball.applyVelocity();
				_simpleBounds.checkBoundsBounce(_ball, _ball, -0.7);
			}
		}
	}
}