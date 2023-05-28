package
{
	import com.arcticcode.greenFlames.isometric.core.IsometricEngine;
	import com.arcticcode.greenFlames.isometric.core.objects.ComplexIsometricObject;
	import com.arcticcode.greenFlames.isometric.core.objects.IsometricShape;
	import com.arcticcode.greenFlames.isometric.geom.IsoDimensions;
	import com.arcticcode.greenFlames.isometric.geom.IsoPoint3D;
	import com.arcticcode.greenFlames.isometric.graphics.GraphicsOptions;
	import com.arcticcode.greenFlames.isometric.graphics.fill.FillOptions;
	import com.arcticcode.greenFlames.isometric.graphics.line.LineStyle;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	[SWF(width=600, height = 400, backgroundColor = 0xffffff)]
	public class IsometricStuff extends Sprite
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		
		private var centreY:Number = stage.stageHeight * 0.5;
		
		private var bmd:BitmapData;
		
		private var b:Bitmap;
		
		private var engine:IsometricEngine;
		
		private var cont:ComplexIsometricObject;
		
		private var tf:TextField;
		
		[Embed(source="/assets/e.jpg")]
		private var _i:Class;
		
		public function IsometricStuff()
		{
			init();
		}
		
		private function init():void
		{
			engine = new IsometricEngine(null, centreX, centreY + 200, IsometricEngine.RIGHT, false, true);
			
			/*tf = new TextField();
			   tf.autoSize = TextFieldAutoSize.LEFT;
			   tf.defaultTextFormat = new TextFormat("Verdana",50,0);
			   tf.selectable = false;
			   tf.text = "Rob";
			   bmd = new BitmapData(15,15,false,0xffffff);
			 b = new Bitmap(bmd);*/
			b = new _i();
			bmd = b.bitmapData;
			//bmd.draw(tf,tf.transform.matrix);
			addChild(b);
			
			//bmd.noise(10,0,255,7,false);
			//bmd.perlinNoise(15,15,2,10,false,true,1|4,false);
			
			cont = new ComplexIsometricObject();
			
			var count:uint = 0;
			
			for (var i:uint = bmd.width - 1; i > 0; i--)
			{
				for (var j:uint = bmd.height - 1; j > 0; j--)
				{
					var c:uint = bmd.getPixel(i, j);
					var h:Number = ((c) / 1000000);
					var pos:IsoPoint3D = new IsoPoint3D(i * 2, 0, j * 2);
					var dim:IsoDimensions = new IsoDimensions(2, h, 2);
					var ls:LineStyle = new LineStyle();
					var fo:FillOptions = new FillOptions(c, 1);
					var go:GraphicsOptions = new GraphicsOptions(ls, fo, engine.renderer.graphics);
					cont.addShape(new IsometricShape(pos, dim, go));
				}
			}
			
			engine.drawObjectsComplexForward(cont.objects);
			engine.addToDisplayListForward(cont.objects, cont);
			
			addChild(cont);
		}
	}
}