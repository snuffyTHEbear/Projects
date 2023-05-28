package visual.cube
{
	import flash.display.Bitmap;
	import flash.events.EventDispatcher;
	
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.primitives.Cube;
	
	public class CreateCube extends EventDispatcher
	{
		[Embed(source="/assets/GNTK_AA_CUBE_FACE_A.jpg")]
		private var _faceA:Class;
		private var _front:Bitmap = new _faceA();
		[Embed(source="/assets/GNTK_AA_CUBE_FACE_D.jpg")]
		private var _faceD:Class;
		private var _back:Bitmap = new _faceD();
		[Embed(source="/assets/GNTK_BACK_CUBE_FACE_C.jpg")]
		private var _faceC:Class;
		private var _left:Bitmap = new _faceC();
		[Embed(source="/assets/GNTK_BACK_CUBE_FACE_F.jpg")]
		private var _faceF:Class;
		private var _right:Bitmap = new _faceF();
		[Embed(source="/assets/GNTK_EP_NOTES_CUBE_FACE_B.jpg")]
		private var _faceB:Class;
		private var _top:Bitmap = new _faceB();
		[Embed(source="/assets/GNTK_EP_NOTES_CUBE_FACE_E.jpg")]
		private var _faceE:Class;
		private var _bottom:Bitmap = new _faceE();
		private var _faces:Array = new Array(_front,_top,_left,_back,_bottom,_right);
		private var _faceNames:Array = new Array("back","bottom","right","front","top","left");
		private var _cube:Cube;
		private var _matList:MaterialsList;
		
		public function CreateCube()
		{
			_matList = new MaterialsList();
			for(var inc:int=0;inc<_faces.length;inc++)
			{
				var mat:BitmapMaterial = new BitmapMaterial(_faces[inc].bitmapData);
				mat.precise = true,
				mat.interactive = true;
				_matList.addMaterial(mat,_faceNames[inc]);
			}
			_cube = new Cube(_matList,250,250,250,4,4,4);
			_cube.z = -350;
		}
		public function get cube():Cube
		{
			return _cube;
		}
	}
}