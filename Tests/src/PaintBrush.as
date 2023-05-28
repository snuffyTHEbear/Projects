package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class PaintBrush extends Sprite
	{
		private var bmd:BitmapData;
		private var bmd2:BitmapData;
		private var b:Bitmap;
		private var shape:Shape;
		private var centreX:Number = stage.stageWidth*0.5;
		private var centreY:Number = stage.stageHeight*0.5;
		private var wid:Number=600;
		private var hei:Number=400;
		//private var i:uint=0;
		private var points:Array;
		private var oldX:Number;
		private var oldY:Number;
		private var newX:Number;
		private var newY:Number;
		//
		
		public function PaintBrush()
		{
			init();
		}
		private function init():void
		{
			
			bmd = new BitmapData(wid,hei,true,0xffffff);
			bmd2 = new BitmapData(wid/10,hei/10,false,0xffffff);
			b = new Bitmap(bmd);
			addChild(b);
			
			bmd2.perlinNoise(wid/10,hei/10,5,1,false,true,1|2,false,null);
			//bmd2.noise(172,0,255,7,false);
								
			shape = new Shape();
			//addEventListener(Event.ENTER_FRAME,onEnterFrame);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
		}
		private function onDown(e:MouseEvent):void
		{
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(MouseEvent.MOUSE_UP, onUp);
		}
		private function onUp(e:MouseEvent):void
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onUp);
		}
		private function onEnterFrame(e:Event):void
		{			
			//removeEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
	}
}
			/*
			var dist:Number = MathUtils.distanceToDegrees(mouseX, mouseY, arrow.x, arrow.y);
			angle = MathUtils.degreesToRadians(dist);
			//var radians:Number = angle * Math.PI / 2;
			arrow.rotation = MathUtils.distanceToDegrees(mouseX, mouseY, arrow.x, arrow.y);
			var vx:Number = Math.cos(angle) * speed;
			var vy:Number = Math.sin(angle) * speed;
			arrow.x += vx;
			arrow.y += vy;
			*/