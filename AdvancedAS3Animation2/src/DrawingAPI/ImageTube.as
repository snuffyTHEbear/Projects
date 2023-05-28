package DrawingAPI
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.TriangleCulling;
	import flash.events.Event;
	
	public class ImageTube extends Sprite
	{
		[Embed(source="assets/Garden.jpg")]
		private var _image:Class;
		
		private var vertices:Vector.<Number> = new Vector.<Number>();
		private var indices:Vector.<int> = new Vector.<int>();
		private var uvtData:Vector.<Number> = new Vector.<Number>();
		private var bitmap:Bitmap;
		private var sprite:Sprite;
		private var res:Number = 30;
		private var rows:int = 15;
		private var cols:int = 30;
		private var centreZ:Number = 200;
		private var focalLength:Number = 250;
		private var radius:Number = 200;
		private var offset:Number = 0;
		
		public function ImageTube()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			sprite = new Sprite();
			sprite.x = 400;
			sprite.y = 310;
			addChild(sprite);
			
			bitmap = new _image() as Bitmap;
			makeTriangles();
			draw();
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function draw():void
		{
			offset += 0.004;
			//offset += (stage.stageWidth * 0.5 - mouseX) * .0001;
			vertices.length = 0;
			uvtData.length = 0;
			
			for(var i:int = 0;i < rows;i++)
			{
				for(var j:int = 0;j<cols;j++)
				{
					var angle:Number = Math.PI * 2 / (cols - 1) * j + offset;
					
					var xpos:Number = Math.cos(angle) * radius;
					var ypos:Number = (i - rows / 2) * res;
					var zpos:Number = Math.sin(angle) * radius;
					
					var scale:Number = focalLength / (focalLength  + zpos + centreZ);
					
					vertices.push(xpos * scale, 
								  ypos * scale);
					
					uvtData.push(j / (cols - 1),
								 i / (rows - 1));
								 
					uvtData.push(scale);
				}
			}
			
			sprite.graphics.clear();
			//sprite.graphics.lineStyle(0);
			sprite.graphics.beginBitmapFill(bitmap.bitmapData);
			sprite.graphics.drawTriangles(vertices, indices, uvtData, TriangleCulling.NEGATIVE);
			sprite.graphics.endFill();
			
			//sprite.graphics.lineStyle(0, 0, 0.5);
			//sprite.graphics.drawTriangles(vertices, indices, uvtData, TriangleCulling.NEGATIVE);
		}
		private function makeTriangles():void
		{
			for(var i:int = 0;i < rows;i++)
			{
				for(var j:int = 0;j<cols;j++)
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