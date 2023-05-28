package com.tests
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	
	import org.fly3D.display.BasicDisplayObject3D;
	import org.fly3D.display.BasicScene;
	
	public class Basic3DDepthTest extends BasicScene
	{
		
		[Embed(source="assets/head.png", mimeType = "image/png")]
		private var _headClass:Class;
		
		private var _numItems:uint = 30;
		
		private var _objects:Array = new Array(_numItems);
		
		private var _angle:Number = 0;
		
		private var _inc:uint = 0;
		
		private var _radius:Array = new Array(_numItems);
		
		private var _angles:Array = new Array(_numItems);
		
		private var _anglesInc:Array = new Array(_numItems);
		
		public function Basic3DDepthTest(w:Number, h:Number)
		{
			super(w * 0.5, h * 0.5);
			for(_inc = 0; _inc < _numItems; _inc++)
			{
				var obj:BasicDisplayObject3D = new BasicDisplayObject3D();
				var b:Bitmap = new _headClass();
				b.x -= b.width * 0.5;
				b.y -= b.height * 0.5;
				b.scaleX = Math.random() > 0.5 ? -1 : 1;
				obj.addChild(b);
				_objects[_inc] = (obj);
				obj.move(Math.random() * 500 - 250, Math.random() * 500 - 250, Math.random() * 2000 - 1000);
				_angles[_inc] = (Math.random() * 0.9) + 0.1;
				_anglesInc[_inc] = (Math.random() * 0.2);
				_radius[_inc] = (Math.random() * 130) + 40;
				obj.transform.colorTransform = new ColorTransform(Math.random(), Math.random(), Math.random());
				add3DObject(obj);
			}
			
			depthSort();
			render();
			
			//addEventListener(Event.ENTER_FRAME, loop);
			startRendering();
		}
		
		override protected function loop(e:Event):void
		{
			var a:Number, r:Number, f:Function;
			f = Math.sin;
			for(_inc = 0; _inc < _numItems; _inc++)
			{
				_angles[_inc] += _anglesInc[_inc];
				a = _angles[_inc];
				r = _radius[_inc];
				_objects[_inc].position.z = f(a) * r;
			}
			
			depthSort();
			render();
		}
	}
}