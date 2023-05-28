package
{
	import com.arcticcode.greenFlames.components.MemFpsCount;
	import com.arcticcode.greenFlames.isometric.ComplexIsometricObject;
	import com.arcticcode.greenFlames.isometric.IsometricEngine;
	import com.arcticcode.greenFlames.isometric.IsometricObject;
	import com.arcticcode.greenFlames.ui.BasicContextMenu;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.ContextMenu;
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class PerlinIsometrics extends Sprite
	{
		private var bmd:BitmapData;
		private var b:Bitmap;
		private var wid:uint = 10;
		private var hei:uint = 10;
		private var engine:IsometricEngine;
		private var grid:ComplexIsometricObject;
		private var centreX:Number = stage.stageWidth*0.5;
		private var centreY:Number = stage.stageHeight*0.5;
		private var xOff:Number = 0;
		private var yOff:Number = 0;
		private var xInc:Number = Math.random()*5-2.5;
		private var yInc:Number = Math.random()*5-2.5;
		private var _fm:MemFpsCount;
		private var cm:ContextMenu;
		private var float:Boolean = true;
		private var seed:Number = Math.random()*1000;
		
		public function PerlinIsometrics()
		{
			init();
		}
		private function init():void
		{
			bmd = new BitmapData(wid,hei,false,0);
			//b = new Bitmap(bmd);
			//addChild(b);
			
			cm = BasicContextMenu.buildMenu(true,"Arctic-Code",null);
			this.contextMenu = cm;
			
			_fm = new MemFpsCount();
			_fm.autoUpdate = false;
			addChild(_fm);
			
			engine = new IsometricEngine(null,centreX,stage.stageHeight-10,26.57,false,true);
			grid = new ComplexIsometricObject();
			engine.g = grid.graphics;
			
			for(var i:uint=0;i<wid;i++)
			{
				for(var j:uint=0;j<hei;j++)
				{
					grid.addObject(new IsometricObject(i*10,0,j*10,10,0,10,false,0,true,0xffffff));
				}
			}
			
			for(i=grid.objects.length;i>0;i--)
			{
				engine.drawObject(grid.objects[i-1]);
			}
			
			addChild(grid);
			
			//bmd.perlinNoise(wid,hei,2,333,false,true,7,true);
			stage.addEventListener(MouseEvent.CLICK, onClick);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onClick(e:MouseEvent):void
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			for(var i:uint=0;i<grid.objects.length;i++)
			{
				grid.objects[i].y = 0;
				grid.objects[i].h = 0;
			}
			
			xInc = Math.random()*5-2.5;
			yInc = Math.random()*5-2.5;
			seed = Math.random()*1000;
			
			float =! float;
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(e:Event):void
		{
			xOff += xInc;
			yOff += yInc;
			var point:Point = new Point(xOff,yOff);
			bmd.perlinNoise(100,100,3,seed,false,false,7,false,[point,point]);
			var i:uint=0;
			var j:uint=0;
			var yVal:Number=0;
			var count:uint=grid.objects.length;
			grid.graphics.clear();
			//engine.g = grid.graphics;
			if(float)
			{
				for(i=0;i<wid;i++)
				{
					for(j=0;j<hei;j++)
					{
						yVal = bmd.getPixel(i,j) / 100000;
						grid.objects[count-1].y = yVal;
						grid.objects[count-1].fillColour = bmd.getPixel(i,j);
						engine.drawObject(grid.objects[count-1]);
						
						count-=1;
					}
				}
			}
			else
			{
				for(i=0;i<wid;i++)
				{
					for(j=0;j<hei;j++)
					{
						yVal = bmd.getPixel(i,j) / 100000;
						grid.objects[count-1].h = yVal;
						grid.objects[count-1].fillColour = bmd.getPixel(i,j);
						engine.drawObject(grid.objects[count-1]);
						
						count-=1;
					}
				}
			}
			
			_fm.calculate();
		}
	}
}