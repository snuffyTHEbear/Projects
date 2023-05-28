package
{
	import flash.display.Sprite;
	
	import particles.NodeGarden;
	
	[SWF(width=640, height=480, backgroundColor = 0xffffff, frameRate = 30)]
	public class FoundationAS3Animation extends Sprite
	{
		private var content:Sprite;
		
		public function FoundationAS3Animation()
		{
			stage.align = "topLeft";
			stage.scaleMode = "noScale";
			
			init();
		}
		private function init():void
		{
			content = new NodeGarden();
			addChild(content);		
		}
	}
}