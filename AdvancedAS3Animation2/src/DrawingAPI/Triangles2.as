package DrawingAPI
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Triangles2 extends Sprite
	{
		private var _vertices:Vector.<Number>;
		private var _indices:Vector.<int>;
		
		public function Triangles2()
		{
			_vertices = new Vector.<Number>();
			_vertices.push(100, 100);
			_vertices.push(200, 100);
			_vertices.push(200, 200);
			_vertices.push(100, 200);
			
			_indices = new Vector.<int>();
			_indices.push(0, 1, 2);
			_indices.push(2, 3, 0);
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void
		{
			
			
			graphics.clear();
			graphics.lineStyle(0, 1);
			graphics.drawTriangles(_vertices, _indices);
		}
	}
}