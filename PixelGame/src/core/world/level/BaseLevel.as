package core.world.level
{
	import core.player.human.PixelChar;
	import core.world.enviroment.floor.Floor;
	import core.world.enviroment.floor.FloorPixel;
	import core.world.enviroment.wall.Wall;
	
	import flash.display.Sprite;
	
	public class BaseLevel extends Sprite
	{
		private var _floor:Floor;
		private var _wall:Wall;
		private var _stageWidth:Number;
		private var _stageHeight:Number;
		private var _floorY:Number;
		private var _floorX:Number;
		private var _numFloorPixels:int = 0;
		private var _floorPixels:Vector.<FloorPixel> = new Vector.<FloorPixel>();
		
		public function BaseLevel(stageWidth:Number, stageHeight:Number)
		{
			_stageHeight = stageHeight;
			_stageWidth = stageWidth;
			_floorY = _stageHeight - 5;
			_floorX = 0;
			_numFloorPixels = _stageWidth / 10 + 1;
			
			createFloor();
			createWall();
		}
		private function createFloor():void
		{
			_floor = new Floor(_numFloorPixels + 1);
			_floor.move(0, _stageHeight - 5);
			addChild(_floor);
		}
		private function createWall():void
		{
			_wall = new Wall();
			_wall.move(75, _stageHeight - 10);
			addChild(_wall);
		}
		public function checkWalls(char:PixelChar):void
		{
			if(char.x <= (char.width * 0.5))
			{
				char.x = char.width * 0.5;
			}
			else if(char.x >= _stageWidth - (char.width * 0.5))
			{
				char.x = _stageWidth - (char.width * 0.5);
			}
		}
		public function checkFloor(char:PixelChar):void
		{
			if(char.y >= _floor.bounds.y - (_floor.bounds.height * 0.5))
			{
				char.y = _floor.bounds.y - (_floor.bounds.height * 0.5);
				if(char.jumping && char.frame != PixelChar.LAND && char.vx == 0)
				{
					char.frame = PixelChar.LAND;
				}
				else if(char.jumping && char.frame != PixelChar.WALK && char.vx != 0)
				{
					char.frame = PixelChar.WALK;
				}
			}
		}

		public function get floorY():Number
		{
			return _floor.y;
		}
	}
}