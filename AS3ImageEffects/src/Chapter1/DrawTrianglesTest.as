package Chapter1
{
	import flash.display.Sprite;
	import flash.display.TriangleCulling;
	import flash.events.Event;
	
	public class DrawTrianglesTest extends Sprite
	{
		public function DrawTrianglesTest()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(e.type, init);
			
			var vertices:Vector.<Number> = new Vector.<Number>();
			vertices.push(100, 50, 
						150, 100, 
						50, 100, 
						100, 150);
			
			var indices:Vector.<int> = new Vector.<int>();
			indices.push(0, 1, 2, 
						1, 2, 3);
			
			graphics.lineStyle(0);
			graphics.beginFill(Math.random() * 0xFFFFFF);
			graphics.drawTriangles(vertices, indices, null, TriangleCulling.NONE);
			graphics.endFill();
		}
	}
}