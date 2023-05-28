package
{
	import flash.display.Sprite;

	import org.tutorials.HelloWorld;

	[SWF( width=850, height=300)]
	public class FlixelTutorials extends Sprite
	{
		public function FlixelTutorials()
		{
			addChild( new HelloWorld(stage.stageWidth / 2, stage.stageHeight / 2));
		}
	}
}