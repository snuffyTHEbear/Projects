package{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	
	public class Pixels2 extends Sprite{
		
		private var bmp:Bitmap;
		private var canvas:BitmapData;
		//private var rect:Rectangle;
		private var cTransform:ColorTransform;
		private var numSq:Number = (stage.stageWidth * stage.stageHeight);
		private var sqs:Array;
		private var xPos:Number = 0;
		private var yPos:Number = 0;
		private var _right:Boolean = false;
		private var drawn:Boolean = false;
		
		public function Pixels2(){
			init();
		}
		private function init():void{
			canvas = new BitmapData(stage.stageWidth, stage.stageHeight, false, 0xffffff);
			bmp = new Bitmap(canvas);
			addChild(bmp);
			sqs = new Array();
			
			
			cTransform = new ColorTransform;
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void{
			//for(var i:uint = 0;i<numSq;i++)
			//{
			var size:Number = 10;
				var _color:uint = (xPos-yPos)*0x00ff00;;//Math.random()*0xffffff;
				var rect:Rectangle = new Rectangle(xPos,yPos,size,size);
				sqs.push(rect);	
				canvas.fillRect(rect, _color);
				
				if(xPos >= canvas.width && _right == true){
					_right = false;
					yPos += rect.height;
				}else if(xPos <= 0 && _right == false)
				{
					_right = true;
					xPos = 0;
				}
				if(_right){
					xPos += rect.width;
				}
				else
				{
					xPos -= rect.width;
					var getP:uint = canvas.getPixel(xPos+1,yPos+1);
					var pVal:String = getP.toString(16);
					if(xPos<=0&&pVal=="ffffff"){
						_color = (xPos-yPos)*0x00ff00;//Math.random()*0xffffff;
						rect = new Rectangle(xPos,yPos,size,size);
						sqs.push(rect);	
						canvas.fillRect(rect, _color);
						yPos+=rect.height;
					}
				}
				if(xPos >= canvas.width && yPos >= canvas.height)
				{
					removeEventListener(Event.ENTER_FRAME, onEnterFrame);
					mess();
				}
			//}

		}
		private function mess():void{
			
		}
	}
}