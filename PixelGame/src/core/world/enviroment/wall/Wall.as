package core.world.enviroment.wall
{
	import core.world.enviroment.floor.FloorPixel;
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	public class Wall extends Sprite
	{
		private var _wallPixels:Vector.<FloorPixel> = new Vector.<FloorPixel>();
		private var _numWallPixels:int = 0;
		private var _bounds:Rectangle;
		
		public function Wall()
		{
			init();
		}
		private function init():void
		{
			for(var i:int = 0 ;i < _numWallPixels; i++)
			{
				var bwp:BasicWallPixel = new BasicWallPixel();
				/*var bfp:BasicFloorPixel = new BasicFloorPixel();
				bfp.move(i * 10 + bfp.width * 0.5, 0);
				addChild(bfp);
				_floorPixels.push(bfp);*/
			}
		}
		public function updateBounds():void
		{
			_bounds = new Rectangle(this.x, this.y, this.width, this.height);
		}
		public function move(x:Number, y:Number):void
		{
			super.x = x;
			super.y = y;
			updateBounds();
		}
		
		public function get bounds():Rectangle
		{
			return _bounds;
		}
	}
}