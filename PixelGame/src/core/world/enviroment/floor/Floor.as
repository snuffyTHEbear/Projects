package core.world.enviroment.floor
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	public class Floor extends Sprite
	{
		private var _floorPixels:Vector.<FloorPixel> = new Vector.<FloorPixel>();
		private var _numFloorPixels:int = 0;
		private var _bounds:Rectangle;
		
		public function Floor(numFloorPixels:int)
		{
			_numFloorPixels = numFloorPixels;
			init();
		}
		private function init():void
		{
			for(var i:int = 0 ;i < _numFloorPixels; i++)
			{
				var bfp:BasicFloorPixel = new BasicFloorPixel();
				bfp.move(i * 10 + bfp.width * 0.5, 0);
				addChild(bfp);
				_floorPixels.push(bfp);
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