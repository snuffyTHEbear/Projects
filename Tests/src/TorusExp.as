package
{
	import com.arcticcode.greenFlames.isometric.geom.IsoPoint3D;
	import com.arcticcode.greenFlames.display.DisplayUtils;
	import com.arcticcode.greenFlames.graphics.curves.QuadBez3D;
	import com.arcticcode.greenFlames.isometric.core.IsometricEngine;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width=600, height = 400, backgroundColor = 0xffffff)]
	public class TorusExp extends Sprite
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		
		private var centreY:Number = stage.stageHeight * 0.5;
		
		private var bmd:BitmapData;
		
		private var b:Bitmap;
		
		private var phi:Number = 0;
		
		private var r:Number = 0;
		
		private var p:Number = 1;
		
		private var q:Number = 16;
		
		private var engine:com.arcticcode.greenFlames.isometric.core.IsometricEngine;
		
		private var cont:Sprite;
		
		private var X:Number = 0;
		
		private var Y:Number = 0;
		
		private var Z:Number = 0;
		
		private var points:Array;
		
		public function TorusExp()
		{
			init();
		}
		
		private function init():void
		{
			bmd = new BitmapData(600, 400, false, 0xffffff);
			b = new Bitmap(bmd);
			//addChild(b);
			
			cont = new Sprite();
			addChild(cont);
			
			points = new Array();
			
			engine = new IsometricEngine(null, centreX, centreY, IsometricEngine.RIGHT, false, true);
			
			for (var i:uint = 0; i < 50; i++)
			{
				phi += 0.2;
				r = 0.5 * (2 + Math.sin(q * phi)) * 10;
				X = r * Math.cos(p * phi) * 10;
				Y = r * Math.cos(q * phi) * 10;
				Z = r * Math.sin(p * phi) * 10;
				points.push(new IsoPoint3D(X, Y, Z));
			}
			
			cont.graphics.clear();
			cont.graphics.lineStyle(0, 0);
			QuadBez3D.draw(cont.graphics, points, false, false);
			
			DisplayUtils.doCentreOne(cont, centreX * 2, centreY * 2);
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void
		{
			for (var i:uint = 0; i < points.length; i++)
			{
				points[i].rotateX(0.02);
				points[i].rotateY(0.01);
			}
			cont.graphics.clear();
			cont.graphics.lineStyle(0, 0);
			QuadBez3D.draw(cont.graphics, points, false, false);
		/*cont.graphics.clear();
		   cont.graphics.beginFill(Y*1000000,1);
		   cont.graphics.drawCircle(engine.xFlash(X,Y,Z),engine.yFlash(X,Y,Z),3);
		   cont.graphics.endFill();
		 bmd.draw(cont,cont.transform.matrix);*/
		}
	}
}