package DrawingAPI
{
	import flash.display.GraphicsPathCommand;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	public class PathSketch extends Sprite
	{
		private var commands:Vector.<int> = new Vector.<int>();
		private var data:Vector.<Number> = new Vector.<Number>();
		
		private var lineWidth:Number = 0;
		private var lineColor:uint = 0;
		
		public function PathSketch()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void
		{
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		private function onMouseDown(e:MouseEvent):void
		{
			commands.push(GraphicsPathCommand.MOVE_TO);
			data.push(mouseX, mouseY);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			draw();
		}
		private function onMouseMove(e:MouseEvent):void
		{
			commands.push(GraphicsPathCommand.LINE_TO);
			data.push(mouseX, mouseY);
			draw();
		}
		private function onMouseUp(e:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		private function onKeyUp(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.DOWN)
			{
				lineWidth = Math.max(0, lineWidth - 1);
			}
			else if(e.keyCode == Keyboard.UP)
			{
				lineWidth = Math.min(50, lineWidth + 1);
			}
			else if(e.keyCode == Keyboard.SPACE)
			{
				lineColor = Math.random() * 0xffffff;
			}
			draw();
		}
		private function draw():void
		{
			graphics.clear();
			graphics.lineStyle(lineWidth, lineColor);
			graphics.drawPath(commands, data);
		}
	}
}