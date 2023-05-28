package com.tests
{
	import flash.events.Event;
	
	import org.fly3D.display.BasicScene;
	import org.fly3D.display.BasicShape3D;
	import org.fly3D.display.graphics.GraphicsOptions;
	import org.fly3D.geom.Light;
	
	public class BlankScene extends BasicScene
	{
		private var _basicShape:BasicShape3D;
		
		private var _light:Light;
		
		private var _go:GraphicsOptions;
		
		public function BlankScene(w:Number, h:Number)
		{
			super(w * 0.5, h * 0.5, 250);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_light = new Light();
			_basicShape = new BasicShape3D(_light, true);
			_basicShape.move(0, 0, 0);
			add3DShape(_basicShape);
			
			_go = new GraphicsOptions(_basicShape.graphics, "faces");
			_go.setupFill(0xCC0000, 1);
			_go.setupLine(1, 0, 1);
			_basicShape.graphicsOptions = _go;
			
			
			
			startRendering();
		}
		
		override protected function loop(e:Event):void
		{
			_basicShape.rotatePointsY(0.02);
			render();
		}
	}
}