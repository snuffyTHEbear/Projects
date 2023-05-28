package Matrices
{
	import com.arcticcode.greenFlames.math.MathUtils;
	
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	public class SkewTest extends Sprite
	{
		public function SkewTest()
		{
			var rect:Sprite = new Sprite();
			rect.graphics.lineStyle(1, 0);
			rect.graphics.beginFill(0x00cc00, 0.85);
			rect.graphics.drawRect(0, 0, 100, 40);
			rect.graphics.endFill();
			addChild(rect);
			rect.x = 100;
			rect.y = 100;
			
			var m:Matrix = rect.transform.matrix;
			m.c = Math.tan(MathUtils.degreesToRadians(-20));
			rect.transform.matrix = m;
		}
	}
}