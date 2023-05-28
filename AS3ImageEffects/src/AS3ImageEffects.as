package
{
	import Chapter1.ChangingPointsOnAPath;
	import Chapter1.CopyingGraphics;
	import Chapter1.DrawTrianglesTest;
	import Chapter1.DrawingBitmapStrokes;
	import Chapter1.PreservingPathData;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width = 640, height = 550)]
	public class AS3ImageEffects extends Sprite
	{
		private var _exercise:Sprite;
		
		public function AS3ImageEffects()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void
		{
			removeEventListener(e.type, arguments.callee);
			
			_exercise = addChild(new DrawTrianglesTest()) as Sprite;
		}
	}
}