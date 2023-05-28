package org.fly3D.geom
{
	
	public class Triangle
	{
		private var _pointA:Point3D;
		
		private var _pointB:Point3D;
		
		private var _pointC:Point3D;
		
		private var _light:Light;
		
		private var _color:uint = 0xcc0000;
		
		private var _doubleSided:Boolean = false;
		
		private var _ab:Point3D;
		
		private var _bc:Point3D;
		
		private var _norm:Point3D;
		
		public function Triangle(a:Point3D, b:Point3D, c:Point3D, color:uint = 0xCC0000, light:Light = null)
		{
			_pointA = a;
			_pointB = b;
			_pointC = c;
			trace("Triangle: ", a, b, c);
			_color = color;
			_light = light;
		
		}
		
		private function getAdjustedColor(color:uint):uint
		{
			var red:Number = color >> 16;
			var green:Number = color >> 8 & 0xff;
			var blue:Number = color & 0xff;
			
			var lightFactor:Number = getLightFactor();
			
			red *= lightFactor;
			green *= lightFactor;
			blue *= lightFactor;
			
			return red << 16 | green << 8 | blue;
		}
		
		private function getLightFactor():Number
		{
			_ab = new Point3D(_pointA.x - _pointB.x, _pointA.y - _pointB.y, _pointA.z - _pointB.z);
			_bc = new Point3D(_pointB.x - _pointC.x, _pointB.y - _pointC.y, _pointB.z - _pointC.z);
			_norm = new Point3D(0, 0, 0);
			_norm.x = (_ab.y * _bc.z) - (_ab.z * _bc.y);
			_norm.y = -((_ab.x * _bc.z) - (_ab.z * _bc.x));
			_norm.z = (_ab.x * _bc.y) - (_ab.y * _bc.x);
			
			var dotProd:Number = _norm.x * _light.x + _norm.y * _light.y + _norm.z * _light.z;
			var normMag:Number = Math.sqrt(_norm.x * _norm.x + _norm.y * _norm.y + _norm.z * _norm.z);
			var lightMag:Number = Math.sqrt(_light.x * _light.x + _light.y * _light.y + _light.z * _light.z);
			return(Math.acos(dotProd / (normMag * lightMag)) / Math.PI) * _light.brightness;
		}
		
		public function isBackFace():Boolean
		{
			var cax:Number = _pointC.screenX - _pointA.screenX;
			var cay:Number = _pointC.screenY - _pointA.screenY;
			var bcx:Number = _pointB.screenX - _pointC.screenX;
			var bcy:Number = _pointB.screenY - _pointC.screenY;
			
			return cax * bcy > cay * bcx;
		}
		
		public function get depth():Number
		{
			var d:Number = Math.min(_pointA.z, _pointB.z);
			d = Math.min(d, _pointC.z);
			return d;
		}
		
		public function get pointA():Point3D
		{
			return _pointA;
		}
		
		public function set pointA(value:Point3D):void
		{
			_pointA = value;
		}
		
		public function get pointB():Point3D
		{
			return _pointB;
		}
		
		public function set pointB(value:Point3D):void
		{
			_pointB = value;
		}
		
		public function get pointC():Point3D
		{
			return _pointC;
		}
		
		public function set pointC(value:Point3D):void
		{
			_pointC = value;
		}
		
		public function get light():Light
		{
			return _light;
		}
		
		public function set light(value:Light):void
		{
			_light = value;
		}
		
		public function get color():uint
		{
			return getAdjustedColor(_color);
		}
		
		public function set color(value:uint):void
		{
			_color = value;
		}
		
		public function get doubleSided():Boolean
		{
			return _doubleSided;
		}
		
		public function set doubleSided(value:Boolean):void
		{
			_doubleSided = value;
		}
	}
}