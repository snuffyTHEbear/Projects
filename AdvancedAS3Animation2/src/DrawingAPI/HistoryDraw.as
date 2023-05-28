package DrawingAPI
{
	import flash.display.GraphicsPath;
	import flash.display.GraphicsPathCommand;
	import flash.display.GraphicsSolidFill;
	import flash.display.GraphicsStroke;
	import flash.display.IGraphicsData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	public class HistoryDraw extends Sprite
	{
		private var graphicsData:Vector.<IGraphicsData> = new Vector.<IGraphicsData>();
		private var graphicsDataBuffer:Vector.<IGraphicsData> = new Vector.<IGraphicsData>();
		private var commands:Vector.<int>;
		private var data:Vector.<Number>;
		private var index:int = 0;
		
		public function HistoryDraw()
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
			var stroke:GraphicsStroke = new GraphicsStroke();
			stroke.thickness = Math.random() * 10;
			stroke.fill = new GraphicsSolidFill(Math.random() * 0xffffff);
			
			graphicsDataBuffer.push(stroke);
			
			index++;
			graphicsDataBuffer.length = index;
			
			commands = new Vector.<int>()
			commands.push(GraphicsPathCommand.MOVE_TO);
			
			data = new Vector.<Number>();
			data.push(mouseX, mouseY);
			
			graphics.lineStyle(0, 0, 0.5);
			graphics.lineTo(mouseX, mouseY);
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		private function onMouseMove(e:MouseEvent):void
		{
			commands.push(GraphicsPathCommand.LINE_TO);
			data.push(mouseX, mouseY);
			
			graphics.lineTo(mouseX, mouseY);
		}
		private function onMouseUp(e:MouseEvent):void
		{
			graphicsDataBuffer.push(new GraphicsPath(commands, data));
			
			index++;
			graphicsDataBuffer.length = index;
			
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			draw();
		}
		private function onKeyUp(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.LEFT)
			{
				index -= 2;
			}
			else if(e.keyCode == Keyboard.RIGHT)
			{
				index += 2;
			}
			
			index = Math.max(0, index);
			index = Math.min(graphicsDataBuffer.length, index);
			draw();
		}
		private function draw():void
		{
			graphicsData.length = 0;
			
			for(var i:int = 0;i<index;i++)
			{
				graphicsData[i] = graphicsDataBuffer[i];
			}
			
			graphics.clear();
			graphics.drawGraphicsData(graphicsData);
		}
	}
}