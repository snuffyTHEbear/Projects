package
{
	import com.arcticcode.greenFlames.graphics.Colour24;
	import com.display.Circle;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	
	[SWF(width=1000, height = 600)]
	public class Circles extends Sprite
	{
		private static const PLUS:String = "plus";
		
		private static const MINUS:String = "minus";
		
		private var colour:Colour24
		
		private var circle:Circle;
		
		private var angleX:Number = 0;
		
		private var angleY:Number = 0;
		
		private var radius:Number = 50;
		
		private var angle:Number = 10;
		
		private var distance:Number = 0;
		
		private var incType:String = "plus";
		
		private var centreX:Number = stage.stageWidth * 0.5;
		
		private var centreY:Number = stage.stageHeight * 0.5;
		
		private var bmd:BitmapData = new BitmapData(stage.stageWidth, stage.stageHeight, true);
		
		private var b:Bitmap = new Bitmap(bmd);
		
		public function Circles()
		{
			stage.frameRate = 30;
			stage.scaleMode = "noScale";
			
			init();
		}
		
		private function init():void
		{
			circle = new Circle(0xCC0000, radius);
			//colour = new Colour24(circle.colour >> 16, circle.colour >> 8 & 0xFF, circle.colour & 0xFF);
			colour = new Colour24(0, 0, 0);
			colour.setRange(100, 150);
			addChild(circle);
			circle.filters = [new DropShadowFilter(5.0, 90, colour.colour, 1, 3, 3, 0.85, 3)];
			circle.move(centreX, centreY);
			
			//addChild(b);
			//colour.colour = 0x0000CC;
			//circle.colour = colour.colour;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			//colour.red += Math.random() * 20 - 10;
			//colour.green += Math.random() * 20 - 10;
			//colour.blue += Math.random() * 20 - 10;
			colour.modifyColour(num(), num(), num());
			var ds:DropShadowFilter = circle.filters[0] as DropShadowFilter;
			ds.color = colour.colour;
			ds.distance = distance;
			circle.filters = [ds];
			ds = null;
			distance += Math.sin(angle) * -10;
			angle += .4;
		}
		
		private function num():Number
		{
			return Math.random() * 50 - 25;
		}
	}
}