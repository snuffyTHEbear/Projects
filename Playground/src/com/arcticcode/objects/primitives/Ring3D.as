package com.arcticcode.objects.primitives
{
	//http://www.nilab.info/cheapjap/000679.html
	import org.papervision3d.core.geom.TriangleMesh3D;
	import org.papervision3d.core.geom.renderables.Triangle3D;
	import org.papervision3d.core.geom.renderables.Vertex3D;
	import org.papervision3d.core.proto.MaterialObject3D;
	
	public class Ring3D extends TriangleMesh3D
	{
		
		public function Ring3D(material:MaterialObject3D = null, inRadius:Number = 80, exRadius:Number = 100, depth:Number = 50, segments:int = 8)
		{
			
			super(material, new Array(), new Array(), null);
			buildRing3D(inRadius, exRadius, depth, segments);
		}
		
		private function buildRing3D(inRadius:Number, exRadius:Number, depth:Number, segments:int):void
		{
			const density:int = segments;
			const rad:Number = degree2radian(360.0 / density);
			const half:Number = degree2radian(360.0 / density / 2.0);
			
			// near side internal circle
			var nsInVertices:Array = createVertices(density, rad, 0, inRadius, depth / -2.0);
			
			// near side external circle
			var nsExVertices:Array = createVertices(density, rad, half, exRadius, depth / -2.0);
			
			// far side internal circle
			var fsInVertices:Array = createVertices(density, rad, 0, inRadius, depth / 2.0);
			
			// far side external circle
			var fsExVertices:Array = createVertices(density, rad, half, exRadius, depth / 2.0);
			
			var faces:Array = new Array();
			for(var i:int = 0; i < density; i++)
			{
				// clockwise
				// near side Ring2D
				faces.push(new Triangle3D(this, [getVert(nsInVertices, i), getVert(nsExVertices, i), getVert(nsInVertices, i + 1)], material, null));
				faces.push(new Triangle3D(this, [getVert(nsExVertices, i), getVert(nsExVertices, i + 1), getVert(nsInVertices, i + 1)], material, null));
				// far side Ring2D
				faces.push(new Triangle3D(this, [getVert(fsInVertices, i + 1), getVert(fsExVertices, i), getVert(fsInVertices, i)], material, null));
				faces.push(new Triangle3D(this, [getVert(fsInVertices, i + 1), getVert(fsExVertices, i + 1), getVert(fsExVertices, i)], material, null));
				// connection internal circles for far and near
				faces.push(new Triangle3D(this, [getVert(fsInVertices, i), getVert(nsInVertices, i), getVert(fsInVertices, i + 1)], material, null));
				faces.push(new Triangle3D(this, [getVert(nsInVertices, i), getVert(nsInVertices, i + 1), getVert(fsInVertices, i + 1)], material, null));
				// connection external circles for far and near
				faces.push(new Triangle3D(this, [getVert(nsExVertices, i), getVert(fsExVertices, i), getVert(nsExVertices, i + 1)], material, null));
				faces.push(new Triangle3D(this, [getVert(fsExVertices, i), getVert(fsExVertices, i + 1), getVert(nsExVertices, i + 1)], material, null));
			}
			
			this.geometry.vertices = nsInVertices.concat(nsExVertices, fsInVertices, fsExVertices);
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
		
		private static function createVertices(density:int, rad:Number, offsetRad:Number, radius:Number, depth:Number):Array
		{
			
			var v:Array = new Array();
			for(var i:int = 0; i < density; i++)
			{
				var angle:Number = (rad * i) + offsetRad;
				var x:Number = Math.cos(angle) * radius;
				var y:Number = Math.sin(angle) * radius;
				v.push(new Vertex3D(x, y, depth));
			}
			
			return v;
		}
		
		private static function degree2radian(degree:Number):Number
		{
			return degree / 180.0 * Math.PI;
		}
	
	}
}
