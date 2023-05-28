package com.tests
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.ui.Keyboard;
	
	import org.fly3D.display.BasicDisplayObject3D;
	import org.fly3D.display.BasicScene;

	/**
	 * 
	 * @author Robert Daniels
	 *Tests the easability to move in 3D space (point and click to start)
	 * Use heads to set numerous objects at depths and then when clicked zoom the (psuedo) camera to them 
	 */	
	public class MovementTests extends BasicScene
	{
		[Embed(source="assets/head.png", mimeType="image/png")]
		private var _headClass:Class;
		
		private var _numItems:uint = 30;
		private var _objects:Array = new Array(_numItems);
		private var _inc:uint = 0;
		private var _lookIndex:int = 0;
		private var _notThere:Array = new Array();
		
		public function MovementTests(w:Number, h:Number)
		{
			super(w * 0.5, h * 0.5);
			//[TODO - Add children to container and render the container in 3D to see is nested objects render correctly]
			for(_inc = 0; _inc < _numItems; _inc++)
			{
				var obj:BasicDisplayObject3D = new BasicDisplayObject3D();	
				
				var b:Bitmap = new _headClass();
				b.x -= b.width * 0.5;
				b.y -= b.height * 0.5;
				b.scaleX = Math.random() > 0.5 ? -1 : 1;
				obj.addChild(b);
				
				_objects[_inc] = (obj);
				obj.move(Math.random() * 300 - 150, 50, Math.random() * 2000 - 1000);
				obj.transform.colorTransform = new ColorTransform(Math.random(), Math.random(), Math.random());
				add3DObject(obj);
				obj.addEventListener(MouseEvent.CLICK, click);
				obj.buttonMode = true;
				obj.outOfViewCallback = moveObjectIntoFocus;
			}
			
			depthSort();
			render();
			
			addEventListener(Event.ENTER_FRAME, loop);
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function moveObjectIntoFocus(obj:BasicDisplayObject3D):void
		{
			obj.move(Math.random() * 300 - 150, 50, Math.random() * 2000 - 1000);
		}
		private function init(e:Event):void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function click(e:MouseEvent):void
		{
			lookAt(e.target as BasicDisplayObject3D);
		}
		private function onKey(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
				case Keyboard.UP:
					zoom(-25);
					break;
				
				case Keyboard.DOWN:
					zoom(25);
					break;
				
				case Keyboard.RIGHT:
					_lookIndex += 1;
					if(_lookIndex == num3DObjects){_lookIndex = 0;}
					lookAt(BasicDisplayObject3D(this.getChildAt(_lookIndex)));
					break;
				
				case Keyboard.LEFT:
					_lookIndex -= 1;
					if(_lookIndex == -1){_lookIndex = num3DObjects - 1;}
					lookAt(BasicDisplayObject3D(this.getChildAt(_lookIndex)));
					break;
				
				case Keyboard.SPACE:
					resetView();
					break;
				
				default:
					break;
			}
		}
		private function loop(e:Event):void
		{
			depthSort();
			render();
		}
	}
}