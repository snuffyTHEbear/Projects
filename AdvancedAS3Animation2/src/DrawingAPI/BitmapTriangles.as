package DrawingAPI
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class BitmapTriangles extends Sprite
	{
		private var vertices:Vector.<Number> = new Vector.<Number>();
		private var indices:Vector.<int> = new Vector.<int>();
		
		[Embed(source="assets/Garden.jpg")]
		private var ImageClass:Class;
		
		public function BitmapTriangles()
		{
			init();
		}
		private function init():void
		{
			vertices.push(100, 100);
			vertices.push(600, 100);
			vertices.push(700, 500);
			vertices.push(100, 200);
			
			indices.push(0, 1, 2);
			indices.push(2, 3, 0);
			
			var bitmap:Bitmap = new ImageClass() as Bitmap;
			graphics.beginBitmapFill(bitmap.bitmapData);
			graphics.drawTriangles(vertices, indices);
			graphics.endFill();
		}
	}
}