package {
	import com.arcticode.mvc.Controller;
	import com.arcticode.mvc.Model;
	import com.arcticode.mvc.View;
	
	import flash.display.Sprite;
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class Main extends Sprite
	{
		public function Main()
		{
			var model:Model = new Model();
			var controller:Controller = new Controller(model);
			var view:View = new View(model, controller);
			addChild(view);
		}
	}
}
