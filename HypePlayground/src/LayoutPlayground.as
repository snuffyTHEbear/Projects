package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import hype.extended.layout.ScatterLayout;
	
	public class LayoutPlayground extends Sprite
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;
		
		private var _layout:ScatterLayout;
		private var _shapes:Vector.<Sprite> = new Vector.<Sprite>();
		
		public function LayoutPlayground()
		{
			init();
		}
		private function init():void
		{
			_layout = new ScatterLayout(centreX, centreY, 30, 30);
			
			for(var i:uint = 0; i < 1; i++)
			{
				var shape:Sprite = new Sprite();
				shape.graphics.lineStyle(2, 0, 0.8);
				shape.graphics.drawCircle(0, 0, 30);
				
				shape.x = _layout.getNextPoint().x;
				shape.y = _layout.getNextPoint().y;
				
				addChild(shape);
				_shapes.push(shape);
			}
			addEventListener(Event.ENTER_FRAME, loop);
		}
		private function loop(e:Event):void
		{
			for(var i:uint = 0; i < _shapes.length; i++)
			{
				var pt:Point = _layout.getNextPoint();
				_shapes[i].x = pt.x;
				_shapes[i].y = pt.y;
			}
		}
	}
}