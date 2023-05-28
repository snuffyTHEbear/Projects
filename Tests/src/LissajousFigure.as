package
{
	import com.arcticcode.greenFlames.math.MathUtils;
	import com.arcticcode.greenFlames.components.MemFpsCount;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	[SWF(width=600, height = 400, backgroundColor = 0xffffff)]
	public class LissajousFigure extends Sprite
	{
		private var theta:Number = MathUtils.degreesToRadians(30);
		
		private static var phi:Number = MathUtils.degreesToRadians(12);
		
		private static var rep:Number = 30;
		
		private static var r:Number = 60;
		
		private static var r2:Number = 2;
		
		private var cont:Sprite;
		
		private var bmd:BitmapData;
		
		private var b:Bitmap;
		
		public function LissajousFigure()
		{
			var theta:Number = MathUtils.degreesToRadians(30);
			var phi:Number = MathUtils.degreesToRadians(12);
			var rep:Number = 30;
			var r:Number = 60;
			var r2:Number = 2;
			
			
			
			//
			trace(stage.stageWidth, stage.stageHeight);
			init();
		}
		
		private function init():void
		{
			bmd = new BitmapData(stage.stageWidth, stage.stageHeight, false, 0xffffff);
			b = new Bitmap(bmd);
			addChild(b);
			
			var _fm:MemFpsCount = new MemFpsCount();
			addChild(_fm);
			
			stage.addEventListener(MouseEvent.CLICK, onClick)
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onClear);
		}
		
		private function onClear(e:KeyboardEvent):void
		{
			bmd.fillRect(new Rectangle(0, 0, bmd.width, bmd.height), 0xffffff);
		}
		
		private function onClick(e:MouseEvent):void
		{
			theta = MathUtils.degreesToRadians(Math.floor(Math.random() * 60 + 10));
			phi = MathUtils.degreesToRadians(Math.floor(Math.random() * 24 + 6));
			//rep = Math.floor(Math.random()*40+10);
			//r = Math.random()*40+10;
			r2 = Math.floor(Math.random() * 8 + 2);
			//
			lissajous(bmd, b.mouseX, b.mouseY, 0, Math.random() * 0xffffff);
		}
		
		private function lissajous(bmd:BitmapData = null, X:Number = 0, Y:Number = 0, Z:Number = 0, colour:uint = 0):void
		{
			//cont.graphics.lineStyle(0,0,1);
			var shape:Shape = new Shape();
			shape.x = X;
			shape.y = Y;
			shape.graphics.lineStyle(0, colour);
			
			for(var t:Number = 0; t < rep * Math.PI; t += .01)
			{
				var xPos:Number = r * Math.sin(theta * t) * Math.cos(phi * t) + X;
				var zPos:Number = r * Math.cos(theta * t) + Z;
				var yPos:Number = r * Math.sin(theta * t) * Math.sin(phi * t) + Y;
				if(t == 0)
					shape.graphics.moveTo(xPos, yPos)
				else
					shape.graphics.lineTo(xPos, yPos);
					//bmd.setPixel(xPos,yPos,colour);
			}
			
			for(t = 0; t < rep * Math.PI; t += .01)
			{
				xPos = r2 * Math.sin(100 * theta * t) * Math.cos(100 * phi * t) + r * Math.sin(theta * t) * Math.cos(phi * t) + X;
				zPos = r2 * Math.cos(100 * theta * t) + r * Math.cos(theta * t) + Z;
				yPos = r2 * Math.sin(100 * theta * t) * Math.sin(100 * phi * t) + r * Math.sin(theta * t) * Math.sin(phi * t) + Y;
				if(t == 0)
					shape.graphics.moveTo(xPos, yPos)
				else
					shape.graphics.lineTo(xPos, yPos);
					//bmd.setPixel(xPos,yPos,colour);
			}
			bmd.draw(shape);
			shape.graphics.clear();
			shape = null;
		}
	}
}