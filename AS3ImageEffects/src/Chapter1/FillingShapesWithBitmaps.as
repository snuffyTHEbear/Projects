package Chapter1
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	
	public class FillingShapesWithBitmaps extends Sprite
	{
		public function FillingShapesWithBitmaps()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(e.type, init);
			
			draw();
		}
		
		private function makeBitmapData():BitmapData
		{
			var bitmapData:BitmapData = new BitmapData(100, 100);
			bitmapData.perlinNoise(40, 40, 2, Math.random(), true, false);
			return bitmapData;
		}
		
		private function draw():void
		{
			var bitmapData:BitmapData = makeBitmapData();
			
			var width:Number = stage.stageWidth * 0.5;
			var height:Number = stage.stageHeight * 0.5;
			var radius:Number = 70;
			
			var shape:Shape = new Shape();
			with(shape.graphics)
			{
				beginBitmapFill(bitmapData);
				drawRoundRect(0, 0, width, height, radius, radius);
				endFill();
			}	
			addChild(shape);
			
			shape = new Shape();
			var matrix:Matrix = new Matrix();
			matrix.translate((width - bitmapData.width) / 2, (height - bitmapData.height) / 2);
			with(shape.graphics)
			{
				beginBitmapFill(bitmapData, matrix, false);
				drawRoundRect(0, 0, width, height, radius, radius);
				endFill();
			}
			shape.x = width;
			addChild(shape);
			
			shape = new Shape();
			matrix.rotate(Math.PI / 4);
			with(shape.graphics)
			{
				beginBitmapFill(bitmapData, matrix, false);
				drawRoundRect(0, 0, width, height, radius, radius);
				endFill();
			}
			shape.y = height;
			addChild(shape);
			
			shape = new Shape();
			matrix = new Matrix();
			matrix.scale(20, 20);
			with(shape.graphics)
			{
				beginBitmapFill(bitmapData, matrix, false);
				drawRoundRect(0, 0, width, height, radius, radius);
				endFill();
			}
			shape.x = width;
			shape.y = height;
			addChild(shape);
		}
	}
}