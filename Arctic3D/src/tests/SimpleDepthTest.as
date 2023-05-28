package tests
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.arctic3d.display.Arctic3DScene;
	import org.arctic3d.geom.Point3D;
	
	public class SimpleDepthTest extends Arctic3DScene
	{
		private var _sprite:Sprite;
		private var _pos:Point3D;
		private var _angle:Number = 0;
		
		public function SimpleDepthTest(w:Number = 640, h:Number = 480)
		{
			super(w, h);
		}
		
		override protected function init(e:Event):void
		{
			removeEventListener(e.type, arguments.callee);
			
			_sprite = addChild(new Sprite()) as Sprite;
			
			with(_sprite.graphics)
			{
				beginFill(0xcc0000);
				drawRect(-50, -50, 100, 100);
				endFill();
			}
			
			_sprite.visible = false;
			
			_pos = new Point3D(0,0,0);
			_pos.setCenter(0,0,0);
			_pos.setVanishingPoint(vpX, vpY);
			
			startRendering();
		}
		override protected function onRenderTick(e:Event) : void
		{
			_pos.z = Math.sin(_angle) * 100;
			_angle += 0.1;
			
			super.onRenderTick(e);
		}
		
		override protected function render() : void
		{
			if(_pos.inView())
			{
				_sprite.visible = true;
				_sprite.scaleX = _sprite.scaleY = _pos.scale;
				_sprite.x = _pos.screenX;
				_sprite.y = _pos.screenY;
			}
			else
			{
				_sprite.visible = false;
			}
		}
	}
}