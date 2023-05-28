package com.arcticcode.objects.primitives
{
	import org.papervision3d.core.geom.TriangleMesh3D;
	import org.papervision3d.core.geom.renderables.Triangle3D;
	import org.papervision3d.core.geom.renderables.Vertex3D;
	import org.papervision3d.core.proto.MaterialObject3D;
	
	public class Triangle extends TriangleMesh3D
	{
		private var _width:Number, _height:Number, _cx:Number, _cy:Number;
		
		public function Triangle(material:MaterialObject3D = null, width:Number = 100, height:Number = 50)
		{
			super(material, new Array(), new Array(), null);
			_width = width;
			_height = height;
			_cx = _width * 0.5;
			_cy = _height * 0.5;
			buildTriangle(_width, _height);
		}
		private function destroy():void
		{
			this.geometry.faces = new Array();
			this.geometry.vertices = new Array();
		}
		private function buildTriangle(w:Number, h:Number):void
		{
			destroy();
			this.geometry.ready = false;
			this.geometry.vertices.push(new Vertex3D(-_cx, _cy, 0), new Vertex3D(-_cx, -_cy, 0), new Vertex3D(_cx, _cy, 0));
			this.geometry.faces.push(new Triangle3D(this, this.geometry.vertices, material, null));
			this.projectTexture("x", "y");
			this.geometry.ready = true;
		}

		public function get $width():Number
		{
			return _width;
		}

		public function set $width(value:Number):void
		{
			_width = value;
			_cx = _width * 0.5;
			buildTriangle(_width, _height);
		}

		public function get $height():Number
		{
			return _height;
		}

		public function set $height(value:Number):void
		{
			_height = value;
			_cy = _height * 0.5;
			buildTriangle(_width, _height);
		}
	}
}