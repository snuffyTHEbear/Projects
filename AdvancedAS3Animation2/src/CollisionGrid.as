package
{
	import __AS3__.vec.Vector;
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.events.EventDispatcher;

	public class CollisionGrid extends EventDispatcher
	{
		private var _checks:Vector.<DisplayObject>;
		private var _grid:Vector.<Vector.<DisplayObject>>;
		private var _width:Number;
		private var _height:Number;
		private var _numCells:int;
		private var _numRows:int;
		private var _numCols:int;
		private var _gridSize:Number;
		
		public function CollisionGrid(w:Number,h:Number,gs:Number)
		{
			_width = w;
			_height = h;
			_gridSize = gs;
			_numCols = Math.ceil(_width/_gridSize);
			_numRows = Math.ceil(_height/_gridSize);
			_numCells = _numCols *_numRows;
		}
		public function drawGrid(g:Graphics):void
		{
			g.lineStyle(0.5,0xcccccc);
			for(var i:int=0;i<=_width;i+=_gridSize)
			{
				g.moveTo(i,0);
				g.lineTo(i,_height);
			}
			for(i=0;i<_height;i+=_gridSize)
			{
				g.moveTo(0,i);
				g.lineTo(_width,i);
			}
		}
		public function check(objects:Vector.<DisplayObject>):void
		{
			var numObjects:int = objects.length;
			_grid = new Vector.<Vector.<DisplayObject>>(_numCells);
			_checks = new Vector.<DisplayObject>();
			for(var i:int = 0;i< numObjects;i++)
			{
				var obj:DisplayObject = objects[i];
				var index:int = Math.floor(obj.y / _gridSize) * _numCols + Math.floor(obj.x / _gridSize);
				if(_grid[index] == null)
				{
					_grid[index] = new Vector.<DisplayObject>;
				}
				_grid[index].push(obj);
			}
			checkGrid();
		}
		private function checkGrid():void
		{
			for(var i:int=0;i<_numCols;i++)
			{
				for(var j:int=0;j<_numRows;j++)
				{
					checkOneCell(i,j);
					checkTwoCells(i,j,i+1,j);
					checkTwoCells(i,j,i-1,j+1);
					checkTwoCells(i,j,i,j+1);
					checkTwoCells(i,j,i+1,j+1);
				}
			}
		}
		private function checkOneCell(x:int,y:int):void
		{
			var cell:Vector.<DisplayObject> = _grid[y*_numCols+x];
			if(cell==null)return;
			var cellLength:int = cell.length;
			for(var i:int = 0;i<cellLength-1;i++)
			{
				var objA:DisplayObject = cell[i];
				for(var j:int = i+1;j<cellLength;j++)
				{
					var objB:DisplayObject = cell[j];
					_checks.push(objA,objB);
				}
			}
		}
		private function checkTwoCells(x1:Number,y1:Number,x2:Number,y2:Number):void
		{
			if(x2>=_numCols||x2<0||y2>=_numRows)return;
			var cellA:Vector.<DisplayObject> = _grid[y1 * _numCols + x1];
			var cellB:Vector.<DisplayObject> = _grid[y2 * _numCols + x2];
			if(cellA == null|| cellB == null)return;
			
			var cellALength:int = cellA.length;
			var cellBLength:int = cellB.length;
			
			for(var i:int = 0;i < cellALength;i++)
			{
				var objA:DisplayObject = cellA[i];
				for(var j:int = 0;j<cellBLength;j++)
				{
					var objB:DisplayObject = cellB[j];
					_checks.push(objA,objB);
				}
			}
		}
		public function get checks():Vector.<DisplayObject>
		{
			return _checks;
		}
	}
}