package
{
	import com.arcticcode.greenFlames.math.Lissajous;
	import com.arcticcode.greenFlames.threeDee.geom.Point3D;
	import com.arcticcode.greenFlames.utils.FPSMeter;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class DumpCode extends Sprite
	{
		private var lc:Lissajous;
		
		private var angle:Number = 0;
		
		private var _fpsMeter:FPSMeter;
		
		public function DumpCode()
		{
			_fpsMeter = new FPSMeter(false);
			addChild(_fpsMeter);
			
			lc = new Lissajous();
			addChild(lc);
			lc.x = stage.stageWidth * 0.5;
			lc.y = stage.stageHeight * 0.5;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function update():void
		{
			lc.render(Lissajous.CURVE);
		}
		
		private function onEnterFrame(e:Event):void
		{
			lc.rotationY += 
			(mouseX - 
			stage.stageWidth * 0.5) * .0001;
			lc.rotationX += (mouseY - stage.stageHeight * 0.5) * .0001;
			update();
			_fpsMeter.update();
		}
	}
}