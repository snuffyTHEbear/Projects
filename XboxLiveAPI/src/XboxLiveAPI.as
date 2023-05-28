////////////////////////////////////////////////////////////////////////////////
//   Robert Daniels - http://arctic-code.com 
////////////////////////////////////////////////////////////////////////////////

package
{
	import com.arcticcode.xbox360.GamerCard;
	import flash.display.Sprite;
	[SWF( width=640, height=480 )]
	public class XboxLiveAPI extends Sprite
	{
		
		public function XboxLiveAPI()
		{
			_gamertag = new GamerCard( "snuffyTHEbear", gamertagReady, GamerCard.LARGE );
		}
		
		private var _gamertag:GamerCard;
		private var centerX:Number = stage.stageWidth * 0.5;
		
		private var centerY:Number = stage.stageHeight * 0.5;
		
		private function gamertagReady():void
		{
			_gamertag.move( centerX, centerY );
			addChild( _gamertag );
		}
	}
}