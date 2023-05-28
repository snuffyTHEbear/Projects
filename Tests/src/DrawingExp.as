package
{
	import com.arcticcode.greenFlames.isometric.core.IsometricEngine;
	import com.arcticcode.greenFlames.isometric.math.IsoMath;
	import com.bit101.components.PushButton;
	import com.bit101.components.Text;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width=1000, height = 700, backgroundColor = 0xffffff)]
	public class DrawingExp extends Sprite
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		
		private var centreY:Number = stage.stageHeight * 0.5;
		
		private var engine:IsometricEngine;
		
		private var cont:Sprite;
		
		private var startAngleA:Number = 0;
		
		private var startAngleB:Number = 180;
		
		private var angleIncr:Number = 1;
		
		private var startNum:Number = -15;
		
		private var endNum:Number = 15;
		
		private var incr:Number = 1;
		
		private var colourMult:uint = 10000000;
		
		//
		private var bmd:BitmapData;
		
		private var b:Bitmap;
		
		//
		private var processBtn:PushButton;
		
		private var startAngleAInput:Text;
		
		private var startAngleBInput:Text;
		
		private var angleIncrInput:Text;
		
		private var startNumInput:Text;
		
		private var endNumInput:Text;
		
		private var incrInput:Text;
		
		private var colourMultInput:Text;
		
		public function DrawingExp()
		{
			init();
		}
		
		private function init():void
		{
			engine = new IsometricEngine(null, centreX, centreY, IsometricEngine.RIGHT, false, true);
			
			cont = new Sprite();
			addChild(cont);
			
			gui();
			
			process();
		
			//cont.filters = [new DropShadowFilter()];
		}
		
		private function gui():void
		{
			startAngleAInput = new Text(this, 5, 5, startAngleA.toString());
			doLooks(startAngleAInput);
			startAngleBInput = new Text(this, 5, 25, startAngleB.toString());
			doLooks(startAngleBInput);
			angleIncrInput = new Text(this, 5, 50, angleIncr.toString());
			doLooks(angleIncrInput);
			startNumInput = new Text(this, 5, 75, startNum.toString());
			doLooks(startNumInput);
			endNumInput = new Text(this, 5, 100, endNum.toString());
			doLooks(endNumInput);
			incrInput = new Text(this, 5, 125, incr.toString());
			doLooks(incrInput);
			colourMultInput = new Text(this, 5, 150, colourMult.toString());
			doLooks(colourMultInput, 100);
			processBtn = new PushButton(this, 5, 175, "Process", onProcessClick);
		}
		
		private function onProcessClick(e:Event):void
		{
			startAngleA = Number(startAngleAInput.text);
			startAngleB = Number(startAngleBInput.text);
			angleIncr = Number(angleIncrInput.text);
			startNum = Number(startNumInput.text);
			endNum = Number(endNumInput.text);
			incr = Number(incrInput.text);
			colourMult = uint(colourMultInput.text);
			process();
		}
		
		private function doLooks(param:Text, w:Number = 50):void
		{
			param.setSize(w, 20);
		}
		
		private function process():void
		{
			cont.graphics.clear();
			
			var Y:Number = 0;
			engine.angle = startAngleA;
			
			//cont.graphics.lineStyle(0,0);
			cont.graphics.moveTo(IsoMath.xFlash(0, 0, 0, engine.angle, engine.xOrigin), IsoMath.yFlash(0, 0, 0, engine.angle, engine.yOrigin));
			
			for (var i:Number = startNum; i < endNum; i += incr)
			{
				for (var j:Number = startNum; j < endNum; j += incr)
				{
					Y += 0.5;
					engine.angle += angleIncr;
					cont.graphics.lineStyle(1, (j * 10) * colourMult);
					cont.graphics.lineTo(IsoMath.xFlash(i * 10, 0, j * 10, engine.angle, engine.xOrigin), IsoMath.yFlash(i * 10, 0, j * 10, engine.angle, engine.yOrigin));
					//cont.graphics.beginFill((i*10)*10000000);
					cont.graphics.drawCircle(IsoMath.xFlash(i * 10, 0, j * 10, engine.angle, engine.xOrigin), IsoMath.yFlash(i * 10, 0, j * 10, engine.angle, engine.yOrigin), 2);
					cont.graphics.moveTo(IsoMath.xFlash(i * 10, 0, j * 10, engine.angle, engine.xOrigin), IsoMath.yFlash(i * 10, 0, j * 10, engine.angle, engine.yOrigin));
				}
			}
			
			//engine.angle = IsometricEngine.LEFT;
			
			//cont.graphics.lineStyle(0,0);
			cont.graphics.moveTo(IsoMath.xFlash(0, 0, 0, engine.angle, engine.xOrigin), IsoMath.yFlash(0, 0, 0, engine.angle, engine.yOrigin));
			
			//trace(Y,15*15/2);
			Y = 0;
			engine.angle = startAngleB;
			
			for (i = startNum; i < endNum; i += incr)
			{
				for (j = startNum; j < endNum; j += incr)
				{
					Y += 0.5;
					engine.angle -= angleIncr;
					cont.graphics.lineStyle(1, (j * 10) * colourMult);
					cont.graphics.lineTo(IsoMath.xFlash(i * 10, 0, j * 10, engine.angle, engine.xOrigin), IsoMath.yFlash(i * 10, 0, j * 10, engine.angle, engine.yOrigin));
					//cont.graphics.beginFill((i*10)*10000000);
					cont.graphics.drawCircle(IsoMath.xFlash(i * 10, 0, j * 10, engine.angle, engine.xOrigin), IsoMath.yFlash(i * 10, 0, j * 10, engine.angle, engine.yOrigin), 2);
					cont.graphics.moveTo(IsoMath.xFlash(i * 10, 0, j * 10, engine.angle, engine.xOrigin), IsoMath.yFlash(i * 10, 0, j * 10, engine.angle, engine.yOrigin));
				}
			}
		}
	}
}