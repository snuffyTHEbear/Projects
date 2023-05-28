package
{
	import flash.events.Event;
	
	import org.papervision3d.core.geom.TriangleMesh3D;
	import org.papervision3d.core.geom.renderables.Triangle3D;
	import org.papervision3d.core.geom.renderables.Vertex3D;
	import org.papervision3d.core.math.NumberUV;
	import org.papervision3d.lights.PointLight3D;
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.materials.special.CompositeMaterial;
	import org.papervision3d.view.BasicView;
	
	[SWF(width = 640, height = 480)]
	public class PVTests extends BasicView
	{
		private var w:Number = stage.stageWidth;
		private var h:Number = stage.stageHeight;
		private var centreX:Number = w * 0.5;
		private var centreY:Number = h * 0.5;
		
		private var _light:PointLight3D;
		private var _mesh:TriangleMesh3D;
		
		public function PVTests()
		{
			super(w, h, true, true, "Target");
			
			init();
		}
		private function init():void
		{
			createMesh();
			
			addEventListener(Event.EXIT_FRAME, onRenderTick);
		}
		private function createMesh():void
		{
			var colorMat:ColorMaterial = new ColorMaterial();
			var wireMat:WireframeMaterial = new WireframeMaterial(0x000000);
			var compMat:CompositeMaterial = new CompositeMaterial();
			compMat.addMaterial(colorMat);
			compMat.addMaterial(wireMat);
			compMat.doubleSided = false;
			
			_mesh = new TriangleMesh3D(null, new Array(), new Array());
			var width:Number = 500;
			var height:Number = 500;
			var depth:Number = 100;
			var difference:Number = .25;
			//Vertices
			//Front
			var ftl:Vertex3D = new Vertex3D(-width * 0.5, height * 0.5, depth * 0.5);//Top left
			var ftr:Vertex3D = new Vertex3D(width * 0.5, height * 0.5, depth * 0.5);//Top right
			var fbr:Vertex3D = new Vertex3D(width * 0.5 - (width * difference), -height * 0.5, depth * 0.5);//Bottom right
			var fbl:Vertex3D = new Vertex3D(-width * 0.5 + (width * difference), -height * 0.5, depth * 0.5);//Bottom left
			//Back
			var btl:Vertex3D = new Vertex3D(-width * 0.5, height * 0.5, -depth * 0.5);//Top left
			var btr:Vertex3D = new Vertex3D(width * 0.5, height * 0.5, -depth * 0.5);//Top right
			var bbr:Vertex3D = new Vertex3D(width * 0.5 - (width * difference), -height * 0.5, -depth * 0.5);//Bottom right
			var bbl:Vertex3D = new Vertex3D(-width * 0.5 + (width * difference), -height * 0.5, -depth * 0.5);//Bottom left
			//add vertices
			_mesh.geometry.vertices.push(ftl, ftr, fbl, fbr);
			_mesh.geometry.vertices.push(btl, btr, bbl, bbr);
			//create faces
			//Front
			var triangle_1_vertices:Array = [fbl, ftl, ftr];
			var triangle_2_vertices:Array = [fbr, fbl, ftr];
			//Back
			var triangle_3_vertices:Array = [bbl, btl, btr];
			var triangle_4_vertices:Array = [bbr, bbl, btr];
			
			var textureMap_1:Array = [new NumberUV(0, 0), new NumberUV(0, 1), new NumberUV(1, 1)];
			var textureMap_2:Array = [new NumberUV(1, 0), new NumberUV(0, 0), new NumberUV(1, 1)];
			var textureMap_3:Array = [new NumberUV(0, 0), new NumberUV(0, 1), new NumberUV(1, 1)];
			var textureMap_4:Array = [new NumberUV(1, 0), new NumberUV(0, 0), new NumberUV(1, 1)];
			
			//Front
			var triangle_face_1:Triangle3D = new Triangle3D(_mesh, triangle_1_vertices, compMat, textureMap_1);
			var triangle_face_2:Triangle3D = new Triangle3D(_mesh, triangle_2_vertices, compMat, textureMap_2);
			//Back
			var triangle_face_3:Triangle3D = new Triangle3D(_mesh, triangle_3_vertices, compMat, textureMap_1);
			var triangle_face_4:Triangle3D = new Triangle3D(_mesh, triangle_4_vertices, compMat, textureMap_2);
			//add faces
			_mesh.geometry.faces.push(triangle_face_1, triangle_face_2, triangle_face_3, triangle_face_4);
			_mesh.geometry.ready = true;
			
			scene.addChild(_mesh);
		}
		override protected function onRenderTick(event:Event=null) : void
		{
			_mesh.rotationY += 3.2;
			//_mesh.rotationX += 2;
			renderer.renderScene(scene, camera, viewport);
		}
	}
}