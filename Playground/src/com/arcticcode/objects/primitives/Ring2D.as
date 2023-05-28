package com.arcticcode.objects.primitives
{
	//http://www.nilab.info/cheapjap/000679.html
	import org.papervision3d.core.geom.TriangleMesh3D;
	import org.papervision3d.core.geom.renderables.Triangle3D;
	import org.papervision3d.core.geom.renderables.Vertex3D;
	import org.papervision3d.core.proto.MaterialObject3D;
	
	public class Ring2D extends TriangleMesh3D
	{
		public function Ring2D(material:MaterialObject3D = null, inRadius:Number = 80, exRadius:Number = 100, segments:int = 8)
		{
			
			super(material, new Array(), new Array(), null);
			buildRing2D(inRadius, exRadius, segments);
		}
		
		private function buildRing2D(inRadius:Number, exRadius:Number, segments:int):void
		{
			
			const density:int = segments;
			const rad:Number = degree2radian(360.0 / density);
			const half:Number = degree2radian(360.0 / density / 2.0);
			
			// internal circle
			var inVertices:Array = createVertices(density, rad, 0, inRadius);
			
			// external circle
			var exVertices:Array = createVertices(density, rad, half, exRadius);
			
			var faces:Array = new Array();
			for(var i:int = 0; i < density; i++)
			{
				// clockwise
				faces.push(new Triangle3D(this, [getVert(inVertices, i), getVert(exVertices, i), getVert(inVertices, i + 1)], material, null));
				faces.push(new Triangle3D(this, [getVert(exVertices, i), getVert(exVertices, i + 1), getVert(inVertices, i + 1)], material, null));
			}
			
			this.geometry.vertices = inVertices.concat(exVertices);
			this.geometry.faces = faces;
			this.projectTexture("x", "z");
			this.geometry.ready = true;
		}
		
		private static function getVert(a:Array, i:int):Object
		{
			if(a.length <= i)
			{
				i = i % a.length;
			}
			return a[i];
		}
		
		private static function createVertices(density:int, rad:Number, offsetRad:Number, radius:Number):Array
		{
			
			var v:Array = new Array();
			for(var i:int = 0; i < density; i++)
			{
				var angle:Number = (rad * i) + offsetRad;
				var x:Number = Math.cos(angle) * radius;
				var y:Number = Math.sin(angle) * radius;
				v.push(new Vertex3D(x, y, 0));
			}
			
			return v;
		}
		
		private static function degree2radian(degree:Number):Number
		{
			return degree / 180.0 * Math.PI;
		}
	
	}
}
