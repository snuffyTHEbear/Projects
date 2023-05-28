package shapes
{
	import flash.display.Sprite;
	
	public class BasicShape extends Sprite
	{
		public static const CIRCLE:String = "circle";
		public static const RECT:String = "rect";
		public static const TRIANGLE:String = "triangle";
		
		public var xpos:Number = 0;
		public var ypos:Number = 0;
		public var zpos:Number = 0;
		
		private var _colour:uint;
		private var _type:String;
		
		public function BasicShape(type:String = BasicShape.CIRCLE, colour:uint = 0xcc0000)
		{
			_type = type;
			_colour = colour;
			init();
		}
		private function init():void
		{
			switch(_type)
			{
				case CIRCLE:
				drawCircle();
				break;
				
				case RECT:
				drawRect();
				break;
				
				case TRIANGLE:
				drawTriangle();
				break;
			}
		}
		private function drawCircle():void
		{
			graphics.beginFill(_colour, 0.85);
			graphics.drawCircle(0, 0, 10);
			graphics.endFill();
		}
		private function drawRect():void
		{
			graphics.beginFill(_colour, 0.85);
			graphics.drawRect(0, 0, 25, 25);
			graphics.endFill();
		}
		private function drawTriangle():void
		{
			graphics.beginFill(_colour, 0.85);
			
			graphics.endFill();
		}

		public function get type():String
		{
			return _type;
		}

		public function set type(v:String):void
		{
			_type = v;
			init();
		}

	}
}