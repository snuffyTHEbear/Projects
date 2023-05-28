package
{
	import flash.display.Sprite;
	
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class TextExperiments extends Sprite
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;	
		
		public function TextExperiments()
		{
			init();
		}
		private function init():void
		{			
			var str:String = "Robert";
			var arr:Array = str.split("");
			var str2:String = arr.join("");
			trace(str,arr,str2);
		}
	}
}