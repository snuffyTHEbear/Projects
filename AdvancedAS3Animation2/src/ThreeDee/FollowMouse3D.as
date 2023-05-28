package ThreeDee
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	public class FollowMouse3D extends Sprite
	{
		private var sprite:Sprite;
		private var angleX:Number = 0;
		private var angleZ:Number = 0;
		private var angleY:Number = 0;
		
		public function FollowMouse3D()
		{
			sprite = new Sprite();
			sprite.x = 400;
			sprite.y = 400;
			sprite.z = 200;
			sprite.graphics.beginFill(0xcc0000);
			sprite.graphics.moveTo(0, 50);
			sprite.graphics.moveTo(0, 50);
			sprite.graphics.lineTo(-25, 25);
			sprite.graphics.lineTo(-10, 25);
			sprite.graphics.lineTo(-10, -50);
			sprite.graphics.lineTo(10, -50);
			sprite.graphics.lineTo(10, 25);
			sprite.graphics.lineTo(25, 25);
			sprite.graphics.lineTo(0, 50);
			sprite.graphics.endFill();
			addChild(sprite);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(e:Event):void
		{
			sprite.x = 400 + Math.sin(angleX += .11) * 200;
			sprite.y = 400 + Math.sin(angleY += .07) * 200;
			sprite.z = Math.sin(angleZ += .09) * 200;
			sprite.transform.matrix3D.pointAt(new Vector3D(mouseX, mouseY, 0));
		}
	}
}