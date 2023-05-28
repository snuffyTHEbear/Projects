package
{
	import flash.display.Bitmap;
	import flash.display.Shader;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class TwirlFlash extends Sprite
	{
		[Embed(source="Images/image.jpg")]
		private var imageClass:Class;
		
		[Embed(source="Filters/TwirlFlash.pbj", mimeType="application/octet-stream")]
		private var shaderClass:Class;
		
		private var angle:Number=0;
		
		private var shader:Shader;
		
		private var image:Bitmap;
		
		public function TwirlFlash()
		{
			stage.align = "topLeft";
			stage.scaleMode = "noScale";
			
			init();
		}
		private function init():void
		{
			shader = new Shader(new shaderClass());
			shader.data.center.value = [400, 300];
			shader.data.twist.value = [-6];
			shader.data.radius.value = [300];
			
			image = new imageClass() as Bitmap;
			shader.data.src.input = image.bitmapData;
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(e:Event):void
		{
			angle += .1;
			
			shader.data.twist.value = [Math.cos(angle)];
			
			graphics.clear();
			graphics.beginShaderFill(shader);
			graphics.drawRect(0,0,image.bitmapData.width,image.bitmapData.height);
			graphics.endFill();
		}
	}
}