package {
	import com.arcticcode.greenFlames.math.MathUtils;
	import com.arcticcode.greenFlames.utils.Utils;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width=640,height=480,backgroundColor=0xffffff)]
	public class Main extends Sprite
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;	
		private var r:Number = 200;
		private var theta:Number = 54;
		private var n:Number = 1;
		
		public function Main()
		{
			/* var arrA:Array = new Array(1,2,3);
			var arrB:Array = new Array("a","b","c");
			var shuffledArray:Array = ArrayUtils.joinArrays(true, arrA,arrB);
			var unShuffledArray:Array = ArrayUtils.joinArrays(false, arrA,arrB);
			trace(arrA,arrB,"\n"+shuffledArray,"\n"+unShuffledArray); */
			
			//init();
			/* var arr:Array = new Array();
			for(var i:int=0;i<StringUtils.ALPHABET.length;i++)
			{
				arr[i] = StringUtils.ALPHABET.charAt(i);
			}
			trace(arr);
			trace(arr.reverse());
			trace(ArrayUtils.manualShuffle(arr)); */
			
			var str:String;
			var myObject:Object = new Object();
			myObject.myString = "string";
			myObject.x = 50;
			trace(Utils.propertyNames(myObject));
			trace(Utils.propertyValues(myObject));
			
			//graphics.lineStyle(0,0);
			//graphics.drawCircle(Math.cos(0)*50+centreX,Math.sin(0)*50+centreY,5);
			
		}
		private function init():void
		{
			var r:Number = 200;
			var theta:Number = 54;
			var n:Number = 0;
			var a:Number = 0;
			graphics.lineStyle(0,0);
			for(var i:uint=0;i<75;i++)
			{
				r = a * 3.2;
				var _x:Number = MathUtils.xCart(r,a);
				var _y:Number = MathUtils.yCart(r,a);
				//i==0 ? graphics.moveTo((Math.cos(n * theta)*r)+centreX,(Math.sin(n * theta)*r)+centreY) : graphics.lineTo(((Math.sin(n * theta)*i/i)*r)+centreX,((Math.cos(n * theta)*i/i)*r)+centreY);
				i==0?graphics.moveTo(_x+centreX,_y+centreY) : graphics.lineTo(_x+centreX,_y+centreY);
				a += 1;
			}
			trace(7E+09);
			//addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(e:Event):void
		{
			
		}
	}
}
