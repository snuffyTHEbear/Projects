/*
package
{
	import caurina.transitions.Tweener;
	
	import com.arcticcode.greenFlames.graphics.ColourUtils;
	import com.arcticcode.greenFlames.graphics.CreateCircle;
	import com.arcticcode.greenFlames.preloader.ContentLoadedEvent;
	import com.arcticcode.greenFlames.preloader.Preloader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DisplacementMapFilter;
	import flash.filters.DisplacementMapFilterMode;
	import flash.geom.Point;
	
	[SWF(width=600,height=400,backgroundColor=0xFFFFFF)]
	public class PerlinNoiseTests extends Sprite
	{
		private var bmd:BitmapData;
		private var b:Bitmap;
		private var df:DisplacementMapFilter;
		private var offsets:Array;
		private var seed:Number = Math.random()*10;
		private var image:Bitmap;
		private var c:CreateCircle;
		private var bLoader:Preloader = new Preloader("http://farm4.static.flickr.com/3134/2668589394_ec1a84de8b_m_d.jpg",Preloader.IMAGE,false);
		
		public function PerlinNoiseTests()
		{
			init();
		}
		private function init():void
		{
			offsets = new Array(new Point(25,35),new Point(15,5));
			
			bLoader.addEventListener(ContentLoadedEvent.CONTENT_LOADED,onLoaded);
			bLoader.load();
			
			c = new CreateCircle();
			c.startDrag(true);
			addChild(c);
			/*
			bmd = new BitmapData(50,50,false,ColourUtils.getRanColor());
			b = new Bitmap(bmd);
			b.x = 50;
			b.y = 50;
			addChild(b);
			bmd.perlinNoise(50,50,2,seed,false,true,2|3|1,false,offsets);
			
		}
		private function onLoaded(e:ContentLoadedEvent):void
		{
			image = e.content as Bitmap;
			image.x = 200;
			image.y = 50;
			addChild(image);
			
			bmd = new BitmapData(image.width,image.height,true,0x00000000);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			onTween();
		}
		private function onTween():void
		{
			Tweener.addTween(c,{radius:Math.random()*50+2,time:1,onComplete:onTween});
		}
		private function onEnterFrame(e:Event):void
		{
			/*
			offsets[0].x += 2;
			offsets[0].y += 2;
			offsets[1].x -= 1;
			offsets[1].y -= 1;
			
			bmd.perlinNoise(50,50,1,seed,false,true,1,false,offsets);
			
			//c.color = ColourUtils.getRanColor();
			bmd.draw(c,c.transform.matrix);
			df = new DisplacementMapFilter(bmd,new Point(0,0),1,1,3,3,DisplacementMapFilterMode.COLOR);
			image.filters = [df];
		}
	}
}
*/
//Clouds
/*
package {
    import flash.display.Sprite;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.events.Event;
    import flash.geom.Point;

    public class PerlinNoiseTests extends Sprite {
        private var _bitmap:BitmapData;
        private var _xoffset:int = 0;

        public function PerlinNoiseTests(  ) {
            _bitmap = new BitmapData(stage.stageWidth, stage.stageHeight,
                                 true, 0xffffffff);
            var image:Bitmap = new Bitmap(_bitmap);
            addChild(image);
            addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }

        public function onEnterFrame(event:Event):void {
            _xoffset++;
            var point:Point = new Point(_xoffset, 0);

            // use the same point in both elements
            // of the offsets array
            _bitmap.perlinNoise(200, 100, 2, 1000, false, true,
                            1, true, [point, point]);
        }
    }
}
*/
package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	public class PerlinNoiseTests extends Sprite
	{
		private var bmd1:BitmapData;
		private var bmd2:BitmapData;
		private var b:Bitmap;
		private var seed:uint=1000;
		
		public function PerlinNoiseTests():void
		{
			init();
		}
		private function init():void
		{
			bmd1 = new BitmapData(stage.stageWidth,stage.stageHeight,false,0xffffff);
			bmd2 = new BitmapData(stage.stageWidth,stage.stageHeight,false,0xffffff);
			b = new Bitmap(bmd1);
			
			addChild(b);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, destroy);
			stage.addEventListener(MouseEvent.CLICK, generate);
		}
		private function destroy(e:KeyboardEvent):void
		{
			bmd1.fillRect(bmd1.rect,0xffffff);
		}
		private function generate(e:MouseEvent):void
		{
			//for(var i:uint=0;i<30;i++)
			//{
				seed = Math.random()*1000;
				bmd2.perlinNoise(getRanUINT(100)+2,getRanUINT(100)+2,3,seed,false,true,7,true);
				//bmd1.draw(bmd2,null,null,BlendMode.DIFFERENCE);
				bmd1.draw(bmd2);
			//}
		}
		private function getRanUINT(val:uint=10):uint
		{
			return Math.floor(Math.random()*val);
		}
	}
}