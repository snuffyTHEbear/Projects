package {
	import caurina.transitions.Tweener;
	
	import com.arcticcode.greenFlames.components.MemFpsCount;
	import com.arcticcode.greenFlames.geom.LWPoint;
	import com.arcticcode.greenFlames.graphics.Colour24;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Matrix;
	import flash.utils.Timer;
	[SWF(width=600,height=400,backgroundColor=0xFFFFFF)]
	public class Main extends Sprite
	{	
		private var point:LWPoint;
		private var colour:Colour24 = new Colour24();
		
		private var oldColour:uint = 0;
		private var b:Bitmap;
		private var bmd:BitmapData;
		private var cont:Sprite;
		private var mat:Matrix;
		private var timer:Timer;
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;
		private var blur:BlurFilter = new BlurFilter(3,3,1);
		
		public function Main()
		{
			init();
		}
		private function init():void
		{		
			bmd = new BitmapData(stage.stageWidth,stage.stageHeight,true,0xFFFFFF);
			b = new Bitmap(bmd);
			addChild(b);
			
			cont = new Sprite();
			
			mat = cont.transform.matrix;
			
			point = new LWPoint(centreX,centreY);
			
			var _fm:MemFpsCount = new MemFpsCount();
			_fm.x = 30;
			addChild(_fm);
			
			timer = new Timer(1000/24);
			timer.addEventListener(TimerEvent.TIMER, onDraw);
			timer.start();
			tween();
		}
		private function col():void
		{
			oldColour = colour.newColour;
		}
		private function tween():void
		{
			colour.current = oldColour;
			colour.target = Math.random() * 0xFFFFFF;
			Tweener.addTween(colour,{onUpdate:col,red:colour.targetRed,green:colour.targetGreen,blue:colour.targetBlue,time:5,onComplete:tween,transition:"easeinoutexpo"});
		}
		private function onDraw(e:TimerEvent):void
		{
			point.x += Math.random() * 10-5;
			point.y += Math.random() * 10-5;
			
			cont.graphics.lineStyle(4,colour.newColour);
			cont.graphics.moveTo(0,0);
			cont.graphics.curveTo(point.x,point.y,0,stage.stageHeight);
			cont.graphics.lineStyle(0,0xffffff,0.5);
			cont.graphics.moveTo(0,0);
			cont.graphics.curveTo(point.x,point.y,0,stage.stageHeight);
			//
			cont.graphics.lineStyle(4,colour.newColour);
			cont.graphics.moveTo(stage.stageWidth,0);
			cont.graphics.curveTo(point.x,point.y,stage.stageWidth,stage.stageHeight);
			cont.graphics.lineStyle(0,0xffffff,0.5);
			cont.graphics.moveTo(stage.stageWidth,0);
			cont.graphics.curveTo(point.x,point.y,stage.stageWidth,stage.stageHeight);
			//
			cont.graphics.lineStyle(4,colour.newColour);
			cont.graphics.moveTo(0,0);
			cont.graphics.curveTo(point.x,point.y,stage.stageWidth,0);
			cont.graphics.lineStyle(0,0xffffff,0.5);
			cont.graphics.moveTo(0,0);
			cont.graphics.curveTo(point.x,point.y,stage.stageWidth,0);
			//
			cont.graphics.lineStyle(4,colour.newColour);
			cont.graphics.moveTo(0,stage.stageHeight);
			cont.graphics.curveTo(point.x,point.y,stage.stageWidth,stage.stageHeight);
			cont.graphics.lineStyle(0,0xffffff,0.5);
			cont.graphics.moveTo(0,stage.stageHeight);
			cont.graphics.curveTo(point.x,point.y,stage.stageWidth,stage.stageHeight);
			bmd.draw(cont,mat);
			cont.graphics.clear();
			//e.updateAfterEvent();
		}
	}
}