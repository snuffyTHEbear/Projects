package{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import robDaniels.greenFlames.src.graphics.Tree;
	[SWF(backgroundColor=0x000000)]
	public class Trees extends Sprite{
		private var trees:Array;
		private var numTrees:uint = 100;
		private var fl:Number = 250;
		private var vpX:Number = stage.stageWidth / 2;
		private var vpY:Number = stage.stageHeight / 2;
		private var floor:Number = 50;
		private var ax:Number = 0;
		private var ay:Number = 0;
		private var az:Number = 0;
		private var vx:Number = 0;
		private var vy:Number = 0;
		private var vz:Number = 0;
		private var gravity:Number = 0.3;
		private var friction:Number = 0.98;		
		public function Trees(){
			init();
		}
		private function init():void{
			trees = new Array();
			for(var i:uint = 0; i < numTrees;i++)
			{
				var tree:Tree = new Tree();
				trees.push(tree);
				tree.xPos = Math.random()*2000 - 1000;
				tree.yPos = floor;
				tree.zPos = Math.random()*10000;
				addChild(tree);
			}
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		private function onEnterFrame(event:Event):void{
			vx += ax;
			vy += ay;
			vz += az;
			vy -= gravity;
			for(var i:uint = 0;i<numTrees;i++)
			{
				var tree:Tree = trees[i];
				move(tree);
			}
			vx *= friction;
			vy *= friction;
			vz *= friction;
			sortZ();
		}
		private function onKeyDown(event:KeyboardEvent):void{
			switch(event.keyCode)
			{
				case Keyboard.UP:
				az = -1;
				break;
				
				case Keyboard.DOWN:
				az = 1;
				break;
				
				case Keyboard.LEFT:
				ax = 1;
				break;
				
				case Keyboard.RIGHT:
				ax = -1;
				break;
				
				case Keyboard.SPACE:
				ay = 1;
				break;
				
				default:
				break;
			}
		}
		private function move(tree:Tree):void{
			tree.xPos += vx;
			tree.yPos += vy;
			tree.zPos += vz;
			
			if(tree.yPos < floor)
			{
				tree.yPos = floor;
			}
			
			if(tree.zPos < -fl)
			{
				tree.zPos += 10000;
			}
			if(tree.zPos > 10000 - fl)
			{
				tree.zPos -= 10000;
			}
			var scale:Number = fl / (fl+tree.zPos);
			tree.scaleX = tree.scaleY = scale;
			tree.x = vpX + tree.xPos * scale;
			tree.y = vpY + tree.yPos * scale;
			tree.alpha = scale * .7 + .3;
		}
		private function sortZ():void{
			trees.sortOn("zPos", Array.DESCENDING | Array.NUMERIC);
			for(var i:uint = 0; i < numTrees;i++)
			{
				var tree:Tree = trees[i];
				setChildIndex(tree, i);
			}
		}
		private function onKeyUp(event:KeyboardEvent):void{
			switch(event.keyCode)
			{
				case Keyboard.UP:
				case Keyboard.DOWN:
				az = 0;
				break;
				
				case Keyboard.LEFT:
				case Keyboard.RIGHT:
				ax = 0;
				break;
				
				case Keyboard.SPACE:
				ay = 0;
				break;
				
				default:
				break;
			}
		}
	}
}