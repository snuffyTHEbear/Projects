package AdvancedCollisionDetection
{
	import com.arcticcode.greenFlames.graphics.CreateStar;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class BitmapHitTest extends Sprite
	{	
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;	
		private var star1:CreateStar;
		private var star2:CreateStar;
		private var bmd1:BitmapData;
		private var bmd2:BitmapData;
		
		public function BitmapHitTest()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			init();
		}
		private function init():void
		{
			star1 = new CreateStar(25);
			star1.move(centreX,centreY);
			addChild(star1);
			
			star2 = new CreateStar(15);
			star2.move(10,10);
			addChild(star2);
			
			bmd1 = new BitmapData(stage.stageWidth,stage.stageHeight,true,0);
			bmd2 = bmd1.clone();
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		private function loop(e:Event):void
		{
			star2.x += 5;
			star2.y += 3;
			if(star2.x >= stage.stageWidth + star2.width/2)
			{
				star2.x = -star2.width/2;
			}
			else if(star2.x <= -star2.width/2)
			{
				star2.x = stage.stageWidth + star2.width/2; 
			}
			if(star2.y >= stage.stageHeight + star2.height/2)
			{
				star2.y = -star2.height/2;
			}
			else if(star2.y <= -star2.height/2)
			{
				star2.y = stage.stageHeight + star2.height/2; 
			}
			bmd1.fillRect(bmd1.rect,0);
			bmd2.fillRect(bmd1.rect,0);
			
			bmd1.draw(star1,new Matrix(1,0,0,1,star1.x,star1.y));
			bmd2.draw(star2,new Matrix(1,0,0,1,star2.x,star2.y));
			
			if(bmd1.hitTest(new Point(),255,bmd2,new Point(),255))
			{
				star1.filters = [new GlowFilter()];
			}
			else
			{
				star1.filters = [];
			}
		}
	}
}