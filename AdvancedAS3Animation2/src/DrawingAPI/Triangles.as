package DrawingAPI
{
	import flash.display.Sprite;
	
	public class Triangles extends Sprite
	{
		private var vertices:Vector.<Number> = new Vector.<Number>();
		private var indices:Vector.<int> = new Vector.<int>();
		
		public function Triangles()
		{
			init();
		}
		private function init():void
		{
			vertices.push(100,100);
			vertices.push(200,100);
			vertices.push(200,200);
			vertices.push(100,200);
			
			indices.push(0,1,2);
			indices.push(2,3,0);
			
			graphics.lineStyle(0);
			graphics.drawTriangles(vertices, indices);
		}
	}
}