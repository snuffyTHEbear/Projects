package
{
	import com.arcticcode.greenFlames.graphics.abstract.Amoeba3D;
	
	import flash.display.Sprite;
	import flash.events.Event;
	[SWF(width=600,height=400,backgroundColor=0xFFFFFF)]
	public class ThreeDeeAmoebas extends Sprite
	{
		private var viewX:Number = stage.stageWidth*0.5;
		private var viewY:Number=stage.stageHeight*0.5;
		private var a:Amoeba3D;
		public function ThreeDeeAmoebas()
		{
			init();
		}
		private function init():void
		{
			a = new Amoeba3D(100,100,0,0,3,viewX,viewY);
			a.draw();
			addChild(a);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(e:Event):void
		{
			var angleX:Number = (mouseY - viewY) * .001;
			var angleY:Number = (mouseX - viewX) * .001;
			a.rotateX(angleX);
			a.rotateY(angleY);
			a.draw();
		}
	}
}