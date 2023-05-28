package ThreeDee
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	public class LocalGlobal extends Sprite
	{
		private var sprite:Sprite;
		private var tracker:Sprite;
		private var angle:Number = 0;
		
		public function LocalGlobal()
		{
			sprite = new Sprite();
			sprite.graphics.lineStyle(10);
			sprite.graphics.lineTo(200, 0);
			sprite.graphics.drawCircle(200, 0, 10);
			sprite.x = 400;
			sprite.y = 400;
			addChild(sprite);
			
			tracker = new Sprite();
			tracker.graphics.lineStyle(2, 0xcc0000);
			tracker.graphics.drawCircle(0, 0, 20);
			addChild(tracker);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(e:Event):void
		{
			sprite.rotationX += 1;
			sprite.rotationY += 1.2;
			sprite.rotationZ += .5;
			sprite.x = 400 + Math.cos(angle) * 100;
			sprite.y = 400 + Math.sin(angle) * 100;
			sprite.z = 200 + Math.cos(angle * .8) * 400;
			angle += .05;
			var p:Point = sprite.local3DToGlobal(new Vector3D(200, 0, 0));
			tracker.x = p.x;
			tracker.y = p.y;
		}
	}
}