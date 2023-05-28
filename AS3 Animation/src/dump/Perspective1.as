package dump
{
	import com.arcticcode.greenFlames.graphics.CreateCircle;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class Perspective1 extends Sprite
	{
		
		private var ball:CreateCircle;
		private var xPos:Number = 0;
		private var yPos:Number = 0;
		private var zPos:Number = 0;
		private var fl:Number = 250;
		private var vpX:Number;// = stage.stageWidth / 2;
		private var vpY:Number;// = stage.stageHeight / 2;
		
		public function Perspective1(w:Number, h:Number)
		{
			vpX = w * 0.5;
			vpY = h * 0.5;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:*):void
		{
			ball = new CreateCircle();
			ball.color = 0;
			addChild(ball);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onEnterFrame(event:Event):void
		{
			if(zPos > -fl)
			{
				xPos = mouseX - vpX;
				yPos = mouseY - vpY;
				var scale:Number = fl / (fl + zPos);
				ball.scaleX = ball.scaleY = scale;
				ball.x = vpX + xPos * scale;
				ball.y = vpY + yPos * scale;
				ball.visible = true;
			}
			else
			{
				ball.visible = false;
			}
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.UP)
			{
				zPos += 5;
			}
			else if(event.keyCode == Keyboard.DOWN)
			{
				zPos -= 5;
			}
		}
	}
}