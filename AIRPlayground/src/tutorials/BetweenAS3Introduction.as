package tutorials 
{
	import flash.display.NativeWindow;
	import flash.display.Screen;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import org.libspark.betweenas3.BetweenAS3;
	import org.libspark.betweenas3.easing.Elastic;
	import org.libspark.betweenas3.tweens.ITween;
	
	public class BetweenAS3Introduction extends Sprite
	{
		private var _window:NativeWindow;
		private var _tween:ITween
		
		public function BetweenAS3Introduction(window:NativeWindow)
		{
			_window = window;
			
			init();
		}
		private function init():void
		{
			reset();
										 
			_window.stage.addEventListener(MouseEvent.CLICK, stageClick_Handler);
		}
		private function reset():void
		{
			_tween = BetweenAS3.tween(_window, 
											{x:Math.random() * Screen.mainScreen.bounds.width,
										 	y:Math.random() * Screen.mainScreen.bounds.height,
										 	width:Math.random() * 300 + 50,
										 	height:Math.random() * 300 + 50},
										 null,
										 Math.random()*5,
										 Elastic.easeOut);
										 
			_tween.onComplete = reset;
		}
		private function stageClick_Handler(e:MouseEvent):void
		{
			if(_tween.isPlaying)
			{
				_tween.stop();
			}
			else
			{
				if(_tween.position == _tween.duration)
				{
					_tween.gotoAndPlay(0);
				}
				else
				{
					_tween.play();
				}
			}
		}
	}
}