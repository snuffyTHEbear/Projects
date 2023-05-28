package ThreeDee
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class Test3D extends Sprite
	{
		private var shape:Shape;
		
		public function Test3D()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void
		{
			removeEventListener(e.type, init);
			
			stage.addEventListener(Event.RESIZE, stageResize);
			
			shape = new Shape();
			shape.graphics.beginFill(0xcc0000);
			shape.graphics.drawRect(-100, -100, 200, 200);
			shape.graphics.endFill();
			shape.x = stage.stageWidth * 0.5;
			shape.y = stage.stageHeight * 0.5;
			addChild(shape);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function stageResize(e:Event):void
		{
			root.transform.perspectiveProjection.projectionCenter = new Point(stage.stageWidth * 0.5, stage.stageHeight * 0.5);
			
			if(shape != null)
			{
				shape.x = stage.stageWidth * 0.5;
				shape.y = stage.stageHeight * 0.5;
			}
		}
		
		private function onEnterFrame(e:Event):void
		{
			shape.rotationY += 2;
		}
	}
}