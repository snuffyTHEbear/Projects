package DrawingAPI
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class BitmapTrianglesUV3 extends Sprite
	{
		[Embed(source="assets/Garden.jpg")]
		private var _image:Class;
		
		private var vertices:Vector.<Number> = new Vector.<Number>();
		private var uvtData:Vector.<Number> = new Vector.<Number>();
		private var indices:Vector.<int> = new Vector.<int>();
		private var bitmap:Bitmap;
		private var res:Number;
		private var cols:int;
		private var rows:int;
		
		/**
		 * 
		 * @param resolution - Size of each triangle
		 * @param columns - Number of vertices across
		 * @param $rows - Number of vertices down
		 * 
		 */		
		public function BitmapTrianglesUV3(resolution:Number = 100, columns:int = 2, $rows:int = 2)
		{
			res = resolution;
			cols = columns;
			rows = $rows;
			
			bitmap = new _image() as Bitmap;
			makeTriangles();
			
			graphics.beginBitmapFill(bitmap.bitmapData);
			graphics.drawTriangles(vertices, indices, uvtData);
			graphics.endFill();
			
			graphics.lineStyle(0);
			graphics.drawTriangles(vertices, indices);
		}
		private function makeTriangles():void
		{
			for(var i:int = 0;i < rows;i++)
			{
				for(var j:int = 0;j<cols;j++)
				{
					vertices.push(j * res, i * res);
					uvtData.push(j / (cols - 1), i / (rows - 1));
					
					if(i < rows - 1 && j < cols - 1)
					{
						//first triangle
						indices.push(i * cols + j, i * cols + j + 1, (i + 1) * cols + j);
						//second triangle
						indices.push(i * cols + j + 1, (i + 1) * cols + j + 1, (i +1) * cols + j);
					}
				}
			}
		}
	}
}