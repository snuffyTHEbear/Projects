package dump
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class PerlinNoiseExperiments extends Sprite
	{
		private var bmd:BitmapData;
		private var b:Bitmap;
		private var b2:Bitmap;
		
		public function PerlinNoiseExperiments()
		{
			init();
		}
		private function init():void
		{
			b2 = new Bitmap(new BitmapData(50,50));
			bmd = new BitmapData(b2.width,b2.height,false,0);
			b = new Bitmap(bmd);
			addChild(b);
			
			//bmd.perlinNoise(300,200,2,Math.random()*1000,false,true,1,true);
			bmd.noise(50,0,50,7,true);
			bmd.draw(b2,null,null,BlendMode.DIFFERENCE);
		}
	}
}