package ThreeDee
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	public class GlobalLocal extends Sprite
	{
		private var sprite:Sprite;
		private var tracker:Sprite;
		private var angle:Number = 0;
		
		public function GlobalLocal()
		{
			sprite = new Sprite();
			sprite.graphics.lineStyle(5);
			sprite.graphics.drawRect(-200, -200, 400, 400);
			sprite.x = 400;
			sprite.y = 400;
			addChild(sprite);
			
			tracker = new Sprite();
			tracker.graphics.lineStyle(2, 0xcc0000);
			tracker.graphics.drawCircle(0, 0, 20);
			sprite.addChild(tracker);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(e:Event):void
		{
			sprite.rotationX += 1;
			sprite.rotationY += 1.2;
			sprite.rotationZ += .5;
			sprite.x = 200 + Math.cos(angle) * 100;
			sprite.y = 200 + Math.sin(angle) * 100;
			sprite.z = 200 + Math.cos(angle * .8) * 400;
			angle += .05;
			var p:Vector3D = sprite.globalToLocal3D(new Point(mouseX, mouseY));
			//tracker.x = sprite.mouseX
			//tracker.y = sprite.mouseY;
		}
	}
}