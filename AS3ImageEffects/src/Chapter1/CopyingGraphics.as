package Chapter1
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.engine.Kerning;
	import flash.ui.Keyboard;
	
	import mx.core.UIComponentDescriptor;
	
	public class CopyingGraphics extends Sprite
	{
		private static const INIT_SEGMENTS:uint = 10;
		private static const MAX_SEGMENTS:uint = 20;
		private static const MIN_SEGMENTS:uint = 3;
		private static const THICKNESS:uint = 1;
		private static const COLOR:uint = 0x66CCCC;
		private static const ROTATION_RATE:uint = 1;
		
		private var _shapeHolder:Sprite;
		private var _shapes:Vector.<Shape>;
		
		public function CopyingGraphics()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(e.type, init);
			
			_shapeHolder = new Sprite();
			_shapeHolder.x = stage.stageWidth * 0.5;
			_shapeHolder.y = stage.stageHeight * 0.5;
			addChild(_shapeHolder);
			
			_shapes = new Vector.<Shape>();
			for(var i:uint = 0 ; i < INIT_SEGMENTS; i++)
			{
				addSegment();
			}
			
			positionSegments();
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, stageMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, stageMouseUp);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, stageKeyDown);
			
			//filters = [new GlowFilter(COLOR)];
		}
		
		private function draw():void
		{
			var shape:Shape = _shapes[0];
			shape.graphics.lineTo(stage.mouseX, stage.mouseY);
			var segments:uint = _shapeHolder.numChildren;
			for(var i:uint = 1; i < segments; i++)
			{
				_shapes[i].graphics.copyFrom(shape.graphics);
			}
		}
		private function addSegment():void
		{
			var shape:Shape = new Shape();
			if(_shapes.length > 0)
			{
				shape.graphics.copyFrom(_shapes[0].graphics);
			}
			else
			{
				shape.graphics.lineStyle(THICKNESS, COLOR);
				shape.filters = [new GlowFilter(0xCC0000)];
			}
			_shapes.push(shape);
			_shapeHolder.addChild(shape);
		}
		private function removeSegment():void
		{
			var shape:Shape = _shapes.pop();
			_shapeHolder.removeChild(shape);
		}
		private function positionSegments():void
		{
			var segments:uint = _shapeHolder.numChildren;
			var angle:Number = 360 / segments;
			for(var i:uint = 1;i < segments; i++)
			{
				_shapes[i].rotation = angle * i;
			}
		}
		private function stageMouseDown(e:MouseEvent):void
		{
			var shape:Shape = _shapes[0];
			shape.graphics.moveTo(shape.mouseX, shape.mouseY);
			addEventListener(Event.ENTER_FRAME, loop);
		}
		private function stageMouseUp(e:MouseEvent):void
		{
			removeEventListener(Event.ENTER_FRAME, loop);
		}
		private function loop(e:Event):void
		{
			_shapeHolder.rotation += ROTATION_RATE;
			draw();
		}
		private function stageKeyDown(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
				case Keyboard.UP:
					if(_shapeHolder.numChildren < MAX_SEGMENTS)
					{
						addSegment();
						positionSegments();
					}
					break;
				
				case Keyboard.DOWN:
					if(_shapeHolder.numChildren > MIN_SEGMENTS)
					{
						removeSegment();
						positionSegments();
					}
			}
		}
	}
}