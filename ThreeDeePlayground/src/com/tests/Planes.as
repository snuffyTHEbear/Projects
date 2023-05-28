package com.tests
{
	import com.arcticcode.greenFlames.ThreeDee.Planes.RectanglePlane;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	
	public class Planes extends Sprite
	{
		private var centreX:Number;
		private var centreY:Number;
		
		private var _plane:RectanglePlane;
		private var _focalLength:Number = 250;
		private var _a:Number = 0.05;
		private var _inc:Number = 0.05;
		
		public function Planes(centreX:Number, centreY:Number)
		{
			this.centreX = centreX;
			this.centreY = centreY;
			init();
		}
		private function init():void
		{
			_plane = new RectanglePlane(250, 250, centreX, centreY, 0xcc0000, 0);
			_plane.move(centreX, centreY);
			_plane.filters = [new DropShadowFilter(0, 90, 0, 1.0, 5.0, 5.0, 0.85, 3.0, false, false, false)];
			addChild(_plane);
			_plane.render();
			
			_plane.addEventListener(MouseEvent.MOUSE_OVER, planeOver);
			_plane.addEventListener(MouseEvent.MOUSE_OUT, planeOut);
			_plane.buttonMode = true;
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		private function planeOver(e:MouseEvent):void
		{
			_plane.colour = 0xcded43;
		}
		private function planeOut(e:MouseEvent):void
		{
			_plane.colour = 0xcc0000;
		}
		private function loop(e:Event):void
		{
			_plane.$rotationX = 
			_plane.$rotationY = 
			_plane.$rotationZ = 0.01; 
			_plane.render();
		}
	}
}