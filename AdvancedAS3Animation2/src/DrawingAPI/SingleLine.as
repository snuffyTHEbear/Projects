package DrawingAPI
{
	import flash.display.GraphicsPathCommand;
	import flash.display.Sprite;
	
	public class SingleLine extends Sprite
	{
		public function SingleLine()
		{
			var commands:Vector.<int> = new Vector.<int>();
			commands[0] = GraphicsPathCommand.MOVE_TO;
			commands[1] = GraphicsPathCommand.LINE_TO;
			
			var data:Vector.<Number> = new Vector.<Number>();
			data[0] = 100;
			data[1] = 100;
			data[2] = 250;
			data[3] = 200;
			
			graphics.lineStyle(0);
			graphics.drawPath(commands, data);
		}
	}
}