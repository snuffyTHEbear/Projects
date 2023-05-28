package
{
	import Matrices.SkewTest;
	
	import flash.display.Sprite;
	
	public class LearningAS3 extends Sprite
	{
		private var _content:Sprite;
		
		public function LearningAS3()
		{
			stage.scaleMode = "noScale";
			stage.align = "topLeft";
			
			_content = new SkewTest(); 
			addChild(_content);
		}
	}
}