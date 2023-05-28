package
{
	import com.arcticcode.greenFlames.isometric.ComplexIsometricObject;
	import com.arcticcode.greenFlames.isometric.IsometricEngine;
	import com.arcticcode.greenFlames.isometric.IsometricUtils;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class IsometricExperiments extends Sprite
	{
		private var engine:IsometricEngine;
		private var obj:ComplexIsometricObject;
		private var centreX:Number = stage.stageWidth*0.5;
		private var centreY:Number = stage.stageHeight*0.5;
		private var bmd:BitmapData;
		private var b:Bitmap;
		
		public function IsometricExperiments()
		{
			init();
		}
		private function init():void
		{
			bmd = new BitmapData(50,50,false,0xffffff);
			b = new Bitmap(bmd);
			addChild(b);
			
			bmd.noise(Math.random()*1000,0,255,7,true);
			
			engine = new IsometricEngine(null,centreX,centreY+150,IsometricEngine.RIGHT,false,true);
			obj = new ComplexIsometricObject();
			engine.g = obj.graphics;
			addChild(obj);
			
			IsometricUtils.createXZGrid(obj,50,50,5,15,5,false);
			
			for(var i:uint=0;i<obj.boxes.length;i++)
			{
				obj.boxes[i].fillColour = bmd.getPixel(obj.boxes[i].x/5,obj.boxes[i].z/5);
			}
			
			engine.drawBoxes(obj.boxes,obj.graphics);
		}
	}
}