package {
	import com.arcticcode.greenFlames.graphics.CreateCircle;
	import com.arcticcode.greenFlames.graphics.CreateStar;
	import com.arcticcode.greenFlames.web.GoogleVideoEvent;
	import com.arcticcode.greenFlames.web.getGoogleVideoURL;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class Main extends Sprite
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;
		private var bmd1:BitmapData;
		private var bmd2:BitmapData;
		private var b1:Bitmap;
		private var b2:Bitmap;	
		
		public function Main()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			init();
		}
		private function init():void
		{
			var gv:getGoogleVideoURL = new getGoogleVideoURL("2579833089500205658");
			gv.addEventListener(GoogleVideoEvent.URL_GENERATED, url);
			
			function url(e:GoogleVideoEvent):void
			{
				trace(e.url);
			}
			
			var c:CreateCircle = new CreateCircle(62,true,true,Math.random()*0xffffff,1,4,0);
			addChild(c);
			c.move(centreX,centreY);
			
			var centrePoint:Number = (c.x - c.width / 2) + (c.y - c.height/2);
			var c2:CreateCircle = new CreateCircle(5,true,false,0);
			c2.move(c.x + c.width/2,c.y+c.height/2);
			addChild(c2);
			
			var s:CreateStar = new CreateStar(50);
			//s.move(centreX,centreY);
			
			// make a fixed bitmap, draw the star into it
            bmd1 = new BitmapData(100, 100, true, 0);
            bmd1.draw(s, new Matrix(1, 0, 0, 1, 50, 50));
            b1 = new Bitmap(bmd1);
            b1.x = 200;
            b1.y = 200;
            addChild(b1);
            
            // make a moveable bitmap, draw the star into it, too
            bmd2 = new BitmapData(100, 100, true, 0);
            bmd2.draw(s, new Matrix(1, 0, 0, 1, 50, 50));
            b2 = new Bitmap(bmd2);
            addChild(b2);
            
            stage.addEventListener(MouseEvent.MOUSE_MOVE, move);
		}
		private function move(e:MouseEvent):void
		{
			//b2.x = mouseX-b2.width/2;
			//b2.y = mouseY-b2.width/2;
			
			//if(bmd1.hitTest(new Point(b1.x,b1.y),255,bmd2,new Point(b2.x,b2.y),255))
			if(bmd1.hitTest(new Point(b1.x,b1.y),255,new Point(mouseX,mouseY)))
			{
				b1.filters = [new GlowFilter()];
				b2.filters = [new GlowFilter()];
			}
			else
			{
				b1.filters = [];
				b2.filters = [];
			}
		}
	}
}
