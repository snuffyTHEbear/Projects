package {
	import com.examples.shapes.Circle;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	[SWF(width=640,height=480,backgroundColor=0xffffff)]
	public class Main extends Sprite
	{
		private var circle:Circle;
		private var r1:Number=0;
		private var r2:Number=0;
		private var g1:Number=0;
		private var g2:Number=0;
		private var b1:Number=0;
		private var b2:Number=0;
		
		public function Main()
		{
			init();
		}
		private function init():void
		{
			circle = new Circle();
			addChild(circle);
			circle.x = stage.stageWidth * 0.5;
			circle.y = stage.stageHeight * 0.5;
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		private function genColor():uint
		{
			var red:uint = (255 * (r1 * (r2 - r1))) << 16;
			var green:uint = (255 * (g1 * (g2 - g1))) << 8;
			var blue:uint = (255 * (b1 * (b2 - b1)));
			return new uint(red | green | blue);
		}
		private function loop(e:Event):void
		{
			circle.color = genColor();
			circle.draw();
		}
		private function clone(source:*):*
		{
			var copier:ByteArray = new ByteArray();
			copier.writeObject(source);
			copier.position = 0;
			return (copier.readObject());
		}
	}
}