package{
	import flash.display.Sprite;
	
	public class Lines extends Sprite{
		
		public function Lines(){
			graphics.lineStyle(1, 0xff0000, 1);
			graphics.moveTo(250,1);
			graphics.lineTo(250,399);
		}
	}
}