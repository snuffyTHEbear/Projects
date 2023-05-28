package org.fly3D.display
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import org.fly3D.display.graphics.GraphicsOptions;
	import org.fly3D.geom.Triangle;
	
	[SWF(width=600, height = 400)]
	public class BasicScene extends Sprite
	{
		private var _vanishingPointX:Number;
		
		private var _vanishingPointY:Number;
		
		private var _focalLength:Number;
		
		private var _depthArray:Array;
		
		private var _objects:Array;
		
		private var _shapes:Array;
		
		private var _num3DObjects:uint = 0;
		
		private var _num3DShapes:uint = 0;
		
		private var _zoom:Number = 0;
		
		private var _pos:Point;
		
		//[TODO - Implement Camera?]
		private var _camera:Object;
		
		/**
		 *
		 * @param vanishingPointX
		 * @param vanishingPointY
		 * @param focalLength
		 *
		 */
		public function BasicScene(vanishingPointX:Number, vanishingPointY:Number, focalLength:Number = 250)
		{
			_vanishingPointX = vanishingPointX;
			_vanishingPointY = vanishingPointY;
			_focalLength = focalLength;
			_objects = new Array();
			_shapes = new Array();
			_depthArray = new Array();
			_pos = new Point(0, 0);
		}
		
		/**
		 *
		 * @param obj
		 * @return
		 *
		 */
		public function getScale(obj:*):Number
		{
			return _focalLength / (_focalLength + obj.position.z);
		}
		
		/**
		 *
		 * @param obj
		 *
		 */
		public function renderObject(obj:BasicDisplayObject3D):void
		{
			renderObjectToScreen(obj);
		}
		
		public function renderShape(shape:BasicShape3D):void
		{
			renderShapeToScreen(shape);
		}
		
		/**
		 *
		 * @param obj - Object to look at / bring into focus (psuedo camera?)
		 *
		 */
		public function lookAt(obj:BasicDisplayObject3D):void
		{
			this.x = vanishingPointX + -(obj.x);
			this.y = vanishingPointY + -(obj.y);
		}
		
		/**
		 *
		 *
		 */
		public function resetView():void
		{
			this.x = _pos.x;
			this.y = _pos.y;
		}
		
		/**
		 *
		 * @param amount - Amount to zoom the scene by
		 *
		 */
		public function zoom(amount:Number):void
		{
			//[TODO:Getter/Setter - Tweenable]
			_zoom = amount;
			for(var i:uint = 0; i < _num3DObjects; i++)
			{
				_objects[i].z += _zoom;
			}
		}
		
		//[TODO - graphics parameters (fill, alpha colors etc)]
		protected function renderTriangle(t:Triangle, go:GraphicsOptions):void
		{
			go.startDraw(t.color);
			go.g.moveTo(t.pointA.screenX, t.pointA.screenY);
			go.g.lineTo(t.pointB.screenX, t.pointB.screenY);
			go.g.lineTo(t.pointC.screenX, t.pointC.screenY);
			go.g.lineTo(t.pointA.screenX, t.pointA.screenY);
			go.g.endFill();
		}
		
		protected function renderShapeToScreen(shape:BasicShape3D):void
		{
			var i:uint = 0;
			var len:uint;
			var go:GraphicsOptions = shape.graphicsOptions;
			
			/*var g:Graphics = shape.graphics;
			   g.clear();
			   g.lineStyle(0);
			   g.moveTo(shape.points[_inc].screenX, shape.points[_inc].screenY);
			   for(_inc = 1; _inc < shape.numPoints; _inc++)
			   {
			   g.lineTo(shape.points[_inc].screenX, shape.points[_inc].screenY);
			   }
			   _inc = 0;
			 g.lineTo(shape.points[_inc].screenX, shape.points[_inc].screenY);*/
			
			if(shape.useTriangles)
			{
				shape.triangleDepthSort();
				go.g.clear();
				len = shape.triangles.length;
				
				for(i = 0; i < len; i++)
				{
					var t:Triangle = shape.triangles[i];
					
					if(!(t.isBackFace()) || (t.isBackFace()) && t.doubleSided)
					{
						if(t.pointA.z > -focalLength && t.pointB.z > -focalLength && t.pointC.z > -focalLength)
						{
							renderTriangle(t, go);
						}
						else
						{
							
						}
					}
				}
			}
			else
			{
				//[TODO draw to first point (join), draw points in reverse using shape3D reversePoints property]
				shape.graphics.clear();
				go.startDraw(go.lineColour);
				go.g.moveTo(shape.points[0].screenX, shape.points[0].screenY);
				
				if(go.type == GraphicsOptions.LINE)
				{
					len = shape.points.length;
					
					for(i = 1; i < len; i++)
					{
						go.g.lineTo(shape.points[i].screenX, shape.points[i].screenY);
					}
					if(shape.joinPoints)
					{
						go.g.lineTo(shape.points[0].screenX, shape.points[0].screenY);
					}
				}
				else if(go.type == GraphicsOptions.CURVE)
				{
					len = shape.points.length - 1;
					var val:uint;
					var ax:Number;
					var ay:Number;
					
					for(i = 0; i < len; i++)
					{
						ax = (shape.points[i].screenX + shape.points[i + 1].screenX) / 2;
						ay = (shape.points[i].screenY + shape.points[i + 1].screenY) / 2;
						go.g.curveTo(shape.points[i].screenX, shape.points[i].screenY, ax, ay);
					}
				}
			}
			
			//[TODO - Add callbacks to shape]
			if(shape.position.z > -focalLength)
			{
				var scale:Number = getScale(shape);
				shape.scaleX = shape.scaleY = scale;
				shape.x = _vanishingPointX + shape.position.x * scale;
				shape.y = _vanishingPointY + shape.position.y * scale;
				shape.visible = true;
			}
			else
			{
				shape.visible = false;
			}
		}
		
		/**
		 *
		 * @param obj
		 *
		 */
		protected function renderObjectToScreen(obj:BasicDisplayObject3D):void
		{
			if(obj.position.z > -_focalLength)
			{
				var scale:Number = getScale(obj);
				obj.scaleX = obj.scaleY = scale;
				obj.x = _vanishingPointX + obj.position.x * scale;
				obj.y = _vanishingPointY + obj.position.y * scale;
				
				if(obj.onRenderCallback != null)
				{
					obj.onRenderCallback(obj);
				}
				obj.visible = true;
			}
			else
			{
				if(obj.outOfViewCallback != null)
				{
					obj.outOfViewCallback(obj);
				}
				else
				{
					obj.visible = false;
				}
			}
		}
		
		/**
		 *
		 * @param child
		 * @return
		 *
		 */
		public function add3DObject(child:BasicDisplayObject3D):DisplayObject
		{
			child.scene = this;
			_objects.push(child);
			_depthArray.push(child);
			_num3DObjects++;
			return super.addChild(child);
		}
		
		/**
		 *
		 * @param child
		 * @return
		 *
		 */
		public function remove3DObject(child:BasicDisplayObject3D):DisplayObject
		{
			child.scene = null;
			_objects.splice(_objects.indexOf(child), 1);
			_depthArray.splice(_depthArray.indexOf(child), 1);
			_num3DObjects--;
			return super.removeChild(child);
		}
		
		public function add3DShape(child:BasicShape3D):DisplayObject
		{
			child.scene = this;
			_shapes.push(child);
			_depthArray.push(child);
			_num3DShapes++;
			return super.addChild(child);
		}
		
		public function remove3DShape(child:BasicShape3D):DisplayObject
		{
			child.scene = null;
			_shapes.splice(_shapes.indexOf(child), 1);
			_depthArray.splice(_depthArray.indexOf(child), 1);
			_num3DShapes--;
			return super.removeChild(child);
		}
		
		/**
		 *Sorts all objects and shapes within the depth array on z axis
		 *
		 */
		public function depthSort():void
		{
			//[TODO - Triangle depth sort?]
			_depthArray.sortOn("z", Array.DESCENDING | Array.NUMERIC);
			
			for(var i:uint = 0; i < _depthArray.length; i++)
			{
				if(_depthArray[i] is BasicShape3D)
				{
					_depthArray[i].triangleDepthSort();
				}
				setChildIndex(_depthArray[i], i);
			}
		}
		
		/**
		 *
		 *
		 */
		public function render():void
		{
			for(var i:uint = 0; i < _num3DObjects; i++)
			{
				renderObject(_objects[i]);
			}
			for(i = 0; i < _num3DShapes; i++)
			{
				renderShape(_shapes[i]);
			}
		}
		
		public function get vanishingPointX():Number
		{
			return _vanishingPointX;
		}
		
		public function set vanishingPointX(value:Number):void
		{
			_vanishingPointX = value;
		}
		
		public function get vanishingPointY():Number
		{
			return _vanishingPointY;
		}
		
		public function set vanishingPointY(value:Number):void
		{
			_vanishingPointY = value;
		}
		
		public function get focalLength():Number
		{
			return _focalLength;
		}
		
		public function set focalLength(value:Number):void
		{
			_focalLength = value;
		}
		
		public function get num3DObjects():uint
		{
			return _num3DObjects;
		}
		
		public function get num3DShapes():uint
		{
			return _num3DShapes;
		}
		
		public function set num3DShapes(value:uint):void
		{
			_num3DShapes = value;
		}
		
		public function startRendering():void
		{
			this.addEventListener(Event.ENTER_FRAME, loop);
		}
		
		public function stopRendering():void
		{
			this.removeEventListener(Event.ENTER_FRAME, loop);
		}
		
		protected function loop(e:Event):void
		{
		
		}
		
		/**
		 *
		 * @param degrees to be converted to radians
		 * @return - degress converted to radians
		 *
		 */
		public function degreesToRadians(degrees:Number):Number
		{
			return degrees * (Math.PI / 180);
		}
		
		/**
		 *
		 * @param radians to be converted to degrees
		 * @return radians converted to degress
		 *
		 */
		public function radiansToDegrees(radians:Number):Number
		{
			return radians * (180 / Math.PI);
		}
	
	}
}