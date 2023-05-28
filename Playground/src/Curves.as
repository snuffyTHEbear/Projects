package
{
	/**
	 *[TODO?:Render grid based layout (squares / like rug in bathroom) and then paint a composition of it
	 * paint live video / camera video] 
	 * Live paint via mouse input or organic movement (mouse click start point and mouse up end point, position handles either side
	 */	
	import com.arcticcode.geom.CubicBezier;
	import com.arcticcode.greenFlames.graphics.CreateCircle;
	import com.arcticcode.visual.controls.Handle;
	import com.arcticcode.visual.shapes.Shape;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import hype.framework.core.ObjectPool;
	
	import net.hires.debug.Stats;
	
	[SWF(width = 1024, height = 640, frameRate = 60, backgroundColor = 0x000000)]
	public class Curves extends Sprite
	{
		[Embed(source = "../assets/Erik.jpg", mimeType = "image/jpeg" )]
		private var imageClass:Class;
		
		private var w:Number = stage.stageWidth;
		private var h:Number = stage.stageHeight;
		private var centreX:Number = w * 0.5;
		private var centreY:Number = h * 0.5;
		//Curve points
		private var _anchorA:Handle;
		private var _anchorB:Handle;
		//Start / End points
		private var _controlA:Handle;
		private var _controlB:Handle;
		private var _canvas:Bitmap;
		private var _bitmap:Bitmap;
		private var _blur:BlurFilter;
		private var _container:Sprite;
		private var _bezier:CubicBezier;
		private var _stats:Stats;
		//Used to draw the curve
		
		private var _rate:Number = 0.005;
		private var _position:Point = new Point();
		private var _inc:Number = 0;
		private var _min:uint = 0;
		private var _max:uint = 1;
		private var _colorTransform:ColorTransform = new ColorTransform(1, 1, 1, 0.5);
		private var _shapes:Vector.<Shape> = new Vector.<Shape>();
		private var _requestIntervalID:uint;
		private var _colours:Array = [0xE25C56, 0xE2BA56, 0xF0C0A8, 0xF0F0D8, 0xD8F0F0]; 
		//[15979865, 16107823, 14722323, 12684312, 12679940, 11496711, 10837508, 8933900, 7682570, 6769948, 8875564, 13156227, 14408609, 11114337, 8681288, 14154745, 11134186, 8504007, 6987937, 5275517, 3365980];
		
		private const START_SCALE_MIN:Number = 0.25;
		private const START_SCALE_MAX:Number = 0.5;
		private const MID_SCALE_MIN:Number = 0.5;
		private const MID_SCALE_MAX:Number = 3;
		private const END_SCALE_MIN:Number = 0.25;
		private const END_SCALE_MAX:Number = 0.5;
		private const MAX_SHAPES:uint = 30;
		
		public function Curves()
		{
			stage.scaleMode = "noScale";
			_bitmap = new imageClass();
			
			init();
		}
		private function getColour():uint
		{
			return _colours[Math.floor(Math.random() * _colours.length)];
		}
		private function init():void
		{
			setupGUI();
			
			/*_bezier = new CubicBezier(_controlA.getCenterPoint(),
									  _anchorA.getCenterPoint(),
									  _controlB.getCenterPoint(),
									  _anchorB.getCenterPoint());*/
			
			_container = new Sprite();
			_canvas = new Bitmap(new BitmapData(w, h, true, 0xff000000));
			addChild(_canvas);
			
			_blur =  new BlurFilter(3, 3, 1);
			
			//_pool = new ObjectPool(Shape, 30);
			//_pool.onRequestObject = requestCircle;
			//setInterval(_pool.request, 100);
			_requestIntervalID = setInterval(requestCircle, 100);
			
			setInterval(paint, 0);
			setInterval(blur, 50);
			
			_stats = new Stats();
			addChild(_stats);
		}
		private function setupGUI():void
		{
			_anchorA = new Handle(0xcc0000, true, null, 300, h);
			addChild(_anchorA);
			_anchorA.x = -600;
			_anchorA.y = centreY - 300;
			
			_anchorB = new Handle(0xcc0000, true, null, 300, h);
			addChild(_anchorB);
			_anchorB.x = w + 300;
			_anchorB.y = centreY - 300;
			
			_controlA = new Handle(0x00cc00, false);
			addChild(_controlA);
			_controlA.y = centreY;
			_controlA.x = centreX;
			
			_controlB = new Handle(0x00cc00, false);
			addChild(_controlB);
			_controlB.y = centreY;
			_controlB.x = centreX;
			
			_controlA.setInteractivity(false);
			_controlB.setInteractivity(false);
			_anchorA.setInteractivity(false);
			_anchorB.setInteractivity(false);
			
			_controlA.visible = _controlB.visible = _anchorA.visible = _anchorB.visible = false;
		}
		private function requestCircle():void
		{
			if(_shapes.length == MAX_SHAPES)
			{
				clearInterval(_requestIntervalID);
			}
			var obj:Shape = new Shape();
			
			/*var ct:ColorTransform = obj.transform.colorTransform;
			ct.color = getColour();
			obj.transform.colorTransform = ct;*/
			
			//obj.alpha = 0.1;
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
			//_canvas.bitmapData.fillRect(_canvas.bitmapData.rect, 0xffffff);
			_canvas.bitmapData.draw(_container);
			//_canvas.bitmapData.colorTransform(_canvas.bitmapData.rect, _colorTransform);
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
			if(c._object.inc <= 0.5)
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
				c._object.inc = 0;
				c.colour = getColour();
				c._object.randomPointA = _anchorA.getRandomPoint();
				c._object.randomPointB = _anchorB.getRandomPoint();
				c._object.bezier = new CubicBezier(_controlA.getCenterPoint(),
					c._object.randomPointA,
					_controlB.getCenterPoint(),
					c._object.randomPointB);
			}
		}
		private function drawCurve():void
		{					
			//Have draw function within CubicBezier / Util class?
			//Have moveObject(target, position) within CubicBEzier / Utils class?
			/*graphics.clear();
			graphics.lineStyle(0,0);
			
			var pos:Point = _bezier.getPoint(0);
			graphics.moveTo(pos.x, pos.y);
			var i:Number = 0;
			var rate:Number = 0.1;
			for(i = 0; i < 1; i += rate)
			{
				pos = _bezier.getPoint(i);
				graphics.lineTo(pos.x, pos.y);
			}*/
			
			/*
			//_bezier.updatePoints(_controlA.getCenterPoint(), _anchorA.getCenterPoint(),	_controlB.getCenterPoint(),	_anchorB.getCenterPoint());
			
			_inc += _rate;
			if(_inc <= _min)
			{
			_inc = _min;
			_rate *= -1;
			}
			else if(_inc >= _max)
			{
			_inc = 0;
			
			//_inc = _max;
			//_rate *= -1;
			}
			_position = _bezier.getPoint(_inc);
			*/
		}
	}
}