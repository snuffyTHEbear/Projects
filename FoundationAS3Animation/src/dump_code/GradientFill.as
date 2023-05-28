package{
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	public class GradientFill extends Sprite{
		
		public function GradientFill(){
			init();
		}
		private function init():void{
			graphics.lineStyle();
			var colors:Array = [0xffffff, 0xff0000, 0x000000];
			var alphas:Array = [1,0.5,0];
			var ratios:Array = [0, 128,255];
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(100, 100, 0, 100, 100);
			graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
			graphics.drawRoundRect(100, 100, 100, 100, 10, 10);
			graphics.endFill();
		}
	}
}