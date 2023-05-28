package org.fly3D.geom
{
	public class Point3D
	{
		public var focalLength:Number = 250;
		public var x:Number = 0;
		public var y:Number = 0;
		public var z:Number = 0;
		
		private var _vanishingPointX:Number = 0;
		private var _vanishingPointY:Number = 0;
		private var _centerX:Number = 0;
		private var _centerY:Number = 0;
		private var _centerZ:Number = 0;
		
		public function Point3D(x:Number, y:Number, z:Number)
		{
			this.x = x;
			this.y = y;
			this.z = z;
		}
		public function setVanishingPoint(vanishingPointX:Number, vanishingPointY:Number):void
		{
			this._vanishingPointX = vanishingPointX;
			this._vanishingPointY = vanishingPointY;
		}
		public function setCenter(centerX:Number, centerY:Number, centerZ:Number = 0):void
		{
			this._centerX = centerX;
			this._centerY = centerY;
			this._centerZ = centerZ;
		}
		public function get scale():Number
		{
			return focalLength / (focalLength + z + _centerZ);
		}
		public function get screenX():Number
		{
			return _vanishingPointX + ( _centerX + x ) * scale;
		}
		public function get screenY():Number
		{
			return _vanishingPointY + ( _centerY + y ) * scale;
		}
		public function rotateX(angleX:Number):void
		{
			var cosX:Number = Math.cos(angleX);
			var sinX:Number = Math.sin(angleX);
			var y1:Number = this.y * cosX - this.z * sinX;
			var z1:Number = this.z * cosX + this.y * sinX;
			this.y = y1;
			this.z = z1;
		}
		public function rotateY(angleY:Number):void
		{
			var cosY:Number = Math.cos(angleY);
			var sinY:Number = Math.sin(angleY);
			var x1:Number = this.x * cosY - this.z * sinY;
			var z1:Number = this.z * cosY + this.x * sinY;
			this.x = x1;
			this.z = z1;
		}
		public function rotateZ(angleZ:Number):void
		{
			var cosZ:Number = Math.cos(angleZ);
			var sinZ:Number = Math.sin(angleZ);
			var x1:Number = this.x * cosZ - this.y * sinZ;
			var y1:Number = this.y * cosZ + this.x * sinZ;
			this.x = x1;
			this.y = y1;
		}
	}
}