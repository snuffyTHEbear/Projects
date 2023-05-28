package
{
	import flash.display.BitmapData;
	import flash.display.Shader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.ShaderFilter;
	import flash.media.Camera;
	import flash.media.Video;
	
	public class WebcamTwirl extends Sprite
	{
		[Embed(source="Filters/TwirlFlash.pbj", mimeType="application/octet-stream")]
		private var shaderClass:Class;
		
		private var angle:Number=0;
		
		private var shader:Shader;
		
		private var bmd:BitmapData;
		private var buffer:BitmapData;
		
		private var video:Video;
		
		public function WebcamTwirl()
		{
			shader = new Shader(new shaderClass());
			shader.data.center.value = [160, 120];
			shader.data.twist.value = [-6];
			shader.data.radius.value = [300];
			
			video = new Video();
			video.attachCamera(Camera.getCamera());
			//addChild(video);
			
			bmd = new BitmapData(video.width, video.height);
			buffer = new BitmapData(bmd.width,bmd.height);
						
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(e:Event):void
		{
			buffer.draw(video);
			bmd.draw(buffer);
			shader.data.src.input = bmd;
			angle += .005;
			shader.data.twist.value = [Math.tan(angle)];
			video.filters = [new ShaderFilter(shader)];
			graphics.clear();
			graphics.beginShaderFill(shader);
			graphics.drawRect(0,0,video.width,video.height);
			graphics.endFill();
		}
	}
}