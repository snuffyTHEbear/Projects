package
{
	import com.arcticcode.greenFlames.utils.DisplayUtils;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	[SWF(width=600,height=400,backgroundColor=0xFFFFFF)]
	public class ASCIITests extends Sprite
	{
		[Embed(source="/assets/image1.jpg")]
		private var ImageClass:Class;
		private var image:Bitmap;
		
		public function ASCIITests()
		{
			init();
		}
		private function init():void
		{
			image = new ImageClass();
			DisplayUtils.doCentreOne(image,stage.stageWidth,stage.stageHeight);
			addChild(image);
		}
	}
}