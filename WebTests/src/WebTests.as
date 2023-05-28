package {
	import com.arcticcode.greenFlames.web.WebUtils;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	[SWF(width=640,height=480,backgroundColor=0xffffff)]
	public class WebTests extends Sprite
	{
		private var tf:TextField;
		
		public function WebTests()
		{
			tf = new TextField();
			tf.autoSize = "left";
			tf.defaultTextFormat = new TextFormat("Verdana", 12, 0, false);
			tf.x = 10; tf.y = 10;
			tf.width = 200;
			tf.height = 200;
			addChild(tf);
			
			var b:Button = new Button(null,"Button",null);
			addChild(b);
			
			tf.text = loaderInfo.url + " : " + WebUtils.getDomainName(loaderInfo.url);
			tf.appendText("\n"+WebUtils.checkDomain("arctic-code.com", WebUtils.getDomainName(loaderInfo.url)).toString());
			tf.appendText("\n"+WebUtils.checkDomains(["domain.com","arctic-code.com","domain2.com"],WebUtils.getDomainName(loaderInfo.url)).toString());
		}
	}
}
