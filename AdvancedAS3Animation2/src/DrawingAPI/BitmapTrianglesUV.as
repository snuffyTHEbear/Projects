package DrawingAPI
{
	import flash.display.Bitmap;
	import flash.display.Sprite;

	public class BitmapTrianglesUV extends Sprite
	{
		private var vertices:Vector.<Number> = new Vector.<Number>();
		private var indices:Vector.<int> = new Vector.<int>();
		private var uvData:Vector.<Number> = new Vector.<Number>();
		
		[Embed(source="assets/Garden.jpg")]
		private var ImageClass:Class;
		
		public function BitmapTrianglesUV()
		{
			init();
		}
		private function init():void
		{
			vertices.push(10, 10);
			vertices.push(700, 10);
			vertices.push(700, 500);
			vertices.push(10, 500);
			
			uvData.push(0, 0);
			uvData.push(1, 0);
			uvData.push(1, 1);
			uvData.push(0, 1);
			
			indices.push(0, 1, 2);
			indices.push(2, 3, 0);
			
			var bitmap:Bitmap = new ImageClass() as Bitmap;
			graphics.beginBitmapFill(bitmap.bitmapData);
			graphics.drawTriangles(vertices, indices, uvData);
			graphics.endFill();
		}
	}
}