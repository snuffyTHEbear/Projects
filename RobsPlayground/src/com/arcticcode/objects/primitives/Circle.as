package com.arcticcode.objects.primitives
{
	//http://www.nilab.info/cheapjap/000679.html
	import org.papervision3d.core.geom.TriangleMesh3D;
	import org.papervision3d.core.geom.renderables.Triangle3D;
	import org.papervision3d.core.geom.renderables.Vertex3D;
	import org.papervision3d.core.proto.MaterialObject3D;
	
	
	public class Circle extends TriangleMesh3D
	{
		
		public function Circle(material:MaterialObject3D = null, radius:Number = 100, segments:int = 8)
		{
			super(material, new Array(), new Array(), null);
			buildCircle(radius, segments);
		}
		
		private function buildCircle(s:Number, segments:int):void
		{
			const density:int = segments + 2;
			const rad:Number = degree2radian(360.0 / density);
			
			var i:int;
			
			var vertices:Array = new Array();
			for(i = 0; i < density; i++)
			{
				var x:Number = Math.cos(rad * i) * s;
				var y:Number = Math.sin(rad * i) * s;
				vertices.push(new Vertex3D(x, y, 0));
			}
			
			var faces:Array = new Array();
			for(i = 1; i < vertices.length - 1; i++)
			{
				faces.push(new Triangle3D(this, [vertices[0], vertices[i], vertices[i + 1]], material, null));
			}
			
			this.geometry.vertices = vertices;
			this.geometry.faces = faces;
			this.projectTexture("x", "z");
			this.geometry.ready = true;
		}
		
		private static function degree2radian(degree:Number):Number
		{
			return degree / 180.0 * Math.PI;
		}
	
	}
}