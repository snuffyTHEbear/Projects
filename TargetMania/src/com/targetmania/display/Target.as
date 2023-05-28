package com.targetmania.display
{
	import com.targetmania.core.TargetType;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Target extends Sprite
	{
		private var _type:String;
		
		public function Target(type:String = TargetType.RED_WHITE)
		{
			_type = type;
			
			init();
		}
		private function init():void
		{
			
		}
		private function hit(hitPoint:Point):void
		{
			//rotate to hit point then rotate on that point (3d rotation)
		}
	}
}