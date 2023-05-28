/***********************************************
 
 HYPE
 http://hype.joshuadavis.com
 developed by Branden Hall and Joshua Davis.
 
 ************************************************/

import hype.extended.behavior.FunctionTracker;
import hype.extended.color.ColorPool;
import hype.extended.layout.GridLayout;
import hype.framework.display.BitmapCanvas;
import hype.framework.sound.SoundAnalyzer;

var myWidth = stage.stageWidth;
var myHeight = stage.stageHeight;

var clipCanvas:BitmapCanvas = new BitmapCanvas(myWidth, myHeight);
addChild(clipCanvas);

var clipContainer:Sprite = new Sprite();

var soundAnalyzer:SoundAnalyzer = new SoundAnalyzer();
soundAnalyzer.start();

var colorPool:ColorPool = new ColorPool(
	0x587b7C, 0x719b9E, 0x9FC1BE, 0xE0D9BB, 0xDACB94, 0xCABA88, 0xDABD55, 0xC49F32, 0xA97409
);

// xStart, yStart, xSpacing, ySpacing, columns

var layout:GridLayout = new GridLayout(0, 0, 10, 0, 64);

var numItems:int = 64;

for (var i:uint = 0; i < numItems; ++i) {
	var clip:MySquare = new MySquare();
	
	layout.applyLayout(clip);
	colorPool.colorChildren(clip);
	
	// object, property, soundAnalyzer.getFrequencyRange, [startRange, endRange, min, max]
	
	var yTracker:FunctionTracker = new FunctionTracker(clip, "y", soundAnalyzer.getFrequencyRange, [i*4, i*4+4, -20, 380]);
	yTracker.start();
	
	clipContainer.addChild(clip);
}

clipCanvas.startCapture(clipContainer, true);

var sound:Sound = new Sound();
sound.load(new URLRequest("bambam.mp3"));
sound.play();

/***********************************************
 
 "Retrice" from Gular Flutter by
 blevin blectum / bevin keley
 http://blevin.LSR1.com
 
 ************************************************/





package
{
	public class ScrapCode
	{
		public function ScrapCode()
		{
		}
	}
}

//var bmd2:BitmapData = new BitmapData(bmd.width,bmd.height,true,0x00ffffff);
			//bmd.fillRect(bmd.rect,0);
			//bmd2.lock();
			//bmd.lock();
			//bmd.fillRect(bmd.rect,0x00000000);
		/* var a:Number = Math.random();
		   var b:Number = a;
		   var c:Number = a;
		   col1b += a-a/2;
		   col2b += a-a/2;
		   col1g += b-b/2
		   col2g += b-b/2
		   col1r += c-c/2
		 col2r += c-c/2; */

			 //color2 = 4278190080 | uint(255 * (col1r * (col2r - col1r))) << 16 | uint(255 * (col1g * (col2g - col1g))) << 8 | uint(255 * (col1b * (col2b - col1b)));

			 //SoundMixer.computeSpectrum(ba, true, 0);
			 //color = uint(Math.random() * 256) << 16 | uint(Math.random() * 256) << 8 | uint(Math.random() * 256);
			 //cont.graphics.moveTo(centreX,centreY);
		/* for(i=0;i<512;i++)
		   {
		   //cont.graphics.clear();
		   val = ba.readFloat();
		   //cont.graphics.moveTo((i*2-0.5)+50,point.y);
		   cont.graphics.lineStyle(2,color2,0.75);
		   cont.graphics.lineTo(Math.cos(i)*(val*100)+centreX,Math.sin(i)*(val*100)+centreY);
		   //cont.graphics.lineTo(450, centreY - val*50);
		   //cont.graphics.curveTo((i*2-0.5)+50,centreY - val * 200,(i*2-0.5 + Math.random()*50-25)+50,centreY + Math.random()*val*100-val*50);
		   //point.y = centreY - val*50;
		   //cont.graphics.lineTo((i*2-0.5)+50,centreY-val*500);
		   /* cont.graphics.moveTo(i,stage.stageHeight-50);
		   cont.graphics.lineStyle(1, 0xffffff,0.75);
		 cont.graphics.drawCircle(i,Math.random()*stage.stageWidth,val*15); */
			 //bmd.draw(cont,cont.transform.matrix);
			 //} 
			 //bmd2.draw(cont,cont.transform.matrix);
			 //bmd2.unlock();
			 //bmd.draw(bmd2,null,null,BlendMode.DIFFERENCE);
			 //	bmd.scroll(-5,0);
			 //bmd.applyFilter(bmd,bmd.rect,new Point(),new BlurFilter());
			 //bmd.unlock();
			 //bmd2 = null;