package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class BasicStage extends Sprite
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;	
		
		public function BasicStage()
		{
			$init();
		}
		protected function $init():void
		{
			stage.align = "topLeft";
			stage.scaleMode = "noScale";	
		}
		protected function $loop(e:Event):void
		{
			
		}
	}
}