package models
{
	import org.papervision3d.core.*;
	import org.papervision3d.core.geom.*;
	import org.papervision3d.core.geom.renderables.Triangle3D;
	import org.papervision3d.core.geom.renderables.Vertex3D;
	import org.papervision3d.core.math.NumberUV;
	import org.papervision3d.core.proto.*;

	public class Tower extends TriangleMesh3D
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

		public function Tower( material:MaterialObject3D=null, initObject:Object=null )
		{
			super(material, new Array(), new Array(), "");
			verts = this.geometry.vertices;
			faceAr= this.geometry.faces;
			uvs   =new Array();
			v(-10.0798,1.05679e-006,-1.51197);
			v(10.0798,5.59479e-007,-14.6157);
			v(-10.0798,1.05679e-006,1.51197);
			v(10.0798,5.59479e-007,14.6157);
			v(-10.0798,6.14821,-1.51197);
			v(10.0798,59.4327,-14.6157);
			v(-10.0798,6.14821,1.51197);
			v(10.0798,59.4327,14.6157);
			uv(0.0,0.0);
			uv(13.9508,0.0);
			uv(0.0,10.0519);
			uv(13.9508,10.0519);
			uv(0.0,0.0);
			uv(13.9508,0.0);
			uv(0.0,10.0519);
			uv(13.9508,10.0519);
			uv(0.0,0.0);
			uv(13.9508,0.0);
			uv(0.0,13.9508);
			uv(13.9508,13.9508);
			f(0,2,3,9,11,10);
			f(3,1,0,10,8,9);
			f(4,5,7,8,9,11);
			f(7,6,4,11,10,8);
			f(0,1,5,4,5,7);
			f(5,4,0,7,6,4);
			f(1,3,7,0,1,3);
			f(7,5,1,3,2,0);
			f(3,2,6,4,5,7);
			f(6,7,3,7,6,4);
			f(2,0,4,0,1,3);
			f(4,6,2,3,2,0);

			this.geometry.ready = true;
		}

	}

}