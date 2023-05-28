package{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	
	public class AngleBounce extends Sprite{
		
		private var ball:CreateCircle;
		private var line:Sprite;
		private var gravity:Number = 0.3;
		private var bounce:Number = -0.6;
		
		public function AngleBounce(){
			init();
		}
		private function init():void{
			ball = new CreateCircle();
			addChild(ball);
			ball.x = 100;
			ball.y = 100;
			
			line = new Sprite();
			line.graphics.lineStyle(1);
			line.graphics.lineTo(300, 0);
			addChild(line);
			line.x = 50;
			line.y = 200;
			line.rotation = 30;
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void{
			//normal motion
			ball.vy += gravity;
			ball.x += ball.vx;
			ball.y += ball.vy;
			
			line.rotation = (stage.stageWidth / 2 - mouseX) * .1;
			//if(ball.hitTestObject(line)){
			var bounds:Rectangle = line.getBounds(this);
			if(ball.x > bounds.left && ball.x < bounds.right){
				//get angle, sine and cosine
				var angle:Number = line.rotation * Math.PI / 180;
				var cos:Number = Math.cos(angle);
				var sin:Number = Math.sin(angle);
				
				//get position of ball, relative to line
				var x1:Number = ball.x - line.x;
				var y1:Number = ball.y - line.y;
				
				var y2:Number = cos * y1 - sin * x1;
				
				//rotate velocity
				var vy1:Number = cos * ball.vy - sin * ball.vx;
				
			
				if(y2 > -ball.height / 2 && y2 < vy1)
				{
					//rotate coordinates
					var x2:Number = cos * x1 + sin * y1;
					
					//rotate velocity
					var vx1:Number = cos * ball.vx + sin * ball.vy;
					
					//perform bounce with rotated values
					
					y2 = -ball.height / 2;
					vy1 *= bounce;
					
					//rotate everything back
					x1 = cos * x2 - sin * y2;
					y1 = cos * y2 + sin * x2;
					ball.vx = cos * vx1 - sin * vy1;
					ball.vy = cos * vy1 + sin * vx1;
					ball.x = line.x + x1;
					ball.y = line.y + y1;
				}
			}
		}
	}
}