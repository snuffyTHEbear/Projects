package DrawingAPI
{
	import flash.display.GraphicsPath;
	import flash.display.GraphicsPathCommand;
	import flash.display.GraphicsSolidFill;
	import flash.display.GraphicsStroke;
	import flash.display.IGraphicsData;
	import flash.display.Sprite;
	
	public class GraphicsData1 extends Sprite
	{
		public function GraphicsData1()
		{
			var graphicsData:Vector.<IGraphicsData> = new Vector.<IGraphicsData>();
			
			var stroke:GraphicsStroke = new GraphicsStroke(5);
			stroke.fill = new GraphicsSolidFill(0xcc0000);
			
			var commands:Vector.<int> = new Vector.<int>();
			commands.push(GraphicsPathCommand.MOVE_TO);
			commands.push(GraphicsPathCommand.LINE_TO);
			
			var data:Vector.<Number> = new Vector.<Number>();
			data.push(100, 100);
			data.push(200,200);
			
			var path:GraphicsPath = new GraphicsPath(commands, data);
			
			graphicsData.push(stroke);
			graphicsData.push(path);
			graphics.drawGraphicsData(graphicsData);
		}
	}
}