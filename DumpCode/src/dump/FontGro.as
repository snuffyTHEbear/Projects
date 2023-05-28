//page 32 - comuters & imag
package
{
	import com.arcticcode.greenFlames.components.MemFpsCount;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	
	public class FontGro extends Sprite
	{
		//[Embed(source="/assets/fallout3.jpg")]
		//private var _image:Class;
		private var b2:Bitmap;
		private var bmd:BitmapData;
		private var b:Bitmap;
		private var mf:MemFpsCount;
		private var points:Array = new Array({x:stage.stageWidth*0.5,y:stage.stageHeight*0.5});
		
		public function FontGro()
		{
			init();
		}
		private function init():void
		{
			//b2 = new _image();
			//addChild(b2);
			
			bmd = new BitmapData(stage.stageWidth,stage.stageHeight,false,0xffffff);
			b = new Bitmap(bmd);
			//b.alpha = 0.75;
			addChild(b);
			
			mf = new MemFpsCount();
			mf.autoUpdate = false;
			addChild(mf);
			
			fillPoint(points[0]);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(e:Event):void
		{
			trace(points.length);
			if(points.length==0)
			{
				removeEventListener(Event.ENTER_FRAME,onEnterFrame);
			}
			for(var i:uint=0;i<1000;i++)
			{
				var p:Object = {x:0,y:0};
				var ind:uint = Math.floor(Math.random()*points.length);
				p.x = points[ind].x += (Math.random() > 0.5 ? 1 : -1);
				p.y = points[ind].y += (Math.random() > 0.5 ? 1 : -1);
				if(!checkPoint(p))
				{
					points.push(Object({x:p.x,y:p.y}));
					//trace("M"+points.length,points[points.length-1].x);
					fillPoint(points[points.length-1]);
				}
				
				checkNeighbours(points[ind]);
			}
			
			mf.calculate();
		}
		private function checkPoint(p:Object):Boolean
		{
			return (bmd.getPixel(p.x,p.y)== 0) ? true : false;
		}
		private function checkNeighbours(p:Object):void
		{
			if((checkPoint({x:p.x-1,y:p.y-1})) 
			&& (checkPoint({x:p.x+1,y:p.y+1})) 
			&& (checkPoint({x:p.x-1,y:p.y+1})) 
			&& (checkPoint({x:p.x+1,y:p.y-1}))
			&& checkPoint(p))
			{
				points.splice(points.indexOf(p),1);
			}
		}
		private function fillPoint(point:Object):void
		{
			bmd.setPixel(point.x,point.y,0);
		}
	}
}