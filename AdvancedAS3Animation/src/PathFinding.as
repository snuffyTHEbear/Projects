package
{
	public class PathFinding extends BasicStage
	{
		private var _grid:Grid;
		private var _gridView:GridView;
		
		public function PathFinding()
		{
			init();
		}
		private function init():void
		{
			_grid = new Grid(20,20);
			_grid.setStartNode(0,2);
			_grid.setEndNode(48,27);
			
			_gridView = new GridView(_grid,10);
			addChild(_gridView);
		}
	}
}