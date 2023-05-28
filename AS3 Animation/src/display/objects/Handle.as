package display.objects
{
	import flash.display.Sprite;
	
	public class Handle extends Sprite
	{
		private var _vx:Number = 0;
		private var _vy:Number = 0;
		public function Handle(drawHandle:Boolean = true)
		{
			if(drawHandle)
				draw();
		}
		
		private function draw():void
		{
			graphics.beginFill(0xcc0000);
			graphics.drawRect(-10, -10, 20, 20);
			graphics.endFill();
		}
		
		public function move(x:Number, y:Number):void
		{
			this.x = x;
			this.y = y;
		}
		
		public function get vy():Number
		{
			return _vy;
		}
		
		public function set vy(value:Number):void
		{
			_vy = value;
		}
		
		public function get vx():Number
		{
			return _vx;
		}
		
		public function set vx(value:Number):void
		{
			_vx = value;
		}
	}
}