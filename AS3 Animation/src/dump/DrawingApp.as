package{
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	public class DrawingApp extends Sprite{
		
		private var myLineStyle:uint = 20;
		
		public function DrawingApp(){
			init();
		}
		private function init():void{
			graphics.lineStyle(myLineStyle, 0x000000, 1, false, "normal", "round", "round");
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.addEventListener(KeyboardEvent.KEY_UP, onSpaceDown);
		}
		private function onMouseDown(event:MouseEvent):void{
			graphics.moveTo(mouseX, mouseY);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		private function onMouseUp(event:MouseEvent):void{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		private function onMouseMove(event:MouseEvent):void{
			graphics.lineTo(mouseX, mouseY);
			event.updateAfterEvent();
		}
		private function onSpaceDown(event:KeyboardEvent):void{
			if(event.charCode == Keyboard.SPACE){
				graphics.clear();
				graphics.lineStyle(myLineStyle);
			}
		}
	}
}