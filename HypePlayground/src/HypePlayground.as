package
{
	import com.arcticcode.greenFlames.display.shapes.BasicShape;
	
	import flash.display.Sprite;
	
	import hype.extended.behavior.FixedVibration;
	import hype.extended.behavior.VariableVibration;
	import hype.extended.trigger.ExitShapeTrigger;
	import hype.framework.behavior.AbstractBehavior;
	import hype.framework.behavior.BehaviorStore;
	import hype.framework.core.ObjectPool;
	import hype.framework.core.TimeType;
	import hype.framework.display.BitmapCanvas;
	import hype.framework.rhythm.SimpleRhythm;
	
	public class HypePlayground extends Sprite
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;
		
		private var _canvas:BitmapCanvas;
		private var _exitShape:Sprite;
		private var _container:Sprite;
		private var _pool:ObjectPool;
		private var _rhythm:SimpleRhythm;
		private var _colours:Array = new Array(0xE7854C, 0xE7714C, 0xE0491B, 0x63B2B9 , 0xACE5EB);
		
		public function HypePlayground()
		{
			init();
			initExitShape();
			initCanvas();
			initContent();
			initRhythm();
		}
		private function initCanvas():void
		{
			_canvas = new BitmapCanvas(stage.stageWidth, stage.stageHeight);
			addChild(_canvas);
			_canvas.startCapture(_container, true);
		}
		private function initContent():void
		{
			_pool = new ObjectPool(BasicShape, 200);
			
			_pool.onRequestObject = createObject;
		}
		private function initRhythm():void
		{
			_rhythm = new SimpleRhythm(addShape);
			_rhythm.start(TimeType.TIME, 1);
		}
		private function createObject(shape:BasicShape):void
		{
			shape.type = "roundedSquare";
			shape.colour = getColour();
			pos(shape, centreX, centreY);
			
			var vx:VariableVibration = new VariableVibration(shape, 'x', 0.99, 0.05, 20);
			var vy:VariableVibration = new VariableVibration(shape, 'y', 0.99, 0.05, 20);
			var fr:FixedVibration = new FixedVibration(shape, 'rotation', 0.9, 0.05, 0, 360, false);
			var fs:FixedVibration = new FixedVibration(shape, 'scale', 0.9, 0.05, 0.05, Math.ceil(Math.random() * 3) * 0.3, false);
			var fa:FixedVibration = new FixedVibration(shape, 'alpha', 0.9, 0.05, 0.0, 1.0, false);
			
			vx.start();
			vy.start();
			fr.start();
			fs.start();
			fa.start();
			
			var exitTrigger:ExitShapeTrigger = new ExitShapeTrigger(shapeExit, shape, _exitShape, true);
			exitTrigger.start();
			
			_container.addChild(shape);
		}
		private function initExitShape():void
		{
			_exitShape = new Sprite();
			_exitShape.graphics.beginFill(0xCCCCCC);
			//_exitShape.graphics.drawCircle(0, 0, 90);
			_exitShape.graphics.drawRect(-10, -10, stage.stageWidth + 10, stage.stageHeight + 10);
			_exitShape.graphics.endFill();
			addChild(_exitShape);
			//pos(_exitShape, centreX, centreY);
			_exitShape.visible = false;
		}
		private function shapeExit(shape:BasicShape):void
		{
			_pool.release(shape);
			_container.removeChild(shape);
		}
		private function addShape(rhythm:SimpleRhythm):void
		{
			_pool.request();
		}
		private function init():void
		{
			_container = new Sprite();
		}
		private function getColour():uint
		{
			return _colours[Math.floor(Math.random() * _colours.length)];
		}
		private function createBehavior(b:AbstractBehavior, name:String, interval:uint = 1):void
		{
			BehaviorStore.store(b, name);
			BehaviorStore.retrieve(b.target, name).start("enter_frame", interval);
		}
		private function pos(child:Sprite, x:Number, y:Number):void
		{
			child.x = x;
			child.y = y;
		}
	}
}