package {
	import flash.display.Sprite;

	public class Main extends Sprite
	{		
		public function Main()
		{	
			for(var angle:Number = 0; angle < Math.PI * 2; angle += .1){
				trace(Math.sin(angle));
			}
		}
	}
}
