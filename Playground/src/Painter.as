package
{
	import com.arcticcode.geom.CubicBezier;
	import com.arcticcode.visual.controls.Handle;
	import com.arcticcode.visual.shapes.Shape;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.utils.setInterval;
	
	[SWF(width = 1024, height = 640, frameRate = 60, backgroundColor = 0x000000)]
	public class Painter extends Sprite
	{
		private var w:Number = stage.stageWidth;
		private var h:Number = stage.stageHeight;
		private var centreX:Number = w * 0.5;
		private var centreY:Number = h * 0.5;
		/**
		 *Curve A 
		 */		
		private var _anchorA:Handle;
		/**
		 *Curve B 
		 */		
		private var _anchorB:Handle;
		/**
		 *Start 
		 */		
		private var _controlA:Handle;
		/**
		 *End 
		 */		
		private var _controlB:Handle;
		
		private var _canvas:Bitmap;
		private var _blur:BlurFilter;
		private var _container:Sprite;
		private var _rate:Number = 0.005;
		private var _distance:Number;
		private var _inc:Number = 0;
		private var _min:uint = 0;
		private var _max:uint = 1;
		private var _bezier:CubicBezier;
		private var _shapes:Vector.<Shape> = new Vector.<Shape>();
		private var _requestIntervalID:uint;
		private var _blurIntervalID:uint;
		private var _mouseDown:Boolean = false;
		private var _colours:Array = [0xE25C56, 0xE2BA56, 0xF0C0A8, 0xF0F0D8, 0xD8F0F0];
		
		private const START_SCALE_MIN:Number = 0.25;
		private const START_SCALE_MAX:Number = 0.5;
		private const MID_SCALE_MIN:Number = 0.5;
		private const MID_SCALE_MAX:Number = 3;
		private const END_SCALE_MIN:Number = 0.25;
		private const END_SCALE_MAX:Number = 0.5;
		private const MAX_SHAPES:uint = 20;
		
		public function Painter()
		{
			stage.scaleMode = "noScale";
			
			init();
		}
		private function init():void
		{
			setupGUI();
			
			_container = new Sprite();
			_canvas = new Bitmap(new BitmapData(w, h, true, 0xff000000));
			addChild(_canvas);
			
			_blur =  new BlurFilter(3, 3, 1);
			
			_requestIntervalID = setInterval(paint, 0);
			_blurIntervalID = setInterval(blur, 50);
			setInterval(requestCircle, 50);
			
			//stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		}
		private function setupGUI():void
		{
			_anchorA = new Handle(0xcc0000, true, null, 300, h);
			addChild(_anchorA);
			
			_anchorB = new Handle(0xcc0000, true, null, 300, h);
			addChild(_anchorB);
			
			_controlA = new Handle(0x00cc00, false);
			addChild(_controlA);
			
			_controlB = new Handle(0x00cc00, false);
			addChild(_controlB);
			
			_controlA.setInteractivity(false);
			_controlB.setInteractivity(false);
			_anchorA.setInteractivity(false);
			_anchorB.setInteractivity(false);
			
			_controlA.visible = _controlB.visible = _anchorA.visible = _anchorB.visible = false;
		}
		private function mouseDown(e:MouseEvent):void
		{
			if(!_mouseDown)
			{
				//_requestIntervalID = setInterval(paint, 0);
				//_blurIntervalID = setInterval(blur, 50);
				_controlA.move(stage.mouseX, stage.mouseY);
				//stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
				stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
				_mouseDown = true;
			}
		}
		private function mouseMove(e:MouseEvent):void
		{
			//updatePoints();
		}
		private function mouseUp(e:MouseEvent):void
		{
			requestCircle();
			_mouseDown = false;
			//clearInterval(_requestIntervalID);
			//clearInterval(_blurIntervalID);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			
			//updatePoints();
		}
		private function updatePoints():void
		{
			_controlB.move(stage.mouseX, stage.mouseY);
			
			_distance = distance(_controlA.getCenterPoint(), _controlB.getCenterPoint());
			_distance *= 4;
			var xpos:Number = (Math.random() * _distance - _distance * 0.5) + _controlA.getCenterPoint().x;
			var ypos:Number = (Math.random() * _distance - _distance * 0.5) + _controlA.getCenterPoint().y;
			_anchorA.move(xpos, ypos);
			xpos = (Math.random() * _distance - _distance * 0.5) + _controlB.getCenterPoint().x;
			ypos = (Math.random() * _distance - _distance * 0.5) + _controlB.getCenterPoint().y;
			_anchorB.move(xpos, ypos);
			
			drawBezier(_controlA.getCenterPoint(), _controlB.getCenterPoint(), _anchorA.getCenterPoint(), _anchorB.getCenterPoint());
		}
		private function getColour():uint
		{
			return _colours[Math.floor(Math.random() * _colours.length)];
		}
		/**
		 * @param controlA - Curve A
		 * @param controlB - Curve B
		 * @param anchorA - Start
		 * @param anchorB - End 
		 */				
		private function drawBezier(controlA:Point, controlB:Point, anchorA:Point, anchorB:Point):void
		{
			
			var obj:Object = {};
			obj.a = anchorA;
			obj.b = anchorB;
			_bezier = new CubicBezier(controlA, obj.a, controlB, obj.b);
			var pos:Point = _bezier.getPoint(_min);
			_container.graphics.clear();
			//_container.graphics.lineStyle(1, getColour());
			_container.graphics.beginFill(getColour());
			//_container.graphics.moveTo(pos.x, pos.y);
			for(_inc = _min; _inc < _max; _inc += _rate)
			{
				pos = _bezier.getPoint(_inc);
				//_container.graphics.lineTo(pos.x, pos.y);
				_container.graphics.drawCircle(pos.x, pos.y, 3);
			}
		}
		private function update(obj:Shape):void
		{
			var c:Shape = obj;//e.target as Shape;
			c._object.inc += _rate;
			//position
			var pos:Point = c._object.bezier.getPoint(c._object.inc) as Point;
			//c.move(pos.x, pos.y);
			c.x = pos.x;
			c.y = pos.y;
			//c.colour = _bitmap.bitmapData.getPixel(c.x, c.y);
			c.draw();
			//scale
			var scale:Number = 0;
			if(c._object.inc < 0.5)
			{
				scale = c._object.inc * 2 * (c._object.midScale - c._object.startScale) + c._object.startScale;
			}
			else
			{
				scale = (c._object.inc - 0.5) * 2 * (c._object.endScale - c._object.midScale) + c._object.midScale;
			}
			c.scaleX = c.scaleY = scale;
			//rotation
			var rotation:Number;
			if(c._object.pos != null)
			{
				rotation = Math.atan2(pos.y - c._object.pos.y, pos.x - c._object.pos.y) * 180 / Math.PI;
				c.rotation = rotation;
			}
			c._object.pos = pos;
			//Check end
			if(c._object.inc >= _max)
			{
				_container.removeChild(c);
				_shapes.splice(_shapes.indexOf(c), 1);
				c._object = null;
				c = null;				
			}
		}
		private function requestCircle():void
		{
			if(_shapes.length == MAX_SHAPES)
			{
				return;
				//clearInterval(_requestIntervalID);
			}
			var obj:Shape = new Shape();
			
			/*var ct:ColorTransform = obj.transform.colorTransform;
			ct.color = getColour();
			obj.transform.colorTransform = ct;*/
			
			//obj.alpha = 0.1;
			/*obj._object.randomPointA = _anchorA.getRandomPoint();
			obj._object.randomPointB = _anchorB.getRandomPoint();
			obj._object.bezier = new CubicBezier(_controlA.getCenterPoint(),
				obj._object.randomPointA,
				_controlB.getCenterPoint(),
				obj._object.randomPointB);*/
			_controlA.move(Math.random() * (w - 20) + 10, Math.random() * (h - 20) + 10);
			_controlB.move(Math.random() * (w - 20) + 10, Math.random() * (h - 20) + 10);
			//_controlB.move(stage.mouseX, stage.mouseY);
			
			_distance = distance(_controlA.getCenterPoint(), _controlB.getCenterPoint());
			_distance *= Math.PI;
			var xpos:Number = (Math.random() * _distance - _distance * 0.5) + _controlA.getCenterPoint().x;
			var ypos:Number = (Math.random() * _distance - _distance * 0.5) + _controlA.getCenterPoint().y;
			_anchorA.move(xpos, ypos);
			xpos = (Math.random() * _distance - _distance * 0.5) + _controlB.getCenterPoint().x;
			ypos = (Math.random() * _distance - _distance * 0.5) + _controlB.getCenterPoint().y;
			_anchorB.move(xpos, ypos);
			obj._object.randomPointA = _anchorA.getRandomPoint();
			obj._object.randomPointB = _anchorB.getRandomPoint();
			obj._object.bezier = new CubicBezier(_controlA.getCenterPoint(),
				obj._object.randomPointA,
				_controlB.getCenterPoint(),
				obj._object.randomPointB);
			obj._object.inc = 0;
			obj._object.startScale = Math.random() * (START_SCALE_MAX - START_SCALE_MIN) + START_SCALE_MIN;
			obj._object.midScale = Math.random() * (MID_SCALE_MAX - MID_SCALE_MIN) + MID_SCALE_MIN;
			obj._object.endScale = Math.random() * (END_SCALE_MAX - END_SCALE_MIN) + END_SCALE_MIN;
			obj.scaleX = obj.scaleY = obj._object.startScale;
			var pos:Point = obj._object.bezier.getPoint(obj._object.inc);
			//obj.move(pos.x, pos.y);
			obj.x = pos.x;
			obj.y = pos.y;
			obj.colour = getColour();
			//obj.colour = _bitmap.bitmapData.getPixel(obj.x, obj.y);
			obj.draw();
			_container.addChild(obj);
			_shapes.push(obj);
		}
		private function blur():void
		{
			_canvas.bitmapData.applyFilter(_canvas.bitmapData, _canvas.bitmapData.rect, new Point(0, 0), _blur);
		}
		private function paint():void
		{
			for(_inc = 0; _inc < _shapes.length; _inc++)
			{
				update(_shapes[_inc]);
			}
			//updatePoints();
			_canvas.bitmapData.draw(_container);
		}
		private function distance(a:Point, b:Point):Number
		{
			return (a.x - b.x, a.y - b.y);
		}
	}
}