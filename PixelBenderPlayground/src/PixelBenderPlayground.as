package
{
	import flash.display.Shader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	
	public class PixelBenderPlayground extends Sprite
	{
		[Embed(source="filters/Checkerboard.pbj", mimeType="application/octet-stream")]
		private var shaderClass:Class;
		
		private var shader:Shader;
		private var xAngle:Number = 0;
		private var yAngle:Number = 0;
		private var xSpeed:Number = 0.09;
		private var ySpeed:Number = 0.07;
		private var angle:Number = Math.PI / 4;
		
		public function PixelBenderPlayground()
		{
			stage.scaleMode = "noScale";
			stage.align = "topLeft";
			init();
		}
		private function init():void
		{
			/*var angle:Number = Math.PI / 4;
			var cos:Number = Math.cos(angle);
			var sin:Number = Math.sin(angle);
			
			var shader:Shader = new Shader(new shaderClass());
			trace(Utils.getShaderData(shader.data));
			shader.data.xres.value = [20];
			shader.data.yres.value = [20];
			graphics.beginShaderFill(shader, new Matrix(cos, sin, -sin, cos));
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();*/
			
			shader = new Shader(new shaderClass());
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(e:Event):void
		{
			//var xres:Number = Math.sin(xAngle += xSpeed) * 50 + 55;
			//var yres:Number = Math.sin(yAngle += ySpeed) * 50 + 55;
			
			//shader.data.xres.value = [xres];
			//shader.data.yres.value = [yres];
			
			angle += 5;
			
			var cos:Number = Math.cos(angle);
			var sin:Number = Math.sin(angle);
			var m:Matrix = new Matrix(cos, sin, -sin, cos);
			
			graphics.clear();
			graphics.beginShaderFill(shader, m);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
		}
	}
}