package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class GridView extends Sprite
	{
		private var _cellSize:int = 20;
		private var _grid:Grid;
		
		public function GridView(grid:Grid,cellSize:int=20)
		{
			_grid = grid;
			_cellSize = cellSize;
			drawGrid();
			findPath();
			addEventListener("click", onGridClick);
		}
		public function set cellSize(val:int):void
		{
			_cellSize = val;
		}
		public function drawGrid():void
		{
			graphics.clear();
			for(var i:int=0;i<_grid.numCols;i++)
			{
				for(var j:int=0;j<_grid.numRows;j++)
				{
					var node:Node = _grid.getNode(i,j);
					graphics.lineStyle(0);
					graphics.beginFill(getColor(node));
					graphics.drawRect(i*_cellSize,j*_cellSize, _cellSize, _cellSize);
				}
			}
		}
		private function getColor(node:Node):uint
		{
			if(!node.walkable)return 0;
			if(node == _grid.startNode) return 0x666666;
			if(node == _grid.endNode) return 0x666666;
			return 0xffffff;
		}
		
		private function onGridClick(e:MouseEvent):void
		{
			var xpos:int = Math.floor(e.localX / _cellSize);
			var ypos:int = Math.floor(e.localY / _cellSize);
			
			_grid.setWalkable(xpos,ypos,!_grid.getNode(xpos,ypos).walkable)
			drawGrid();
			findPath();
		}
		private function findPath():void
		{
			var astar:AStar = new AStar();
			if(astar.findPath(_grid))
			{
				showVisited(astar);
				showPath(astar);
			}
		}
		private function showVisited(astar:AStar):void
		{
			var visited:Array = astar.visited;
			for(var i:int=0;i<visited.length;i++)
			{
				graphics.beginFill(0xcccccc);
				graphics.drawRect(visited[i].x*_cellSize, visited[i].y*_cellSize,_cellSize,_cellSize);
			}
		}
		private function showPath(astar:AStar):void
		{
			var path:Array = astar.path;
			for(var i:int=0;i<path.length;i++)
			{
				graphics.lineStyle(0);
				graphics.beginFill(0);
				graphics.drawCircle(path[i].x*_cellSize+_cellSize/2,
									path[i].y*_cellSize+_cellSize/2,
									_cellSize/3);
			}
		}
	}
}