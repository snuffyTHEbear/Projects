package com.arcticcode.geom
{
	import flash.geom.Point;
	/**
	 * 
	 * @author Robert Daniels
	 * 
	 */
	public class CubicBezier
	{
		private var _startControl:Point;
		private var _endControl:Point;
		private var _startAnchor:Point;
		private var _endAnchor:Point;
		private var _ax:Number;
		private var _ay:Number;
		private var _bx:Number;
		private var _by:Number;
		private var _cx:Number;
		private var _cy:Number;
		/**
		 * 
		 * @param startAnchor
		 * @param startControl
		 * @param endAnchor
		 * @param endControl
		 * 
		 */		
		public function CubicBezier(startAnchor:Point, startControl:Point, endAnchor:Point, endControl:Point)
		{
			_startAnchor = startAnchor;
			_startControl = startControl;
			_endControl = endControl;
			_endAnchor = endAnchor;
			_cx = 3 * (startControl.x - startAnchor.x);
			_bx = 3 * (endControl.x - startControl.x) - _cx;
			_ax = endAnchor.x - startAnchor.x - _cx - _bx;
			_cy = 3 * (startControl.y - startAnchor.y);
			_by = 3 * (endControl.y - startControl.y) - _cy;
			_ay = endAnchor.y - startAnchor.y - _cy - _by;
		}
		/**
		 * 
		 * @param position - Position on the CubicBezier (0 - 1)
		 * @return - new Point with the x and y coordinates of that position on the bezier
		 * 
		 */		
		public function getPoint(position:Number):Point
		{
			position = Math.max(0, Math.min(1, position));
			var numA:Number = position * position;
			var numB:Number = numA * position;
			var xpos:Number = _ax * numB + _bx * numA + _cx * position + _startAnchor.x;
			var ypos:Number = _ay * numB + _by * numA + _cy * position + _startAnchor.y;
			return new Point(xpos, ypos);
		}
		/**
		 * 
		 * @param startAnchor
		 * @param startControl
		 * @param endAnchor
		 * @param endControl
		 * 
		 */		
		public function updatePoints(startAnchor:Point, startControl:Point, endAnchor:Point, endControl:Point):void
		{
			_startAnchor = startAnchor;
			_startControl = startControl;
			_endControl = endControl;
			_endAnchor = endAnchor;
			_cx = 3 * (startControl.x - startAnchor.x);
			_bx = 3 * (endControl.x - startControl.x) - _cx;
			_ax = endAnchor.x - startAnchor.x - _cx - _bx;
			_cy = 3 * (startControl.y - startAnchor.y);
			_by = 3 * (endControl.y - startControl.y) - _cy;
			_ay = endAnchor.y - startAnchor.y - _cy - _by;
		}
	}
}