package DrawingAPI
{
	import flash.display.GraphicsPathCommand;
	import flash.display.Sprite;
	
	public class Paths extends Sprite
	{
		private var data:Vector.<Number>;
		private var commands:Vector.<int>;
		
		public function Paths()
		{
			init();
		}
		private function init():void
		{
			commands = new Vector.<int>();
			commands[0] = GraphicsPathCommand.MOVE_TO;
			commands[1] = GraphicsPathCommand.LINE_TO;
			
			data = new Vector.<Number>();
			data[0] = 100;
			data[1] = 100;
			data[2] = 250;
			data[3] = 200;
			
			graphics.lineStyle(0);
			graphics.drawPath(commands, data);
		}
	}
}