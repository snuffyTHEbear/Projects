package
{
	import com.arcticcode.greenFlames.isometric.core.IsometricEngine;
	import com.arcticcode.greenFlames.isometric.core.objects.IsometricShape;
	import com.arcticcode.greenFlames.isometric.geom.IsoDimensions;
	import com.arcticcode.greenFlames.isometric.geom.IsoPoint3D;
	import com.arcticcode.greenFlames.isometric.graphics.GraphicsOptions;
	import com.arcticcode.greenFlames.isometric.graphics.fill.FillOptions;
	import com.arcticcode.greenFlames.isometric.graphics.line.LineStyle;
	
	import flash.display.Sprite;
	import com.arcticcode.greenFlames.isometric.view.BaseIsometricView;
	
	public class BaseIsometrics extends BaseIsometricView
	{
		private var _block:IsometricShape;
		
		public function BaseIsometrics()
		{
			super.init();
			setupBlock();
		}
		
		private function setupBlock():void
		{
			var go:GraphicsOptions = new GraphicsOptions(new LineStyle(), new FillOptions(), null);
			
			_block = new IsometricShape(new IsoPoint3D(0, 0, 0), new IsoDimensions(10, 10, 10), go);
			go.graphics = _block.graphics;
			addChild(_block);
			
			engine.drawObject(_block.isometricObject);
		}
	}
}