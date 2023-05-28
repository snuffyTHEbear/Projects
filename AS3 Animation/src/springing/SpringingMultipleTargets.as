package springing
{
	import display.objects.Ball;
	import display.objects.Handle;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class SpringingMultipleTargets extends Sprite
	{
		private var _spring:Number = 0.1;
		private var _targetX:Number;
		private var _targetY:Number;
		private var _vx:Number = 0;
		private var _vy:Number = 0;
		private var _friction:Number = 0.9;
		private var _numHandles:uint = 3;
		private var _gravity:Number = 5;
		private var _ball:Ball;
		private var _handles:Vector.<Handle> = new Vector.<Handle>();
		
		public function SpringingMultipleTargets()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(e.type, init);
			
			var i:uint = 0;
			for(i = 0; i < _numHandles; i++)
			{
				var h:Handle = new Handle();
				h.x = Math.random() * stage.stageWidth;
				h.y = Math.random() * stage.stageHeight;
				addChild(h);
				_handles.push(h);
				h.addEventListener(MouseEvent.MOUSE_DOWN, handleDown);
			}
			
			_ball = new Ball(20);
			addChild(_ball);
			
			stage.addEventListener(MouseEvent.MOUSE_UP, handleUp);
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function handleDown(e:MouseEvent):void
		{
			e.target.startDrag();
		}
		
		private function handleUp(e:MouseEvent):void
		{
			stopDrag();
		}
		
		private function loop(e:Event):void
		{
			var i:uint = 0;
			for(i=0;i<_numHandles;i++)
			{
				springToTarget(_ball, _handles[i].x, _handles[i].y);
			}
		}
		
		private function springToTarget(obj:Object, targetX:Number, targetY:Number):void
		{
			var dx:Number = targetX - obj.x;
			var dy:Number = targetY - obj.y;
			var ax:Number = dx * _spring;
			var ay:Number = dy * _spring;
			obj.vx += ax;
			obj.vy += ay;
			obj.vy += _gravity;
			obj.vx *= _friction;
			obj.vy *= _friction;
			obj.x += obj.vx;
			obj.y += obj.vy;
		}
	}
}