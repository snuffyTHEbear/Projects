package
{
	import caurina.transitions.Tweener;
	
	import com.arcticcode.greenFlames.Math.MathUtils;
	import com.arcticcode.greenFlames.graphics.Colour24;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	[SWF(width=600,height=600,backgroundColor=0xFFFFFF)]
	public class SineCosineSpiral extends Sprite
	{
		private var angle:Number = 0;
		private static var SW:Number = 600;
		private static var SH:Number = 600;
		private static var centreX:Number = SW/2;
		private static var centreY:Number = SH/2; 		
		private var radius:Number = 50;
		private var speed:Number = 0.1;
		//
		private var b:Bitmap;
		private var bmd:BitmapData;
		private var cont:Sprite;
		private var line:Shape;
		private var colour:Colour24 = new Colour24();
		private var currColour:uint=0;
		private var paused:Boolean = false;
		
		public function SineCosineSpiral()
		{
			init();
		}
		private function init():void
		{
			bmd = new BitmapData(SW,SH,true,0xFFFFFF);
			b = new Bitmap(bmd);
			addChild(b);
			
			cont = new Sprite();
			line = new Shape();
			drawLine(0);
			cont.addChild(line);
			
			tween();
			addEventListener(Event.ENTER_FRAME, onDraw);
		}
		private function drawLine(colour:uint):void
		{
			line.graphics.clear();
			//line.graphics.lineStyle(1,colour);
			line.graphics.beginFill(colour);
			//line.graphics.drawRect(-2.5,-2.5,5,5);
			/*line.graphics.moveTo(-2.5,-2.5);
			line.graphics.lineTo(2.5,0);
			line.graphics.lineTo(-2.5,2.5);
			line.graphics.lineTo(-2.5,-2.5);*/
			line.graphics.drawCircle(0,0,0.9);
			line.graphics.endFill();
		}
		public function onKey(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.SPACE)
			{
				if(paused)
				{
					paused = false;
					Tweener.resumeAllTweens();
					addEventListener(Event.ENTER_FRAME,onDraw);
				}
				else
				{
					paused = true;
					Tweener.pauseAllTweens();
					removeEventListener(Event.ENTER_FRAME,onDraw);
				}
			}
		}
		private function tween():void
		{
			colour.current = currColour;
			colour.target = Math.random()*0xFFFFFF;
			Tweener.addTween(colour,{red:colour.targetRed,green:colour.targetGreen,blue:colour.targetBlue,time:0.5,onComplete:tween,transition:"easeinoutexpo"});
		}
		private function onDraw(e:Event):void
		{
			for(var i:uint=0;i<100;i++)
			{
				currColour = colour.newColour;
				drawLine(currColour);
				line.x = centreX + Math.cos(angle) * radius;
				line.y = centreY + Math.sin(angle) * radius;
				line.rotation = MathUtils.distanceToDegrees(centreX,centreY,line.x,line.y);
				bmd.draw(cont);
				angle += speed;
				if(radius >= 50)
				{
					radius -= speed/16;
				}
				else if(radius <= -50)
				{
					radius *= -1;
				}
				else
				{
					radius -= speed/16;
				}
				trace(radius);
			}
		}
	}
}