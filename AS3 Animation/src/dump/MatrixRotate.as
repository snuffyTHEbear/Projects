package{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	
	import robDaniels.greenFlames.src.graphics.CreateRect;
	
	public class MatrixRotate extends Sprite{
		private var angle:Number = 0;
		private var box:CreateRect;
		public function MatrixRotate(){
			init();
		}
		private function init():void{
			box = new CreateRect(100,100,0xff0000,1,true,-50,-50);
			addChild(box);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(eent:Event):void
		{
			//Rotation
			/*angle += .05;
			var cos:Number = Math.cos(angle);
			var sin:Number = Math.sin(angle);
			box.transform.matrix = new Matrix(cos, sin, -sin, cos, stage.stageWidth / 2, stage.stageHeight / 2);*/
			//SKEW
			var skewY:Number = (mouseY - stage.stageHeight / 2) * .01;
			var skewX:Number = (mouseX - stage.stageWidth / 2) * .01;
			box.transform.matrix = new Matrix(1,skewY,skewX,1,stage.stageWidth / 2, stage.stageHeight / 2);
		}
	}
}