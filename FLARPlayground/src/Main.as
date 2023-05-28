package {
	import flash.display.Sprite;
	
	import org.libspark.flartoolkit.core.FLARCode;

	public class Main extends Sprite
	{
		private var fc:FLARCode;
		
		public function Main()
		{
			fc = new FLARCode(64, 64, 80, 80);
		}
	}
}
