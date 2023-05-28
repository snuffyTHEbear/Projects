package com.tests
{
	import flash.events.Event;
	import flash.geom.ColorTransform;
	
	import org.fly3D.display.BasicScene;
	import org.fly3D.display.Head;
	import org.fly3D.display.Text3D;
	
	public class RotationTests extends BasicScene
	{
		private var _numItems:uint = 25;
		private var _items:Array = new Array(_numItems);
		private var _inc:uint = 0;
		
		public function RotationTests(w:Number, h:Number)
		{
			super(w * 0.5, h * 0.5);
			
			init();
		}
		private function init():void
		{
			for(_inc = 0; _inc < _numItems; _inc++)
			{
				var obj:Text3D = new Text3D("Valo", Math.random() * 15 + 7, Math.random() * 0xFFFFFF);
				obj.move(Math.random() * 300 - 150, Math.random() * 300 - 150, Math.random() * 500 - 250);
				obj.transform.colorTransform = new ColorTransform(Math.random(), Math.random(), Math.random());
				_items[_inc] = obj;
				add3DObject(obj);
			}
			
			depthSort();
			render();
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		private function loop(e:Event):void
		{
			for(_inc = 0; _inc < _numItems; _inc++)
			{
				_items[_inc].rotateY( (mouseX - vanishingPointX) * .0005);
				_items[_inc].rotateX( (mouseY - vanishingPointY) * .0005);
			}
			
			depthSort();
			render();
		}
	}
}