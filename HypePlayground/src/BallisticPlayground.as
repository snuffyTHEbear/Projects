package
{
	import com.arcticcode.greenFlames.display.shapes.BasicShape;
	import com.arcticcode.greenFlames.display.shapes.ShapeUtils;
	
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	
	import hype.extended.behavior.SimpleBallistic;
	import hype.extended.color.ColorPool;
	import hype.extended.layout.ShapeLayout;
	import hype.extended.rhythm.FilterRhythm;
	import hype.extended.trigger.ExitShapeTrigger;
	import hype.extended.trigger.RandomTrigger;
	import hype.framework.core.ObjectPool;
	import hype.framework.core.TimeType;
	import hype.framework.display.BitmapCanvas;
	import hype.framework.rhythm.SimpleRhythm;
	
	[SWF(width = 640, height = 480, backgroundColor = 0x000000)]
	public class BallisticPlayground extends Sprite
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;
		
		private var _canvas:BitmapCanvas;
		private var _canvas2:BitmapCanvas;
		private var _colorPool:ColorPool;
		private var _container:Sprite;
		private var _exitShape:Sprite;
		private var _pool:ObjectPool;
		private var _rhythm:SimpleRhythm;
		private var _layout:ShapeLayout;
		private var _filterRhythm:FilterRhythm;
		private var _gravityAngle:Number = 90;
		
		public function BallisticPlayground()
		{
			init();
			initColorPool();
			initExitShape();
			initLayout();
			initCanvas();
			initContent();
			initRhythm();
			initFilterRhythm();
		}
		private function init():void
		{
			_container = new Sprite();
		}
		private function initColorPool():void
		{
			_colorPool = new ColorPool(0x6F7B1D, 0x9E9F2B, 0xBDBC35, 0xDDCB3A, 0xF6D16A, 0xF4DF9F, 0xF7EFD2, 0x422811, 0x853711, 0xC4520A, 0xE55F0A, 0xF67605, 0xF09724);
			//_colorPool = new ColorPool(0xE7854C, 0xE7714C, 0xE0491B, 0x63B2B9 , 0xACE5EB);
		}
		private function initCanvas():void
		{
			_canvas2 = new BitmapCanvas(stage.stageWidth, stage.stageHeight);
			_canvas = new BitmapCanvas(stage.stageWidth, stage.stageHeight);
			
			_canvas.startCapture(_container, true);
			_canvas2.startCapture(_canvas, true);
			
			addChild(_canvas2);
		}
		private function initLayout():void
		{
			var shape:Sprite = new Sprite();
			shape.graphics.beginFill(0x333333);
			shape.graphics.drawRect(10, 10, stage.stageWidth - 20, 10);
			shape.graphics.endFill();
			addChild(shape);
			shape.visible = false;
			
			_layout = new ShapeLayout(shape);
		}
		private function initContent():void
		{
			_pool = new ObjectPool(BasicShape, 200);
			
			_pool.onRequestObject = createObject;
		}
		private function initFilterRhythm():void
		{
			_filterRhythm = new FilterRhythm([new BlurFilter(1.5, 1.5, 1.0)], _canvas.bitmap.bitmapData);
			_filterRhythm.start(TimeType.TIME, 1);
		}
		private function initRhythm():void
		{
			_rhythm = new SimpleRhythm(addShape);
			_rhythm.start(TimeType.TIME, 100);
		}
		private function initExitShape():void
		{
			_exitShape = new Sprite();
			_exitShape.graphics.beginFill(0xCCCCCC);
			_exitShape.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			_exitShape.graphics.endFill();
			addChild(_exitShape);
			_exitShape.visible = false;
		}
		private function shapeExit(shape:BasicShape):void
		{
			_pool.release(shape);
			_container.removeChild(shape);
		}
		private function addShape(rhythm:SimpleRhythm):void
		{
			var shape:BasicShape = _pool.request() as BasicShape;
			
			if(shape != null)
			{
				_layout.applyLayout(shape);
				
				//shape.x = centreX;
				//shape.y = centreY - 100;
				
				shape.scaleX = shape.scaleY = 0.05 + (Math.floor(Math.random() * 3) * 0.3);
				
				// target Object, drag, minForce, maxForce, gravity, gravityAngle
				var ballistic:SimpleBallistic = new SimpleBallistic(shape, 0.97, 3, 3, 0.25, _gravityAngle);
				ballistic.start();
				
				// exit callback function, target Object, shape, shapeFlag
				var exitTrigger:ExitShapeTrigger = new ExitShapeTrigger(shapeExit, shape, _exitShape, true);
				exitTrigger.start();
				
				var randomTrigger:RandomTrigger = new RandomTrigger(splitShape, shape, 10);
				randomTrigger.start();
			}
		}
		
		private function splitShape(parentShape:BasicShape):void
		{
			var shape:BasicShape = _pool.request() as BasicShape;
			
			if(shape != null)
			{
				shape.move(parentShape.x, parentShape.y);
				shape.type = ShapeUtils.SQUARE;
				 shape.scaleX = shape.scaleY = 0.01 + (Math.floor(Math.random() * 3) * 0.01);
				 
				 _colorPool.colorObject(shape);
				 
				 // target Object, drag, minForce, maxForce, gravity, gravityAngle
				 var ballistic:SimpleBallistic = new SimpleBallistic(shape, 0.97, 3, 3, 0.25, _gravityAngle);
				 ballistic.start();
				 
				 // exit callback function, target Object, shape, shapeFlag
				 var exitTrigger:ExitShapeTrigger = new ExitShapeTrigger(shapeExit, shape, _exitShape, true);
				 exitTrigger.start();
			}
		}
		
		private function createObject(shape:BasicShape):BasicShape
		{
			shape.type = ShapeUtils.ROUNDED_SQUARE;
			shape.colour = _colorPool.getColor();
			shape.lineColour = _colorPool.getColor();
			//_colorPool.colorChild(shape);
			shape.x = centreX;
			shape.y = centreY;
			shape.drawCentre = false;
			_container.addChild(shape);
			
			//_gravityAngle += 0.5;
			
			return shape;
		}
	}
}