package
{
	import com.arcticcode.greenFlames.utils.DisplayUtils;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	[SWF(width=600,height=400,backgroundColor=0xFFFFFF)]
	[Frame(factoryClass="com.arcticcode.greenFlames.preloader.BasePreloader")]
	public class BaseTests extends Sprite
	{
		//[Embed(source="/assets/MCMbig.jpg")]
		//private var Asset:Class;
		
		public function BaseTests()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event):void
		{
			/*var image:Bitmap = new Asset();
			image.scaleX = image.scaleY = 0.5;
			DisplayUtils.doCentreOne(image,stage.stageWidth,stage.stageHeight);
			addChild(image);*/
		}
	}
}