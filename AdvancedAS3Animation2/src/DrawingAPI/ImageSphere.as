package DrawingAPI
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.TriangleCulling;
	import flash.events.Event;
	
	public class ImageSphere extends Sprite
	{
		[Embed(source="map.jpg")]
		private var ImageClass:Class;
		
		private var vertices:Vector.<Number> = new Vector.<Number>();
		private var indices:Vector.<int> = new Vector.<int>();
		private var uvtData:Vector.<Number> = new Vector.<Number>();
		private var bitmap:Bitmap;
		private var sprite:Sprite;
		private var centreZ:Number = 500;
		private var cols:int = 19;
		private var rows:int = 20;
		private var focalLength:Number = 1000;
		private var offset:Number = 0;
		private var radius:Number = 400;
		
		public function ImageSphere()
		{
			sprite = new Sprite();
			sprite.x = 370;
			sprite.y = 290;
			addChild(sprite);
			
			bitmap = new ImageClass() as Bitmap;
			makeTriangles();
			draw();
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function draw():void
		{
			offset -= 0.03;
			vertices.length = 0;
			uvtData.length = 0;
			var i:int, j:int, angle:Number, angle2:Number, xpos:Number, ypos:Number, zpos:Number, scale:Number;
			
			for(i = 0;i < rows;i++)
			{
				for(j = 0;j<cols;j++)
				{
					angle = Math.PI * 2 / (cols - 1) * j;
					angle2= Math.PI * i / (rows - 1) - Math.PI / 2;
					
					xpos = Math.cos(angle + offset) * radius * Math.cos(angle2);
					ypos = Math.sin(angle2) * radius;
					zpos = Math.sin(angle + offset) * radius * Math.cos(angle2);
					
					scale = focalLength / (focalLength  + zpos + centreZ);
					
					vertices.push(xpos * scale, 
								  ypos * scale);
					
					uvtData.push(j / (cols - 1),
								 i / (rows - 1));
								 
					uvtData.push(scale);
				}
			}
			
			sprite.graphics.clear();
			sprite.graphics.lineStyle(0, 0xcc0000, 0.5);
			sprite.graphics.beginBitmapFill(bitmap.bitmapData);
			sprite.graphics.drawTriangles(vertices, indices, uvtData, TriangleCulling.NEGATIVE);
			sprite.graphics.endFill();
		}
		private function makeTriangles():void
		{
			var i:int, j:int;
			for(i = 0;i < rows;i++)
			{
				for(j = 0;j<cols;j++)
				{					
					if(i < rows - 1 && j < cols - 1)
					{
					indices.push(i * cols + j,
								 i * cols + j + 1, 
								(i + 1) * cols +j);
					indices.push(i * cols + j + 1,
								(i + 1) * cols + j + 1,
								(i + 1) * cols + j);
					}
				}
			}
		}
		private function onEnterFrame(e:Event):void
		{
			draw();
		}
	}
}