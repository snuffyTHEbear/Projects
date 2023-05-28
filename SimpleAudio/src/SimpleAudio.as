package
{
	import Assets.PlayerCore.UI.UIHandler;
	import Assets.PlayerUI.PlayerUI;
	
	import flash.display.Sprite;
	
	[SWF(width=710,height=610)]
	
	public class SimpleAudio extends Sprite
	{
		private var _ui:PlayerUI;
		private var _uiHandler:UIHandler;
		
		public function SimpleAudio()
		{
			init();
		}
		private function init():void
		{
			stage.nativeWindow.visible = true;
			
			_ui = new PlayerUI();
			addChild(_ui);
			
			_uiHandler = new UIHandler(_ui);
		}
	}
}