package
{
	import caurina.transitions.Tweener;
	
	import com.arcticcode.greenFlames.graphics.Colour24;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	[SWF(width=600,height=600,backgroundColor=0xFFFFFF)]
	public class SquareSpiral extends Sprite
	{
		private var oldColour:uint;
		private var colour:Colour24 = new Colour24();
		private var timer:Timer;
		private var b:Bitmap;
		private var bmd:BitmapData;
		private var rect:Rectangle = new Rectangle(0,0,5,5);
		private var rect2:Rectangle = new Rectangle(0,0,5,5);
		private var tempData:BitmapData;
		private var bytes:ByteArray;
		private var dir:String = "right";
		private static const max:Number = 600;
		private static const min:Number = 0;
		private var top:Number = min;
		private var bottom:Number = max;
		private var right:Number = max;
		private var left:Number = min;
		private var paused:Boolean = false;
		
		public function SquareSpiral()
		{
			init();
		}
		private function init():void
		{
			bmd = new BitmapData(max,max,true);
			b = new Bitmap(bmd);
			addChild(b);
			
			tempData = new BitmapData(5,5,false,0x000000);
			tempData.fillRect(rect,Math.random()*0xFFFFFF);
			bytes = tempData.getPixels(rect);
			bytes.position = 0;
			
			timer = new Timer(1000/24);
		//	timer.addEventListener(TimerEvent.TIMER, onTimer);
			//timer.start();
			//stage.addEventListener(KeyboardEvent.KEY_DOWN,onKey);
			addEventListener(Event.ENTER_FRAME,onTimer);
			tween();
		}
		private function tween():void
		{
			colour.current = tempData.getPixel(0,0);
			colour.target = Math.random()*0xFFFFFF;
			Tweener.addTween(colour,{red:colour.targetRed,green:colour.targetGreen,blue:colour.targetBlue,time:4,onComplete:tween});
		}
		public function onKey(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.SPACE)
			{
				if(paused)
				{
					paused = false;
					Tweener.resumeAllTweens();
					addEventListener(Event.ENTER_FRAME,onTimer);
				}
				else
				{
					paused = true;
					Tweener.pauseAllTweens();
					removeEventListener(Event.ENTER_FRAME,onTimer);
				}
			}
		}
		private function onTimer(e:Event):void
		{
			if(top >= bottom-5 && left >= right - 5)
			{
				top = min;
				bottom = max;
				left = min;
				right = max;
				rect.x = 0;
				rect.y = 0;
				Tweener.removeAllTweens();
				tween();
			}
			for(var i:uint=0;i<100;i++)
			{
				tempData.fillRect(rect2,colour.newColour);
				bytes = tempData.getPixels(rect2);
				bytes.position = 0;
				bmd.setPixels(rect, bytes);
				switch(dir)
				{
					case "right":
					rect.x += 5;
					if(rect.x >= right)
					{
						dir = "down";
						right -= 5;
						rect.x=right;
					}
					break;
					
					case "left":
					rect.x -= 5;
					if(rect.x <= left)
					{
						dir = "up";
						left +=5;
						rect.x = left-5;
					}
					break;
					
					case "up":
					rect.y -= 5;
					if(rect.y <= top)
					{
						dir = "right";
						top += 5;
						rect.y = top;
					}
					break;
					
					case "down":
					rect.y += 5;
					if(rect.y >= bottom)
					{
						dir = "left";
						bottom -= 5;
						rect.y = bottom;
					}
					break;
				}
			}
			//e.updateAfterEvent();
		}
	}
}