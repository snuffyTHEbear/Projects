package tests
{
	import flash.events.Event;
	
	import org.arctic3d.display.Arctic3DScene;
	import org.arctic3d.geom.Face;
	import org.arctic3d.geom.Light;
	import org.arctic3d.geom.Point3D;
	import org.arctic3d.utils.GeomUtils;
	
	public class FaceTests extends Arctic3DScene
	{
		private var _face:Face;
		private var _light:Light = new Light();
		
		public function FaceTests(w:Number=640, h:Number=480)
		{
			super(w, h);
		}
		
		override protected function init(e:Event) : void
		{
			_face = new Face();
			GeomUtils.buildPlane(-125, -125, 0, 125, 125, _face);
			//_face.createTriangleFromPoints(_face.points[0], _face.points[1], _face.points[2]);
			_face.setCenter(0, 0, 200);
			_face.setVanishingPoint(vpX, vpY);
			_face.light = _light;
			_face.doubleSided = true;
						
			startRendering();
		}
		
		override protected function onRenderTick(e:Event) : void
		{
			var angleX:Number = (mouseY - vpY) * .001;
			var angleY:Number = (mouseX - vpX) * .001;
			
			for(var i:uint = 0 ; i < _face.points.length; i++)
			{
				_face.points[i].rotateX(angleX);
				_face.points[i].rotateY(angleY);
			}
			
			super.onRenderTick(e);
		}
		
		override protected function render() : void
		{
			triangleRenderer.renderFace(_face);
		}
	}
}