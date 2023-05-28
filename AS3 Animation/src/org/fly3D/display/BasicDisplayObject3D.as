package org.fly3D.display
{
	import flash.display.Sprite;
	
	import org.fly3D.geom.Point3D;
	
	public class BasicDisplayObject3D extends Sprite
	{
		private var _position:Point3D;
		private var _velocity:Point3D;
		private var _scene:BasicScene = null;
		/**
		 *Called when objects moves out of view (not rendered) 
		 */		
		public var outOfViewCallback:Function = null;
		public var onRenderCallback:Function = null;
		
		public var object:Object = {};
		
		public function BasicDisplayObject3D()
		{
			_position = new Point3D(0, 0, 0);
			_velocity = new Point3D(0, 0, 0);
			super();
		}
		
		override public function get z():Number
		{
			return _position.z;
		}
		
		override public function set z(val:Number):void
		{
			_position.z = val;
		}
		
		public function move(x:Number, y:Number, z:Number):void
		{
			_position.z = z;
			_position.x = x;
			_position.y = y;
			render();
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
		
		protected function render():void
		{
			if(scene)
			{
				scene.renderObject(this);
			}
		}
		
		public function applyVelocity():void
		{
			_position.x += _velocity.x;
			_position.y += _velocity.y;
			_position.z += _velocity.z;
		}

		public function get scene():BasicScene
		{
			return _scene;
		}

		public function set scene(value:BasicScene):void
		{
			_scene = value;
			render();
		}

		public function get position():Point3D
		{
			return _position;
		}

		public function set position(value:Point3D):void
		{
			_position = value;
		}

		public function get velocity():Point3D
		{
			return _velocity;
		}

		public function set velocity(value:Point3D):void
		{
			_velocity = value;
		}

	}
}