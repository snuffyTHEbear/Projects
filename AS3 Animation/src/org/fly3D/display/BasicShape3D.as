package org.fly3D.display
{
	import flash.display.Sprite;
	
	import org.fly3D.display.graphics.GraphicsOptions;
	import org.fly3D.geom.Light;
	import org.fly3D.geom.Point3D;
	import org.fly3D.geom.Triangle;
	
	public class BasicShape3D extends Sprite
	{
		/**
		 *Scene the BasicShape3D is in
		 */
		private var _scene:BasicScene;
		
		/**
		 *Position stored in a Point3D
		 */
		private var _position:Point3D;
		
		/**
		 *Number of points
		 */
		private var _numPoints:uint;
		
		/**
		 *Number of triangles
		 */
		private var _numTriangles:uint;
		
		/**
		 *Vector of points
		 */
		private var _points:Vector.<Point3D>;
		
		/**
		 *Array of triangles
		 */
		private var _triangles:Array;
		
		/**
		 *Dump object
		 */
		public var object:Object = {};
		
		/**
		 *Light
		 */
		private var _light:Light;
		
		/**
		 *Used to draw wireframes / lines and stil use the same points to draw models
		 */
		private var _useTriangles:Boolean;
		
		/**
		 *Draw the points in reverse
		 */
		private var _drawPointsReverse:Boolean = false;
		
		/**
		 *Join the points
		 */
		private var _joinPoints:Boolean = false;
		
		/**
		 *GraphicsOptions used to draw the triangles (Colors, bitmaps, etc)
		 */
		private var _graphicsOptions:GraphicsOptions;
		
		/**
		 *
		 * @param light - Light
		 * @param useTriangles
		 *
		 */
		public function BasicShape3D(light:Light = null, useTriangles:Boolean = true)
		{
			_position = new Point3D(0, 0, 0);
			_numPoints = 0;
			_numTriangles = 0;
			_points = new Vector.<Point3D>();
			_triangles = new Array();
			_light = light;
			_useTriangles = useTriangles;
		}
		
		/**
		 *Set the center points of all the points
		 * @param x
		 * @param y
		 * @param z
		 *
		 */
		public function setCenterPoint(x:Number, y:Number, z:Number):void
		{
			var i:uint;
			for(i = 0; i < _numPoints; i++)
			{
				_points[i].setCenter(x, y, z);
			}
		}
		
		/**
		 *Use only if not rendered with BasicScene - set the vanishing points of all the points
		 * @param vanishingPointX
		 * @param vanishingPointY
		 *
		 */
		public function setVanishingPoint(vanishingPointX:Number, vanishingPointY:Number):void
		{
			var i:uint;
			for(i = 0; i < _numPoints; i++)
			{
				_points[i].setVanishingPoint(vanishingPointX, vanishingPointY);
					//_points[_inc].setVanishingPoint(0, 0);
			}
		}
		
		override public function get z():Number
		{
			return _position.z;
		}
		
		override public function set z(val:Number):void
		{
			_position.z = val;
		}
		
		/**
		 * Move this object via the position (Point3D)
		 * @param x
		 * @param y
		 * @param z
		 *
		 */
		public function move(x:Number, y:Number, z:Number):void
		{
			_position.z = z;
			_position.x = x;
			_position.y = y;
			render();
		}
		
		/**
		 *Render this shape
		 *
		 */
		public function render():void
		{
			if(_scene)
			{
				_scene.renderShape(this);
			}
		}
		
		public function rotatePointsX(angle:Number):void
		{
			var i:uint;
			for(i = 0; i < _numPoints; i++)
			{
				_points[i].rotateX(angle);
			}
		}
		
		public function rotatePointsY(angle:Number):void
		{
			var i:uint;
			for(i = 0; i < _numPoints; i++)
			{
				_points[i].rotateY(angle);
			}
		}
		
		public function rotatePointsZ(angle:Number):void
		{
			var i:uint;
			for(i = 0; i < _numPoints; i++)
			{
				_points[i].rotateZ(angle);
			}
		}
		
		public function rotateX(angle:Number):void
		{
			_position.rotateX(angle);
		}
		
		public function rotateY(angle:Number):void
		{
			_position.rotateY(angle);
		}
		
		public function rotateZ(angle:Number):void
		{
			_position.rotateZ(angle);
		}
		
		/**
		 * Indexes of the points to build the triangles from.
		 * Array is filled with arrays of the amount of triangles to build
		 * each nested array contains three values referencing three points
		 * @param pointIndexes - e.g. Basic plane [[0, 1, 2], [2, 3, 0]]
		 * @param nested - [[0, 1, 2], [2, 3, 0]] / [0, 1, 2, 2, 3, 0]
		 *
		 */
		public function buildTriangles(pointIndexes:Array, nested:Boolean = true, doubleSided:Boolean = false):void
		{
			var len:uint = pointIndexes.length;
			var i:uint = 0;
			if(nested)
			{
				
				for(i = 0; i < len; i++)
				{
					addTriangle(new Triangle(_points[pointIndexes[i][0]], _points[pointIndexes[i][1]], _points[pointIndexes[i][2]], 0xcc0000, _light));
					_triangles[i].doubleSided = doubleSided;
				}
				
			}
			else
			{
				
				for(i = 0; i < len; i += 3)
				{
					addTriangle(new Triangle(_points[pointIndexes[i]], _points[pointIndexes[i + 1]], _points[pointIndexes[i + 2]], 0xCC0000, _light));
					_triangles[i].doubleSided = doubleSided;
				}
				
			}
		}
		
		/**
		 *Add a new triangle
		 * @param triangle - the new triangle
		 * @return - number of triangles currently stored
		 *
		 */
		public function addTriangle(triangle:Triangle):uint
		{
			_numTriangles++;
			_triangles.push(triangle);
			return _numTriangles;
		}
		
		/**
		 *Remove a triangle at the specified index
		 * @param index - index to remove the triangle from
		 * @return - the triangle that was removed
		 *
		 */
		public function removeTriangle(index:uint):Triangle
		{
			_numTriangles--;
			return _triangles.splice(index, 1)[0];
		}
		
		/**
		 * Values of the positions of each point to add
		 * Array is the length of the amount of points to add
		 * each nested array contains three values [x, y, z] to create the Point3D with
		 * @param pointValues - e.g. Basic plane [[-50, -50, 0], [50, -50, 0], [50, 50, 0], [-50, 50, 0]]
		 * @param nested - Point values are nested </br>( [[-50, -50, 0], [50, -50, 0], [50, 50, 0], [-50, 50, 0]] ) </br>or not</br> ( [-50, -50, 0, 50, -50, 0, 50, 50, 0, -50, 50, 0] )
		 * @return - number of points currently stores
		 *
		 */
		public function addPoints(pointValues:Array, nested:Boolean = true):uint
		{
			var len:uint = pointValues.length;
			var i:uint = 0;
			
			if(nested)
			{
				
				for(i = 0; i < len; i++)
				{
					addPoint(new Point3D(pointValues[i][0], pointValues[i][1], pointValues[i][2]));
				}
				
			}
			else
			{
				
				for(i = 0; i < len; i += 3)
				{
					addPoint(new Point3D(pointValues[i], pointValues[i + 1], pointValues[i + 2]));
				}
				
			}
			
			return _numPoints;
		}
		
		/**
		 *Add a new point
		 * @param point - the new point
		 * @return - number of points currently stored
		 *
		 */
		public function addPoint(point:Point3D):uint
		{
			_numPoints++;
			_points.push(point);
			return _numPoints;
		}
		
		/**
		 * Remove a point at the specified index
		 * @param index - index to remove the point from
		 * @return - the point that was removed
		 *
		 */
		public function removePoint(index:uint):Point3D
		{
			_numPoints--;
			return _points.splice(index, 1)[0];
		}
		
		/**
		 *Remove all points
		 *
		 */
		public function removeAllPoints():void
		{
			_numPoints = 0;
			_points.splice(0, _points.length - 1);
		}
		
		public function addPoints2(... rest):uint
		{
			var i:uint;
			for(i = 0; i < rest.length; i++)
			{
				trace("rest: ", rest[i]);
				addPoint(rest[i]);
			}
			return _numPoints;
		}
		
		public function incrementPoints(prop:String, increment:Number):void
		{
			var i:uint;
			for(i = 0; i < _numPoints; i++)
			{
				_points[i][prop] += increment;
			}
		}
		
		public function triangleDepthSort():void
		{
			_triangles.sortOn("depth", Array.DESCENDING | Array.NUMERIC);
		}
		
		public function get scene():BasicScene
		{
			return _scene;
		}
		
		public function set scene(value:BasicScene):void
		{
			_scene = value;
		}
		
		public function get position():Point3D
		{
			return _position;
		}
		
		public function set position(value:Point3D):void
		{
			_position = value;
		}
		
		public function get points():Vector.<Point3D>
		{
			return _points;
		}
		
		public function get numPoints():uint
		{
			return _numPoints;
		}
		
		public function get numTriangles():uint
		{
			return _numTriangles;
		}
		
		public function get triangles():Array
		{
			return _triangles;
		}
		
		public function get graphicsOptions():GraphicsOptions
		{
			return _graphicsOptions;
		}
		
		public function set graphicsOptions(value:GraphicsOptions):void
		{
			_graphicsOptions = value;
		}
		
		public function get light():Light
		{
			return _light;
		}
		
		public function set light(value:Light):void
		{
			_light = value;
		}
		
		public function get useTriangles():Boolean
		{
			return _useTriangles;
		}
		
		public function set useTriangles(value:Boolean):void
		{
			_useTriangles = value;
		}
		
		public function get drawPointsReverse():Boolean
		{
			return _drawPointsReverse;
		}
		
		public function set drawPointsReverse(value:Boolean):void
		{
			_drawPointsReverse = value;
		}
		
		public function get joinPoints():Boolean
		{
			return _joinPoints;
		}
		
		public function set joinPoints(value:Boolean):void
		{
			_joinPoints = value;
		}
	}
}