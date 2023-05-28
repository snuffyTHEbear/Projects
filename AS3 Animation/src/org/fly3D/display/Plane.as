package org.fly3D.display
{
	import org.fly3D.display.graphics.GraphicsOptions;
	import org.fly3D.geom.Light;
	import org.fly3D.geom.Point3D;
	
	
	public class Plane extends BasicShape3D
	{
		public static const LOW:uint = 2;
		
		public static const MEDIUM:uint = 4;
		
		public static const HIGH:uint = 8;
		
		public static const VERY_HIGH:uint = 16;
		
		/**
		 *Plane Width
		 */
		private var _planeWidth:Number;
		
		/**
		 *Plane Height
		 */
		private var _planeHeight:Number;
		
		private var _topLeft:Point3D;
		
		private var _topRight:Point3D;
		
		private var _bottomRight:Point3D;
		
		private var _bottomLeft:Point3D;
		
		private var _centre:Point3D;
		
		private var _centreTop:Point3D;
		
		private var _centreBottom:Point3D;
		
		private var _centreLeft:Point3D;
		
		private var _centreRight:Point3D;
		
		private var _halfCentreBottomLeft:Point3D;
		
		private var _halfCentreTopLeft:Point3D;
		
		private var _halfCentreTopRight:Point3D;
		
		private var _halfCentreBottomRight:Point3D;
		
		private var _doubleSided:Boolean = false;
		
		/**
		 *
		 * @param planeWidth
		 * @param planeHeight
		 * @param triangleCount
		 * @param light
		 * @param useTriangles
		 *
		 */
		public function Plane(planeWidth:Number = 50, planeHeight:Number = 50, triangleCount:uint = Plane.MEDIUM, light:Light = null, useTriangles:Boolean = true)
		{
			super(light, useTriangles);
			
			//No implementation of LOW or MEDIUM setup of points
			
			_planeHeight = planeHeight;
			_planeWidth = planeWidth;
			
			var w2:Number = _planeWidth / 2;
			var h2:Number = _planeHeight / 2;
			
			_centre = new Point3D(0, 0, 0);
			
			if(triangleCount == HIGH || triangleCount == VERY_HIGH)
			{
				_topLeft = new Point3D(-w2, -h2, 0);
				_topRight = new Point3D(w2, -h2, 0);
				_bottomRight = new Point3D(w2, h2, 0);
				_bottomLeft = new Point3D(-w2, h2, 0);
				
				_centreTop = new Point3D(0, -h2, 0);
				_centreBottom = new Point3D(0, h2, 0);
				_centreLeft = new Point3D(-w2, 0, 0);
				_centreRight = new Point3D(w2, 0, 0);
				
				if(triangleCount == VERY_HIGH)
				{
					var w3:Number = _planeWidth / 4;
					var h3:Number = _planeHeight / 4;
					
					_halfCentreBottomLeft = new Point3D(-w3, h3, 0);
					_halfCentreTopLeft = new Point3D(-w3, -h3, 0);
					_halfCentreTopRight = new Point3D(w3, -h3, 0);
					_halfCentreBottomRight = new Point3D(w3, h3, 0);
				}
			}
			else if(triangleCount == MEDIUM)
			{
				
			}
			else
			{
				
			}
			
			graphicsOptions = new GraphicsOptions(this.graphics, GraphicsOptions.FACES);
			
			build(triangleCount);
		}
		
		private function build(count:uint):void
		{
			//[TODO: use loop based generation of triangles]
			switch(count)
			{
				case LOW:
					addPoints2(_bottomLeft, _topLeft, _topRight, _bottomRight);
					buildTriangles([[0, 1, 2], [2, 3, 0]], true);
					setTriangleDoubleSided();
					break;
				
				case MEDIUM:
					addPoints2(_bottomLeft, _topLeft, _topRight, _bottomRight, _centre);
					buildTriangles([[0, 1, 4], [1, 2, 4], [2, 3, 4], [3, 0, 4]], true);
					setTriangleDoubleSided();
					break;
				
				case HIGH:
					addPoints2(_centreBottom, _bottomLeft, _centreLeft, _topLeft, _centreTop, _topRight, _centreRight, _bottomRight, _centre);
					buildTriangles([[0, 1, 8], [1, 2, 8], [2, 3, 8], [3, 4, 8], [4, 5, 8], [5, 6, 8], [6, 7, 8], [7, 0, 8]], true);
					setTriangleDoubleSided();
					break;
				
				case VERY_HIGH:
					addPoints2(_centreBottom, _bottomLeft, _centreLeft, _halfCentreBottomLeft, _topLeft, _centreTop, _halfCentreTopLeft, _topRight, _centreRight, _halfCentreTopRight, _bottomRight, _halfCentreBottomRight, _centre);
					buildTriangles([[0, 1, 3], [1, 2, 3], [2, 12, 3], [12, 0, 3],
									[12, 2, 6], [2, 4, 6], [4, 5, 6], [5, 12, 6],
									[8, 12, 9], [12, 5, 9], [5, 7, 9], [7, 8, 9],
									[10, 0, 11], [0, 12, 11], [12, 8, 11], [8, 10, 11]], true);
					setTriangleDoubleSided();
					break;
			}
		}
		
		public function get doubleSided():Boolean
		{
			return _doubleSided;
		}
		
		public function set doubleSided(value:Boolean):void
		{
			_doubleSided = value;
			setTriangleDoubleSided();
		}
		
		private function setTriangleDoubleSided():void
		{
			for(var i:uint = 0; i < triangles.length; i++)
			{
				triangles[i].doubleSided = _doubleSided;
			}
		}
	
	}
}