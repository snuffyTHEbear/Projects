package DrawingAPI
{
	import flash.display.GraphicsPathCommand;
	import flash.display.Sprite;
	
	public class CurveDrawing extends Sprite
	{
		private var commands:Vector.<int> = new Vector.<int>();
		private var data:Vector.<Number> = new Vector.<Number>();
		
		public function CurveDrawing()
		{
			init();
		}
		
		private function init():void
		{
			data.push(200, 200);
			
			data.push(250, 100);
			data.push(300, 200);
			
			data.push(400, 250);
			data.push(300, 300);
			
			data.push(250, 400);
			data.push(200, 300);
			
			data.push(100, 250);
			data.push(200, 200);
			
			commands.push(GraphicsPathCommand.MOVE_TO);
			commands.push(GraphicsPathCommand.CURVE_TO);
			commands.push(GraphicsPathCommand.CURVE_TO);
			commands.push(GraphicsPathCommand.CURVE_TO);
			commands.push(GraphicsPathCommand.CURVE_TO);
			
			graphics.lineStyle(0);
			graphics.drawPath(commands, data);
		}
	}
}