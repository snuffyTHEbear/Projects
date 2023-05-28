package com.tests
{
	import flash.events.Event;
	import flash.geom.ColorTransform;
	
	import org.fly3D.display.BasicDisplayObject3D;
	import org.fly3D.display.BasicScene;
	import org.fly3D.geom.Box3D;
	import org.fly3D.geom.Point3D;
	
	public class CollisionDetection extends BasicScene
	{
		private var _box:Box3D;
		private var _numItems:uint = 2;
		private var _items:Array = new Array(_numItems);
		
		public function CollisionDetection(w:Number, h:Number)
		{
			super(w * 0.5, h * 0.5);
			_box = new Box3D(-200, 200, -200, 200, -100, 100);
			for(var i:uint = 0; i < _numItems; i++)
			{
				var obj:BasicDisplayObject3D = new BasicDisplayObject3D();
				obj.graphics.beginFill(0xcc0000);
				obj.object.radius = Math.random() * 15 + 5;
				obj.graphics.drawCircle(0, 0, obj.object.radius);
				obj.graphics.endFill();
				obj.move(Math.random() * 400 - 200, Math.random() * 400 - 200, Math.random() * 400 - 200);
				obj.velocity = new Point3D(Math.random() * 10 - 5, Math.random() * 10 - 5, Math.random() * 10 - 5);
				add3DObject(obj);
				_items[i] = obj;
			}
			
			depthSort();
			render();
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		private function loop(e:Event):void
		{
			for(var i:uint = 0; i < _numItems; i++)
			{
				_items[i].applyVelocity();
				_box.checkBounds(_items[i], _items[i].width * 0.5, _items[i].height * 0.5, 0);
			}
			
			for(i = 0; i < _numItems - 1; i++)
			{
				var objA:BasicDisplayObject3D = _items[i];
				for(var j:uint = i + 1; j < _numItems; j++)
				{
					var objB:BasicDisplayObject3D = _items[j];
					var dx:Number = objA.position.x - objB.position.x;
					var dy:Number = objA.position.y - objB.position.y;
					var dz:Number = objA.position.z - objB.position.z;
					
					//sphere based distance
					var dist:Number = Math.sqrt(dx * dx + dy * dy + dz * dy);
					var minDist:Number = objA.object.radius + objB.object.radius;
					var bt:ColorTransform = new ColorTransform(0, 1, 1, 1, 0, 0, 255, 0);
					var ct:ColorTransform = new ColorTransform(1, 1, 1, 1);
					if(dist < objA.object.radius + objB.object.radius)
					{
						objA.transform.colorTransform = objB.transform.colorTransform = bt;
					}
					else
					{
						objA.transform.colorTransform = objB.transform.colorTransform = ct;
					}
				}
			}
			
			depthSort();
			render();
		}
	}
}