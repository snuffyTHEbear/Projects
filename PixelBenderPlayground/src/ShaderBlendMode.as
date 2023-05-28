package 
{
	import flash.display.Bitmap;
	import flash.display.Shader;
	import flash.display.Sprite;
	
	public class ShaderBlendMode extends Sprite
	{
		[Embed(source="Images/image.jpg")]
		private var imageOne:Class;
		
		[Embed(source="Images/image2.jpg")]
		private var imageTwo:Class;
		
		[Embed(source="Filters/ChannelBlend.pbj", mimeType="application/octet-stream")]
		private var shaderClass:Class;
		
		public function ShaderBlendMode()
		{
			stage.align = "topLeft";
			stage.scaleMode = "noScale";
			
			var back:Bitmap = new imageOne();
			addChild(back);
			
			var fore:Bitmap = new imageTwo();
			addChild(fore);
			
			var shader:Shader = new Shader(new shaderClass());
			shader.data.amt.value = [1.0, 0.9, 0.0];
			fore.blendShader = shader;
		}
	}
}