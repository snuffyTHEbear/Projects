package springing
{
	import com.arcticcode.greenFlames.math.SimplePhysics;
	import com.arcticcode.greenFlames.math.Springing;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import objects.BasicObject;
	
	public class SpringingMultipleTargets extends Sprite
	{
		private var obj:BasicObject;
		private var handles:Vector.<BasicObject> = new Vector.<BasicObject>();
		private var numHandles:int;
		private var inc:int = 0;
		private var _drawSprings:Boolean;
		
		public function SpringingMultipleTargets(numHandles:int = 3, drawSprings:Boolean = false)
		{
			_drawSprings = drawSprings;
			this.numHandles = numHandles;
			init();
		}
		private function init():void
		{
			obj = new BasicObject();
			obj.drawCircle();
			addChild(obj);
			
			for(inc = 0; inc < numHandles; inc++)
			{
				var handle:BasicObject = new BasicObject();
				handle.drawSquare();
				handle.move(Math.random() * 640, Math.random() * 480);
				handle.addEventListener(MouseEvent.MOUSE_DOWN, handleDown);
				addChild(handle);
				handles.push(handle);
			}
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(MouseEvent.MOUSE_UP, handleUp);
		}
		private function handleDown(e:MouseEvent):void
		{
			e.target.startDrag();
		}
		private function handleUp(e:MouseEvent):void
		{
			stopDrag();
		}
		private function onEnterFrame(e:Event):void
		{
			for(inc = 0; inc < numHandles; inc++)
			{
				obj.vx += Springing.spring(obj.x, handles[inc].x);
				obj.vy += Springing.spring(obj.y, handles[inc].y);
			}
			
			obj.vx *= SimplePhysics.FRICTION;
			obj.vy *= SimplePhysics.FRICTION;
			obj.x += obj.vx;
			obj.y += obj.vy;
			
			if(_drawSprings)
			{
				graphics.clear();
				graphics.lineStyle(0);
				for(inc = 0; inc < numHandles; inc++)
				{
					graphics.moveTo(obj.x, obj.y);
					graphics.lineTo(handles[inc].x, handles[inc].y);
				}
			}
		}
	}
}