package objects
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class BasicObject extends Sprite
	{
		private var _aiObjects:Array = new Array(circleA, hexagonA, rectA, rectB, lineA, lineB, lineC, lineD, lineE, lineF, lineG, lineH, lineI, lineJ);
		private var _doodle:MovieClip;
		
		public function BasicObject()
		{
			init();
		}
		private function init():void
		{
			_doodle = new _aiObjects[Math.floor(Math.random() * _aiObjects.length)] as MovieClip;
			addChild(_doodle);
			_doodle.x -= _doodle.width * 0.5;
			_doodle.y -= _doodle.height * 0.5;
		}
		public function move(x:Number, y:Number):void
		{
			super.x = x;
			super.y = y;
		}

		public function get doodle():MovieClip
		{
			return _doodle;
		}

		public function newDoodle():void
		{
			removeChild(_doodle);
			_doodle = null;
			init();
		}
	}
}