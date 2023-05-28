package DrawingAPI
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class BitmapTrianglesUV2 extends Sprite
	{
		private var handles:Vector.<Sprite> = new Vector.<Sprite>();
		private var indices:Vector.<int> = new Vector.<int>();
		private var uvData:Vector.<Number> = new Vector.<Number>();
		private var vertices:Vector.<Number> = new Vector.<Number>();
		private var b:Bitmap;
		
		[Embed(source="assets/Garden.jpg")]
		private var _imageClass:Class;
		
		public function BitmapTrianglesUV2()
		{
			init();
		}
		private function init():void
		{
			var pos:Array = new Array([100,100],[200,100],[200,200],[100,200]);
			for(var i:int = 0;i<4;i++)
			{
				handles.push(makeHandle(pos[i][0], pos[i][1]));
			}
			
			uvData.push(0,0);
			uvData.push(1,0);
			uvData.push(1,1);
			uvData.push(0,1);
			
			indices.push(0,1,2);
			indices.push(2,3,0);
			
			b = new _imageClass() as Bitmap;
			draw();
		}
		private function makeHandle(x:Number, y:Number):Sprite
		{
			var handle:Sprite = new Sprite();
			handle.graphics.beginFill(0);
			handle.graphics.drawCircle(0,0,5);
			handle.graphics.endFill();
			handle.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			handle.x = x;
			handle.y = y;
			addChild(handle);
			return handle;
		}
		private function onMouseDown(e:MouseEvent):void
		{
			e.target.startDrag();
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		private function onMouseMove(e:MouseEvent):void
		{
			draw();
		}
		private function onMouseUp(e:MouseEvent):void
		{
			stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		private function draw():void
		{
			vertices[0] = handles[0].x;
			vertices[1] = handles[0].y;
			vertices[2] = handles[1].x;
			vertices[3] = handles[1].y;
			vertices[4] = handles[2].x;
			vertices[5] = handles[2].y;
			vertices[6] = handles[3].x;
			vertices[7] = handles[3].y;
			
			graphics.clear();
			graphics.beginBitmapFill(b.bitmapData);
			graphics.drawTriangles(vertices,indices,uvData);
			graphics.endFill();
		}
	}
}