package models
{
	import org.papervision3d.core.*;
	import org.papervision3d.core.geom.*;
	import org.papervision3d.core.geom.renderables.Triangle3D;
	import org.papervision3d.core.geom.renderables.Vertex3D;
	import org.papervision3d.core.math.NumberUV;
	import org.papervision3d.core.proto.*;

	public class Gengon extends TriangleMesh3D
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

		public function Gengon( material:MaterialObject3D=null, initObject:Object=null )
		{
			super(material, new Array(), new Array(), new String());
			verts = this.geometry.vertices;
			faceAr= this.geometry.faces;
			uvs   =new Array();
			v(0.0,87.0,0.0);
			v(259.434,87.0,-55.8342);
			v(259.434,87.0,55.8342);
			v(133.271,87.0,229.483);
			v(27.068,87.0,263.99);
			v(-177.068,87.0,197.662);
			v(-242.705,87.0,107.321);
			v(-242.705,87.0,-107.321);
			v(-177.068,87.0,-197.662);
			v(27.068,87.0,-263.99);
			v(133.271,87.0,-229.483);
			v(259.434,0.0,-55.8342);
			v(259.434,0.0,55.8342);
			v(133.271,0.0,229.483);
			v(27.068,0.0,263.99);
			v(-177.068,0.0,197.662);
			v(-242.705,0.0,107.321);
			v(-242.705,0.0,-107.321);
			v(-177.068,0.0,-197.662);
			v(27.068,0.0,-263.99);
			v(133.271,0.0,-229.483);
			v(0.0,0.0,0.0);
			uv(300.0,300.0);
			uv(559.434,244.166);
			uv(559.434,355.834);
			uv(433.271,529.483);
			uv(327.068,563.99);
			uv(122.932,497.662);
			uv(57.2949,407.321);
			uv(57.2949,192.679);
			uv(122.932,102.338);
			uv(327.068,36.0098);
			uv(433.271,70.5173);
			uv(0.0,87.0);
			uv(138.03,87.0);
			uv(352.671,87.0);
			uv(490.701,87.0);
			uv(705.342,87.0);
			uv(843.372,87.0);
			uv(1058.01,87.0);
			uv(1196.04,87.0);
			uv(1410.68,87.0);
			uv(1548.71,87.0);
			uv(1763.36,87.0);
			uv(0.0,0.0);
			uv(138.03,0.0);
			uv(352.671,0.0);
			uv(490.701,0.0);
			uv(705.342,0.0);
			uv(843.372,0.0);
			uv(1058.01,0.0);
			uv(1196.04,0.0);
			uv(1410.68,0.0);
			uv(1548.71,0.0);
			uv(1763.36,0.0);
			uv(559.434,244.166);
			uv(559.434,355.834);
			uv(433.271,529.483);
			uv(327.068,563.99);
			uv(122.932,497.662);
			uv(57.2949,407.321);
			uv(57.2949,192.679);
			uv(122.932,102.338);
			uv(327.068,36.0098);
			uv(433.271,70.5173);
			uv(300.0,300.0);
			f(0,1,2,0,1,2);
			f(0,2,3,0,2,3);
			f(0,3,4,0,3,4);
			f(0,4,5,0,4,5);
			f(0,5,6,0,5,6);
			f(0,6,7,0,6,7);
			f(0,7,8,0,7,8);
			f(0,8,9,0,8,9);
			f(0,9,10,0,9,10);
			f(0,10,1,0,10,1);
			f(1,11,12,11,22,23);
			f(1,12,2,11,23,12);
			f(2,12,13,12,23,24);
			f(2,13,3,12,24,13);
			f(3,13,14,13,24,25);
			f(3,14,4,13,25,14);
			f(4,14,15,14,25,26);
			f(4,15,5,14,26,15);
			f(5,15,16,15,26,27);
			f(5,16,6,15,27,16);
			f(6,16,17,16,27,28);
			f(6,17,7,16,28,17);
			f(7,17,18,17,28,29);
			f(7,18,8,17,29,18);
			f(8,18,19,18,29,30);
			f(8,19,9,18,30,19);
			f(9,19,20,19,30,31);
			f(9,20,10,19,31,20);
			f(10,20,11,20,31,32);
			f(10,11,1,20,32,21);
			f(11,21,12,33,43,34);
			f(12,21,13,34,43,35);
			f(13,21,14,35,43,36);
			f(14,21,15,36,43,37);
			f(15,21,16,37,43,38);
			f(16,21,17,38,43,39);
			f(17,21,18,39,43,40);
			f(18,21,19,40,43,41);
			f(19,21,20,41,43,42);
			f(20,21,11,42,43,33);

			this.geometry.ready = true;
		}

	}

}