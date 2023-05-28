package
{
	import com.arcticcode.greenFlames.isometric.core.objects.ComplexIsometricObject;
	import com.arcticcode.greenFlames.isometric.core.IsometricEngine;
	import com.arcticcode.greenFlames.isometric.core.objects.IsometricObject;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class IsometricTextures extends Sprite
	{
		private var engine:IsometricEngine;
		
		private var cont:ComplexIsometricObject;
		
		private const centreX:Number = stage.stageWidth * 0.5;
		
		private const centreY:Number = stage.stageHeight * 0.5;
		
		[Embed(source="/assets/image2.jpg")]
		private var _image1:Class;
		
		[Embed(source="/assets/image2.jpg")]
		private var _image2:Class;
		
		[Embed(source="/assets/image1.jpg")]
		private var _image3:Class;
		
		[Embed(source="/assets/image1.jpg")]
		private var _image4:Class;
		
		private var b1:Bitmap;
		
		private var b2:Bitmap;
		
		private var b3:Bitmap;
		
		private var b4:Bitmap;
		
		public function IsometricTextures()
		{
			init();
		}
		
		private function init():void
		{
			b1 = new _image1();
			b2 = new _image2();
			b3 = new _image3();
			b4 = new _image4();
			
			cont = new ComplexIsometricObject();
			engine = new IsometricEngine(cont.graphics, centreX, centreY);
			engine.autoClear = false;
			addChild(cont);
			
			//cont.addObject(new IsometricObject(0, 0, 0, 50, 50, 50, false, 0, false, 0));
			cont.graphics.beginBitmapFill(b1.bitmapData, b1.transform.matrix, false, false);
			//engine.drawRightFace(cont.objects[0]);
			//engine.drawFaces(cont.objects[0]);
			//engine.drawFaces({x:0,y:0,z:0,w:50,h:50,d:50});
			cont.graphics.endFill();
			
			cont.graphics.beginBitmapFill(b2.bitmapData, b2.transform.matrix, false, false);
			//engine.drawTopFace(cont.objects[0]);
			cont.graphics.endFill();
			
			cont.graphics.beginBitmapFill(b3.bitmapData, b3.transform.matrix, false, false);
			//engine.drawLeftFace(cont.objects[0]);
			cont.graphics.endFill();
		}
	}
}