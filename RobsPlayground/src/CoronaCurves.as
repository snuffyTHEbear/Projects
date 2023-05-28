/*==============================================*/
/*   Sasori Daniels - http://arctic-code.com    */
/*==============================================*/

package
{
	import com.arcticcode.geom.CubicBezier;
	import com.arcticcode.greenFlames.filters.StockFilters;
	import com.arcticcode.visual.controls.Handle;
	import com.arcticcode.visual.shapes.Shape;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.filters.DropShadowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;

	public class CoronaCurves extends Sprite
	{

		public function CoronaCurves(w:Number, h:Number, drawCount:uint = 10, spawnRate:Number = 50, blurRate:Number = 50, endCallback:Function = null, bgColor:uint = 0xFFFFFFFF)
		{
			DRAW_COUNT = drawCount;
			_spawnRate = spawnRate;
			_blurRate = blurRate;
			_bgColor = bgColor;
			this.w = w;
			this.h = h;
			centreX = w * 0.5;
			centreY = h * 0.5;
			this._endCallback = endCallback;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private var DRAW_COUNT:uint = 10;
		private const END_SCALE_MAX:Number = 0.5;
		private const END_SCALE_MIN:Number = 0.25;
		private const MAX_SHAPES:uint = 10;
		private const MID_SCALE_MAX:Number = 2;
		private const MID_SCALE_MIN:Number = 0.5;
		private const RADIUS:Number = 50;
		private const START_SCALE_MAX:Number = 0.5;

		private const START_SCALE_MIN:Number = 0.25;
		/**
		 *Curve A
		 */
		private var _anchorA:Handle;
		/**
		 *Curve B
		 */
		private var _anchorB:Handle;
		private var _bezier:CubicBezier;
		private var _bgColor:uint;
		private var _blur:BlurFilter;
		private var _blurIntervalID:uint;
		private var _blurRate:Number = 0;

		private var _bluring:Boolean = false;

		private var _canvas:Bitmap;
		private var _colours:Array = [0xE25C56, 0xE2BA56, 0xF0C0A8, 0xF0F0D8, 0xD8F0F0];
		private var _container:Sprite;
		/**
		 *Start
		 */
		private var _controlA:Handle;
		/**
		 *End
		 */
		private var _controlB:Handle;
		private var _distance:Number;

		private var _drawNum:uint = 0;
		private var _endCallback:Function;
		private var _inc:Number = 0;
		private var _inc_angle:Number = 0;
		private var _isPaused:Boolean = false;
		private var _max:uint = 1;
		private var _min:uint = 0;
		private var _mouseDown:Boolean = false;
		private var _paintInterval:uint;
		private var _rate:Number = 0.005;
		private var _requestIntervalID:uint;
		private var _shadow:DropShadowFilter = StockFilters.stockShadowFilter();
		private var _shapes:Array = [];
		private var _spawnRate:Number;
		private var _started:Boolean = false;
		private var _ypos:Number = 0;
		private var centreX:Number;
		private var centreY:Number;
		private var h:Number;
		private var w:Number;

		public function addColour(c:uint):void
		{
			_colours[_colours.length] = uint(c);
		}

		public function get bluring():Boolean
		{
			return _bluring;
		}

		public function pause():void
		{
			if (_isPaused)
			{
				_paintInterval = setInterval(paint, 0);
				_requestIntervalID = setInterval(requestCircle, _spawnRate);
			}
			else
			{
				clearInterval(_requestIntervalID);
				clearInterval(_paintInterval);
			}
			_isPaused = !_isPaused;
		}

		public function removeColours(index:uint, deleteCount:uint = 1):void
		{
			_colours.splice(index, deleteCount);
		}

		public function start():void
		{
			if (_started)
				return;
			_paintInterval = setInterval(paint, 0);
			_requestIntervalID = setInterval(requestCircle, _spawnRate);
			_started = true;
		}

		public function startBlur():void
		{
			if (_bluring)
				return;
			_blur = new BlurFilter(1.1, 1.1, 1);
			_blurIntervalID = setInterval(blur, _blurRate);
			_bluring = true;
		}

		public function stopBlur():void
		{
			clearInterval(_blurIntervalID);
			_bluring = false;
		}

		private function blur():void
		{
			_canvas.bitmapData.applyFilter(_canvas.bitmapData, _canvas.bitmapData.rect, new Point(0, 0), _blur);
		}

		private function distance(a:Point, b:Point):Number
		{
			return (a.x - b.x, a.y - b.y);
		}

		private function getColour():uint
		{
			return _colours[Math.floor(Math.random() * _colours.length)];
		}

		private function init(e:Event):void
		{
			setupGUI();

			_container = new Sprite();
			_canvas = new Bitmap(new BitmapData(w, h, true, _bgColor));
			addChild(_canvas);

			//_shadow = new DropShadowFilter(0, 90, getColour(), 1, 3, 3, 0.85, 3);
			//[TODO]3D rotation via mouse control
		}

		private function mouseDown(e:MouseEvent):void
		{
			if (!_mouseDown)
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

		private function paint():void
		{
			for (_inc = 0; _inc < _shapes.length; _inc++)
			{
				update(_shapes[_inc]);
			}
			//_ypos += Math.random() * 50 - 25;
			//_ypos = Math.min(_ypos, Math.max(_ypos, h));
			//_container.graphics.beginFill(getColour(), Math.random() + 0.5);
			//if(Math.random() > 0.8)_container.graphics.drawRect(0, _ypos, w, 5);//_container.graphics.drawRect(0, h + 150, w, 1);
			//_container.graphics.endFill();
			_canvas.bitmapData.lock();
			_canvas.bitmapData.draw(_container);
			_canvas.bitmapData.unlock();
			//_canvas.bitmapData.scroll(0, -3);
			//_container.graphics.clear();
		}

		private function requestCircle():void
		{
			if (_shapes.length == MAX_SHAPES)
			{
				return;
			}
			if (_drawNum == DRAW_COUNT)
			{
				return;
				/*clearInterval(_requestIntervalID);
				clearInterval(_paintInterval);
				_endCallback();*/
			}
			_drawNum++;
			var obj:Shape = new Shape();
			_inc_angle += Math.floor(360 / MAX_SHAPES);
			//obj.filters = [_shadow];

			//_controlA.move(Math.random() * (w - 50) + 10, Math.random() * (h - 50) + 10);
			//_controlB.move(Math.random() * (w - 50) + 10, Math.random() * (h - 50) + 10);
			//_controlA.move(Math.random() * (w - 50) + 10, (Math.random()  * (h * 0.5)));
			//_controlB.move(Math.random() * (w - 50) + 10, (Math.random()  * (h * 0.5)) + (h * 0.5 - 50));

			_controlA.move(Math.random() * w, Math.random() * h);
			_controlB.move(Math.random() * w, Math.random() * h);
			/*_controlA.x += 1920 - 300;
			_controlB.x += 1920 - 300;
			_controlA.y += 1080 - 200;
			_controlB.y += 1080 - 200;*/

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
			obj._object.bezier = new CubicBezier(_controlA.getCenterPoint(), obj._object.randomPointA, _controlB.getCenterPoint(), obj._object.randomPointB);
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
			var rgb:uint = getColour();
			obj.transform.colorTransform = new ColorTransform(0, 0, 0, 1, rgb >> 16, rgb >> 8 & 255, rgb & 255, 0);
			_container.addChild(obj);
			_shapes.push(obj);
		}

		private function setupGUI():void
		{
			_anchorA = new Handle(0xcc0000, true, null);
			addChild(_anchorA);

			_anchorB = new Handle(0xcc0000, true, null);
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

		private function stageKey(e:KeyboardEvent):void
		{
			if (e.keyCode != Keyboard.SPACE || e.keyCode != Keyboard.ENTER)
				return;
			if (e.keyCode == Keyboard.ENTER)
			{
				return;
			}
			if (_isPaused)
			{
				_paintInterval = setInterval(paint, 0);
				_requestIntervalID = setInterval(requestCircle, _spawnRate);
			}
			else
			{
				clearInterval(_requestIntervalID);
				clearInterval(_paintInterval);
			}
			_isPaused = !_isPaused;
		}

		private function update(c:Shape):void
		{
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
			if (c._object.inc <= 0.5)
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
			if (c._object.pos != null)
			{
				rotation = Math.atan2(pos.y - c._object.pos.y, pos.x - c._object.pos.y) * 180 / Math.PI;
				c.rotation = rotation;
			}
			c._object.pos = pos;
			//Check end
			if (c._object.inc >= _max)
			{
				_container.removeChild(c);
				_shapes.splice(_shapes.indexOf(c), 1);
				c._object = null;
				c = null;
				_inc_angle -= Math.floor(360 / MAX_SHAPES);
				if (_shapes.length == 0)
				{
					clearInterval(_requestIntervalID);
					clearInterval(_paintInterval);
					_endCallback();
				}
			}
		}
	}
}
