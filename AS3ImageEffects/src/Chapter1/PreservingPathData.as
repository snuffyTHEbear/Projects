package Chapter1
{
	import flash.display.GraphicsPath;
	import flash.display.GraphicsSolidFill;
	import flash.display.GraphicsStroke;
	import flash.display.IGraphicsData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	public class PreservingPathData extends Sprite
	{
		private static const INIT_THICKNESS:uint = 5;
		private static const MAX_THICKNESS:uint = 50;
		private static const MIN_THICKNESS:uint = 1;
		
		private var _thickness:uint;
		private var _drawing:Boolean;
		private var _commands:Vector.<IGraphicsData>;
		private var _lineStyle:GraphicsStroke;
		private var _currentPath:GraphicsPath;
		
		public function PreservingPathData()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(e.type, init);
			
			var color:uint = Math.random() * 0xFFFFFF;
			_thickness = INIT_THICKNESS;
			graphics.lineStyle(_thickness, color);
			_lineStyle = new GraphicsStroke(_thickness);
			_lineStyle.fill = new GraphicsSolidFill(color);
			_commands = new Vector.<IGraphicsData>();
			_commands.push(_lineStyle);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, stageMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, stageMouseUp);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, stageKeyDown);
		}
		
		private function redrawPath():void
		{
			graphics.clear();
			graphics.drawGraphicsData(_commands);
		}
		private function stageKeyDown(e:KeyboardEvent):void
		{
			if(!_drawing)
			{
				switch(e.keyCode)
				{
					case Keyboard.UP:
						if(_thickness < MAX_THICKNESS)
						{
							_lineStyle.thickness = ++_thickness;
							redrawPath();
						}
						break;
					
					case Keyboard.DOWN:
						if(_thickness > MIN_THICKNESS)
						{
							_lineStyle.thickness = --_thickness;
							redrawPath();
						}
						break;
					
					case Keyboard.SPACE:
						_lineStyle.fill = new GraphicsSolidFill(Math.random() * 0xFFFFFF);
						redrawPath();
						break;
				}
			}
		}
		private function stageMouseDown(e:MouseEvent):void
		{
			_drawing = true;
			var x:Number = stage.mouseX;
			var y:Number = stage.mouseY;
			_currentPath = new GraphicsPath();
			_currentPath.moveTo(x, y);
			_commands.push(_currentPath);
			graphics.moveTo(x, y);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stageMouseMove);
		}
		private function stageMouseMove(e:MouseEvent):void
		{
			var x:Number = stage.mouseX;
			var y:Number = stage.mouseY;
			_currentPath.lineTo(x, y);
			graphics.lineTo(x, y);
			e.updateAfterEvent();
		}
		private function stageMouseUp(e:MouseEvent):void
		{
			_drawing = false;
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, stageMouseMove);
		}
	}
}