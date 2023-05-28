package models
{
	import org.papervision3d.core.*;
	import org.papervision3d.core.geom.*;
	import org.papervision3d.core.geom.renderables.Triangle3D;
	import org.papervision3d.core.geom.renderables.Vertex3D;
	import org.papervision3d.core.math.NumberUV;
	import org.papervision3d.core.proto.*;

	public class Cove extends TriangleMesh3D
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

		public function Cove( material:MaterialObject3D=null, initObject:Object=null )
		{
			super(material, new Array(), new Array(), new String());
			verts = this.geometry.vertices;
			faceAr= this.geometry.faces;
			uvs   =new Array();
			v(0.0,22.9641,0.0);
			v(-30.7076,22.9641,0.0);
			v(-30.7076,22.9641,-16.4615);
			v(0.0,22.9641,-16.4615);
			v(0.0,22.9641,-2.88078);
			v(-27.8268,22.9641,-2.88078);
			v(-27.8268,22.9641,-13.5807);
			v(0.0,22.9641,-13.5807);
			v(0.0,22.9641,0.0);
			v(-30.7076,22.9641,0.0);
			v(-30.7076,22.9641,-16.4615);
			v(0.0,22.9641,-16.4615);
			v(0.0,22.9641,-13.5807);
			v(-27.8268,22.9641,-13.5807);
			v(-27.8268,22.9641,-2.88078);
			v(0.0,22.9641,-2.88078);
			v(0.0,0.0,0.0);
			v(-30.7076,0.0,0.0);
			v(-30.7076,0.0,-16.4615);
			v(0.0,0.0,-16.4615);
			v(0.0,0.0,-13.5807);
			v(-27.8268,0.0,-13.5807);
			v(-27.8268,0.0,-2.88078);
			v(0.0,0.0,-2.88078);
			v(0.0,0.0,0.0);
			v(-30.7076,0.0,0.0);
			v(-30.7076,0.0,-16.4615);
			v(0.0,0.0,-16.4615);
			v(0.0,0.0,-2.88078);
			v(-27.8268,0.0,-2.88078);
			v(-27.8268,0.0,-13.5807);
			v(0.0,0.0,-13.5807);
			uv(0.0,0.0);
			uv(30.7076,0.0);
			uv(30.7076,16.4615);
			uv(0.0,16.4615);
			uv(0.0,2.88078);
			uv(27.8268,2.88078);
			uv(27.8268,13.5807);
			uv(0.0,13.5807);
			uv(0.0,22.9641);
			uv(30.7076,22.9641);
			uv(47.1691,22.9641);
			uv(77.8768,22.9641);
			uv(80.7576,22.9641);
			uv(108.584,22.9641);
			uv(119.284,22.9641);
			uv(147.111,22.9641);
			uv(0.0,0.0);
			uv(30.7076,0.0);
			uv(47.1691,0.0);
			uv(77.8768,0.0);
			uv(80.7576,0.0);
			uv(108.584,0.0);
			uv(119.284,0.0);
			uv(147.111,0.0);
			uv(0.0,16.4615);
			uv(30.7076,16.4615);
			uv(30.7076,0.0);
			uv(0.0,14.2461);
			uv(0.0,13.5807);
			uv(27.8268,13.5807);
			uv(27.8268,2.88078);
			uv(0.0,17.1269);
			uv(149.992,22.9641);
			uv(149.992,0.0);
			f(4,0,1,4,0,1);
			f(4,1,5,4,1,5);
			f(5,1,2,5,1,2);
			f(5,2,6,5,2,6);
			f(6,2,3,6,2,3);
			f(6,3,7,6,3,7);
			f(8,16,17,8,16,17);
			f(8,17,9,8,17,9);
			f(9,17,18,9,17,18);
			f(9,18,10,9,18,10);
			f(10,18,19,10,18,19);
			f(10,19,11,10,19,11);
			f(11,19,20,11,19,20);
			f(11,20,12,11,20,12);
			f(12,20,21,12,20,21);
			f(12,21,13,12,21,13);
			f(13,21,22,13,21,22);
			f(13,22,14,13,22,14);
			f(14,22,23,14,22,23);
			f(14,23,15,14,23,15);
			f(15,23,16,15,23,33);
			f(15,16,8,15,33,32);
			f(24,28,29,24,28,29);
			f(24,29,25,24,29,25);
			f(25,29,30,25,29,30);
			f(25,30,26,25,30,26);
			f(26,30,31,26,30,31);
			f(26,31,27,26,31,27);

			this.geometry.ready = true;
		}

	}

}