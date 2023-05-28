package
{
	import flash.display.Shader;
	import flash.display.Sprite;
	import flash.filters.ShaderFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class ShaderFilters extends Sprite
	{
		[Embed(source="Filters/TwirlFlash.pbj", mimeType="application/octet-stream")]
		private var shaderClass:Class;
		
		public function ShaderFilters()
		{
			stage.align = "topLeft";
			stage.scaleMode = "noScale";
			
			var shader:Shader = new Shader(new shaderClass());
			shader.data.center.value = [200, 200];
			shader.data.twist.value = [-1];
			shader.data.radius.value = [200];
			
			 var tf:TextField = new TextField();
            tf.width = 400;
            tf.height = 400;
            tf.wordWrap = true;
            tf.multiline = true;
            tf.border = true;
            tf.defaultTextFormat = new TextFormat("Arial", 24);
            addChild(tf);
            for(var i:int = 0; i < 340; i++)
            {
                tf.appendText(String.fromCharCode(65 +
                              Math.random() * 25));
            }
            
            tf.filters = [new ShaderFilter(shader)];
		}
	}
}