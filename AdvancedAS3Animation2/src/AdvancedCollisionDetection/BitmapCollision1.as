package AdvancedCollisionDetection
{
	import display.Star;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public class BitmapCollision1 extends Sprite
	{
		private var bmd1:BitmapData;
		private var b1:Bitmap;
		private var bmd2:BitmapData;
		private var b2:Bitmap;
		
		public function BitmapCollision1()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(e.type, init);
			
			var star:Star = new Star(50);
			
			bmd1 = new BitmapData(100, 100, true, 0);
			bmd1.draw(star, new Matrix(1, 0, 0, 1, 50, 50));
			b1 = addChild(new Bitmap(bmd1)) as Bitmap;
			b1.x = b1.y = 200;
			
			bmd2 = new BitmapData(100, 100, true, 0);
			bmd2.draw(star, new Matrix(1, 0, 0, 1, 50, 50));
			b2 = addChild(new Bitmap(bmd2)) as Bitmap;
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
		}
		
		
		private function mouseMove(e:MouseEvent):void
		{
			b2.x = mouseX - 50;
			b2.y = mouseY - 50;
			
			if(bmd1.hitTest(new Point(b1.x, b1.y), 255, bmd2, new Point(b2.x, b2.y), 255))
			{
				b1.filters = b2.filters = [new GlowFilter()];
			}
			else
			{
				b1.filters = b2.filters = [];
			}
		}
	}
}