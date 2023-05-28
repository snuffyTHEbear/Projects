package com.tests
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ZoomingTests extends Sprite
	{
		private var cont:Sprite;
		
		public function ZoomingTests()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void
		{
			cont = new Sprite();
			cont.x = stage.stageWidth * 0.5;
			cont.y = stage.stageHeight * 0.5;
			addChild(cont);
			cont.z = 0;
			
			makeChildren();
		}
		private function makeChildren():void
		{
			for (var i:uint=15; i>0; i--)
			{
				var sp:Sprite = new Sprite();
				sp.addEventListener(MouseEvent.CLICK, onClick);
				sp.graphics.beginFill(Math.random() * 0xFFFFFF);
				sp.graphics.drawRect(0, 0, 300, 300);
				sp.x = -i * 20;
				sp.x -= sp.width * 0.5;
				sp.y = -i * 20;
				sp.y -= sp.height * 0.5;
				//sp.rotationY = Math.random() * 45;
				sp.z = i * 20;
				cont.addChild(sp);
				if(i == 1)
				{
					cont.x = -sp.x + sp.width * 0.5;
					cont.y = -sp.y + sp.height * 0.25;
					cont.z = -sp.z + 100;
				}
			}
		}
		
		private function onClick(e:MouseEvent):void
		{
			var sp:Sprite = Sprite(e.target);
			cont.x = -sp.x + sp.width * 0.5;
			cont.y = -sp.y + sp.height * 0.25;
			cont.z = -sp.z + 100;
			//Tweener.addTween(cont,{x:-sp.x+150,y:-sp.y+75, z:-sp.z+100, time:1});
		}
	}
}