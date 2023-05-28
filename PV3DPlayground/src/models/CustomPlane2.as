package models
{
	import org.papervision3d.core.geom.TriangleMesh3D;
	import org.papervision3d.core.geom.renderables.Triangle3D;
	import org.papervision3d.core.geom.renderables.Vertex3D;
	import org.papervision3d.core.math.NumberUV;
	import org.papervision3d.core.proto.MaterialObject3D;

	public class CustomPlane2 extends TriangleMesh3D
	{

		public var verts :Array;
		public var faceAr:Array;
		public var uvs :Array;

		private function v(x:Number,y:Number,z:Number):void
		{
			verts.push(new Vertex3D(x,y,z));
		}

		private function uv(u:Number,v:Number):void
		{
			uvs.push(new NumberUV(u,v));
		}

		private function f(vn0:int, vn1:int, vn2:int, uvn0:int, uvn1:int,uvn2:int):void
		{
			faceAr.push( new Triangle3D( this, [verts[vn0],verts[vn1],verts[vn2] ], null, [uvs[uvn0],uvs[uvn1],uvs[uvn2]] ) );
		}

		public function CustomPlane2( material:MaterialObject3D = null, initObject:Object = null)
		{
			super(material, new Array(), new Array(), new String());
			verts = this.geometry.vertices;
			faceAr = this.geometry.faces;
			uvs = new Array();
			v(-125.0,0.0,-125.0);
			v(125.0,0.0,-125.0);
			v(-125.0,0.0,125.0);
			v(125.0,0.0,125.0);
			uv(0.0,0.0);
			uv(250.0,0.0);
			uv(0.0,0.0);
			uv(250.0,0.0);
			uv(0.0,0.0);
			uv(250.0,0.0);
			uv(0.0,250.0);
			uv(250.0,250.0);
			f(2,0,3,6,4,7);
			f(1,3,0,5,7,4);

			this.geometry.ready = true;
		}

	}

}