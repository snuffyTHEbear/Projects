package ThreeDee
{
	import com.arcticcode.greenFlames.graphics.Tree;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class DepthSort extends Sprite
	{
		private var trees:Array = new Array();
		
		public function DepthSort()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void
		{
			for(var i:int = 0; i < 500; i++)
			{
				var tree:Tree = new Tree();
				tree.x = Math.random() * stage.stageWidth;
				tree.y = stage.stageHeight - 100;
				tree.z = Math.random() * 10000;
				trees.push(tree);
			}
			
			trees.sortOn("z", Array.NUMERIC | Array.DESCENDING);
			for(i = 0; i < trees.length; i++)
			{
				addChild(trees[i] as Sprite);
			}
		}
	}
}