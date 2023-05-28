package
{
	import com.arcticcode.greenFlames.linkedList.SimpleList;
	import com.arcticcode.greenFlames.linkedList.nodes.Node;
	
	import flash.display.Sprite;
	import flash.utils.getTimer;
	
	public class LinkedLists extends Sprite
	{
		public function LinkedLists()
		{
			var list:SimpleList = new SimpleList();
			
			var nodeA:Node = new Node(10);
			var nodeB:Node = new Node(38);
			var nodeC:Node = new Node(97);
			nodeB.insertPreviousNode(nodeA);
			nodeB.insertNextNode(nodeC);
			
			list.insertNode(nodeA);
			list.insertNode(nodeB);
			list.insertNode(nodeC);
			
			var t:Number = getTimer();
			trace("Node Start:",t);
			trace(nodeA.getNextNode().getNextNode().getNodeData());
			trace("Node time:", getTimer() - t);
			t = getTimer();
			trace("List start:", t);
			trace(list.firstNode.getNextNode().getNextNode().getNodeData());
			trace("List time:", getTimer() - t);
		}
	}
}