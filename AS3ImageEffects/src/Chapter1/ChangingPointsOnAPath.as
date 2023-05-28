package Chapter1
{
	import flash.display.GraphicsPathCommand;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ChangingPointsOnAPath extends Sprite
	{
		private const COLOR:uint = 0XFF;
		private const THICKNESS:uint = 3;
		
		private var _pathCommands:Vector.<int>;
		private var _pathData:Vector.<Number>;
		private var _anchors:Vector.<Sprite>;
		private var _anchor:Sprite;
		private var _anchorIndex:uint;
		
		public function ChangingPointsOnAPath()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(e.type, init);
			
			_anchors = new Vector.<Sprite>();
			_pathCommands = new Vector.<int>();
			_pathData = new Vector.<Number>();
			graphics.lineStyle(THICKNESS, COLOR);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, stageMouseDown);
		}
		
		private function addAnchor(x:Number, y:Number):void
		{
			var anchor:Sprite = new Sprite();
			anchor.graphics.lineStyle(20, Math.random() * 0xffffff);
			anchor.graphics.lineTo(1, 0);
			anchor.addEventListener(MouseEvent.MOUSE_DOWN, anchorMouseDown);
			anchor.addEventListener(MouseEvent.MOUSE_UP, anchorMouseUp);
			anchor.buttonMode = true;
			anchor.x = x;
			anchor.y = y;
			addChild(anchor);
			_anchors.push(anchor);
		}
		
		private function redrawPath():void
		{
			graphics.clear();
			graphics.lineStyle(THICKNESS, COLOR);
			graphics.drawPath(_pathCommands, _pathData);
			var dataLength:uint = _pathData.length;
			graphics.moveTo(_pathData[dataLength - 2], _pathData[dataLength - 1]);
		}
		
		private function anchorMouseDown(e:MouseEvent):void
		{
			_anchor = e.target as Sprite;
			_anchor.startDrag();
			_anchorIndex = _anchors.indexOf(_anchor);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, anchorMouseMove);
			e.stopPropagation();
		}
		
		private function anchorMouseMove(e:MouseEvent):void
		{
			_pathData[_anchorIndex * 2] = _anchor.x;
			_pathData[_anchorIndex * 2 + 1] = _anchor.y;
			redrawPath();
			e.updateAfterEvent();
		}
		
		private function anchorMouseUp(e:MouseEvent):void
		{
			if(_anchor)
			{
				_anchor.stopDrag();
				stage.removeEventListener(e.type, anchorMouseMove);
			}
		}
		
		private function stageMouseDown(e:MouseEvent):void
		{
			var x:Number = stage.mouseX;
			var y:Number = stage.mouseY;
			addAnchor(x, y);
			if(_pathCommands.length < 1)
			{
				_pathCommands.push(GraphicsPathCommand.MOVE_TO);
				graphics.moveTo(x, y);
			}
			else
			{
				_pathCommands.push(GraphicsPathCommand.LINE_TO);
				graphics.lineTo(x, y);
			}
			_pathData.push(x, y);
		}
	}
}