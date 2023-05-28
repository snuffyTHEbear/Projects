package
{
	import com.arcticcode.greenFlames.isometric.core.IsometricEngine;
	import com.arcticcode.greenFlames.isometric.core.objects.ComplexIsometricObject;
	import com.arcticcode.greenFlames.isometric.geom.IsoDimensions;
	import com.arcticcode.greenFlames.isometric.graphics.GraphicsOptions;
	import com.arcticcode.greenFlames.isometric.graphics.fill.FillOptions;
	import com.arcticcode.greenFlames.isometric.graphics.line.LineStyle;
	import com.arcticcode.greenFlames.isometric.utils.IsometricUtils;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	[SWF(width=600, height = 400, backgroundColor = 0xffffff)]
	public class IsometricExperiments extends Sprite
	{
		private var engine:IsometricEngine;
		
		private var obj:ComplexIsometricObject;
		
		private var centreX:Number = stage.stageWidth * 0.5;
		
		private var centreY:Number = stage.stageHeight * 0.5;
		
		private var bmd:BitmapData;
		
		private var b:Bitmap;
		
		public function IsometricExperiments()
		{
			init();
		}
		
		private function init():void
		{
			bmd = new BitmapData(50, 50, false, 0xffffff);
			b = new Bitmap(bmd);
			addChild(b);
			
			var go:GraphicsOptions = new GraphicsOptions(new LineStyle(0), new FillOptions());
			
			bmd.noise(Math.random() * 1000, 0, 255, 7, true);
			
			engine = new IsometricEngine(null, centreX, centreY + 150, IsometricEngine.RIGHT, false, true);
			obj = IsometricUtils.createXZGrid(50, 50, new IsoDimensions(5, 15, 5), go, IsometricUtils.OBJECTS);
			engine.renderer.g = obj.graphics;
			addChild(obj);
			
			//IsometricUtils.createXZGrid(obj, 50, 50, 5, 15, 5, false);
			
			for (var i:uint = 0; i < obj.objects.length; i++)
			{
				obj.objects[i].fillColour = bmd.getPixel(obj.objects[i].x / 5, obj.objects[i].z / 5);
			}
			
			engine.drawObjectsSimpleForward(obj.objects);
		}
	}
}