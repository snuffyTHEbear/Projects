package org.tests
{
	import caurina.transitions.Tweener;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	public class MouseGrid extends Sprite
	{
		private var _grid:Sprite;
		private var _rows:uint = 10;
		private var _cols:uint = 10;
		private var _wid:Number;
		private var _hei:Number;
		
		public function MouseGrid()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(e.type, init);
			
			_grid = addChild(new Sprite()) as Sprite;
			
			var i:int, j:int, wid:Number,hei:Number;
			_wid = stage.stageWidth / _rows;
			_hei = stage.stageHeight / _cols;
			for(i=0;i<_rows;i++)
			{
				
				for(j = 0 ; j < _cols;j++)
				{
					createSquare(i * _wid, j * _hei, _wid, _hei);
				}
			}
		}
		
		private function createSquare($x:Number, $y:Number, $width:Number, $height:Number):void
		{
			var s:Sprite = _grid.addChild(new Sprite()) as Sprite;
			s.x = $x;
			s.y = $y;
			//s.graphics.lineStyle(0,0xff0000);
			s.graphics.beginFill(0,1);
			s.graphics.drawRect(0,0,$width,$height);
			s.graphics.endFill();
			s.addEventListener(MouseEvent.MOUSE_OVER, squareOver);
		}
		
		private function squareOver(e:MouseEvent):void
		{
			var s:Sprite = e.currentTarget as Sprite;
			Tweener.addTween(s, {alpha:0, time:0.5, transition:"easeOutExpo"});
			s.addEventListener(MouseEvent.MOUSE_OUT, squareOut);
		}
		
		private function squareOut(e:MouseEvent):void
		{
			var s:Sprite = e.currentTarget as Sprite;
			Tweener.addTween(s, {alpha:1, time:1.5, transition:"easeOutExpo"});
			s.removeEventListener(e.type, squareOut);
		}
	}
}