package{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	
	public class getBounds extends Sprite{
		
		private var ball:CreateCircle;
		
		public function getBounds(){
			init();
		}
		private function init():void{
			ball = new CreateCircle();
			addChild(ball);
			var bounds:Rectangle = ball.getBounds(this);
			trace(bounds.left);
			trace(bounds.right);
			trace(bounds.top);
			trace(bounds.bottom);
		}
	}
}