package com.tests
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.geom.Matrix;
	
	import org.fly3D.display.BasicScene;
	import org.fly3D.display.Plane;
	import org.fly3D.display.graphics.GraphicsOptions;
	import org.fly3D.geom.Light;
	
	public class BitmapTests extends BasicScene
	{
		private var _go:GraphicsOptions;
		
		private var _light:Light;
		
		private var _plane:Plane;
		
		[Embed(source="assets/gost.jpg", mimeType = "image/jpeg")]
		private var _imageSource:Class;
		
		private var _bitmap:Bitmap;
		
		public function BitmapTests(w:Number, h:Number)
		{
			super(w * 0.5, h * 0.5);
			
			_light = new Light();
			
			_plane = new Plane(500, 500, Plane.HIGH, _light, true);
			_plane.move(0, 0, 0);
			_plane.setCenterPoint(0, 0, 0);
			add3DShape(_plane);
			_plane.doubleSided = true;
			
			_bitmap = new _imageSource();
			
			_go = new GraphicsOptions(_plane.graphics, GraphicsOptions.BITMAP);
			_go.fill = true;
			_go.setBitmapFill(_bitmap.bitmapData, new Matrix(1, 0, 0, 1, -250, -250), false);
			_plane.graphicsOptions = _go;
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		override protected function loop(e:Event):void
		{
			_plane.rotatePointsX(0.03);
			render();
		}
	}
}