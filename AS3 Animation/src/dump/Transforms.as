package{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	
	public class Transforms extends Sprite{
		
		[Embed(source="pic.jpg")]
		public var Picture:Class;
		
		public function Transforms(){
			init();
		}
		private function init():void{
			var pic:Bitmap = new Picture();
			addChild(pic);
			var blur:BlurFilter = new BlurFilter(5, 5, 1);
			var glow:GlowFilter = new GlowFilter(0x33BBff);
			var shad:DropShadowFilter = new DropShadowFilter(4, 90, 0xff6600);
			pic.transform.colorTransform = new ColorTransform(-1, -1,-1, 1,	255, 255,255, 0);
			pic.filters = [glow, shad];
		}
	}
}