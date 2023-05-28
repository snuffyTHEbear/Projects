package
{
	import caurina.transitions.Tweener;
	
	import com.arcticcode.greenFlames.Math.MathUtils;
	import com.arcticcode.greenFlames.utils.DisplayUtils;
	import com.bit101.components.HUISlider;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	[SWF(width=600,height=500,backgroundColor=0xffffff)]
	public class LissajousFigureCreator extends Sprite
	{
		private var cont:Sprite;
		private var theta:Number = 60;
		private static var phi:Number = 24;
		private static var rep:Number = 20;
		private static var r:Number = 150;
		private static var r2:Number = 2;
		//
		private var thetaSlider:HUISlider;
		private var phiSlider:HUISlider;
		private var repSlider:HUISlider;
		private var rSlider:HUISlider;
		private var r2Slider:HUISlider;
		//
		private var bmd:BitmapData;
		private var b:Bitmap;
		//
		private var rect:Rectangle = new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
		private var count:uint=0;
		
		public function LissajousFigureCreator()
		{
			init();
		}
		private function init():void
		{
			cont = new Sprite();
			DisplayUtils.doCentreOne(cont,stage.stageWidth,stage.stageHeight);
			//addChild(cont);
			
			bmd = new BitmapData(stage.stageWidth,stage.stageHeight,false,0xffffff);
			b = new Bitmap(bmd);
			addChild(b);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, tween);
			
			thetaSlider = new HUISlider(this,5,5,"Theta",onSlide);
			thetaSlider.maximum = 1000;
			thetaSlider.minimum = 1;
			thetaSlider.setSize(600,16);
			thetaSlider.alpha = 0.75;
			thetaSlider.value = theta;
			phiSlider = new HUISlider(this,5,20,"Phi",onSlide);
			phiSlider.maximum = 1000;
			phiSlider.minimum = 1;
			phiSlider.setSize(600,16);
			phiSlider.alpha = 0.75;
			phiSlider.value = phi;
			repSlider = new HUISlider(this,5,35,"Rep",onSlide);
			repSlider.maximum = 60;
			repSlider.setSize(600,16);
			repSlider.alpha = 0.75;
			repSlider.minimum = 1;
			repSlider.value = rep;
			rSlider = new HUISlider(this,5,50,"R",onSlide);
			rSlider.maximum = 200;
			rSlider.minimum = 1;
			rSlider.setSize(600,16);
			rSlider.alpha = 0.75;
			rSlider.value = r;
			r2Slider = new HUISlider(this,5,65,"R2",onSlide);
			r2Slider.maximum = 12;
			r2Slider.minimum = 1;
			r2Slider.setSize(600,16);
			r2Slider.value = r2;
			r2Slider.alpha = 0.75;
			
			theta = MathUtils.degreesToRadians(Math.floor(thetaSlider.value));
			phi = MathUtils.degreesToRadians(Math.floor(phiSlider.value));
			rep = repSlider.value;
			r = rSlider.value;
			r2 = r2Slider.value;
			
			lissajous(stage.stageWidth*0.5,stage.stageHeight*0.5,0,0);
		}
		private function onSlide(e:Event):void
		{
			update();
		}
		private function tween(e:KeyboardEvent):void
		{
			if(Tweener.removeAllTweens())Tweener.removeAllTweens();count=0;
			Tweener.addTween(thetaSlider,{value:Math.random()*thetaSlider.maximum,time:1,onUpdate:update,onComplete:tickTween});
			count+=1;
		}
		private function tickTween():void
		{
			switch(count)
			{
				case 1:
				Tweener.addTween(phiSlider,{value:Math.random()*phiSlider.maximum,time:1,onUpdate:update,onComplete:tickTween});
				count+=1
				break;
				
				case 2:
				Tweener.addTween(repSlider,{value:Math.random()*repSlider.maximum,time:1,onUpdate:update,onComplete:tickTween});
				count+=1;
				break;
				
				case 3:
				Tweener.addTween(r2Slider,{value:Math.random()*r2Slider.maximum,time:1,onUpdate:update,onComplete:tickTween});
				count = 0;
				break;
			}
			//Tweener.addTween(thetaSlider,{value:Math.random()*thetaSlider.maximum-thetaSlider.minimum,time:3});
		}
		private function update():void
		{
			theta = MathUtils.degreesToRadians(Math.floor(thetaSlider.value));
			phi = MathUtils.degreesToRadians(Math.floor(phiSlider.value));
			rep = repSlider.value;
			r = rSlider.value;
			r2 = r2Slider.value;
			lissajous(stage.stageWidth*0.5,stage.stageHeight*0.5,0,0);
		}
		private function lissajous(X:Number=0,Y:Number=0,Z:Number=0,colour:uint=0):void
		{
			//cont.graphics.clear();
			//cont.graphics.lineStyle(0,0,1);
			bmd.fillRect(rect,0xffffff);
			for(var t:Number = 0;t<rep*Math.PI;t+=.01)
			{
				var xPos:Number = r * Math.sin(theta*t) * Math.cos(phi*t)+X;
				//var zPos:Number = r * Math.cos(theta*t)+Z;
				var yPos:Number = r * Math.sin(theta*t) * Math.sin(phi*t)+Y;
				//if(t==0)cont.graphics.moveTo(xPos,yPos)
				//else cont.graphics.lineTo(xPos,yPos);
				bmd.setPixel(xPos,yPos,colour);
			}
			
			for(t=0;t<rep*Math.PI;t+=.01)
			{
				xPos = r2 * Math.sin(100*theta*t) * Math.cos(100*phi*t) + r * Math.sin(theta*t) * Math.cos(phi*t)+X;
				//zPos = r2 * Math.cos(100*theta*t) + r * Math.cos(theta*t)+Z;
				yPos = r2 * Math.sin(100*theta*t) * Math.sin(100*phi*t) + r * Math.sin(theta*t) * Math.sin(phi*t)+Y;
				//if(t==0)cont.graphics.moveTo(xPos,yPos)
				//else cont.graphics.lineTo(xPos,yPos);
				bmd.setPixel(xPos,yPos,colour);
			}
		}
	}
}