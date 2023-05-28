package
{
	import de.nulldesign.nd3d.material.BitmapMaterial;
	import de.nulldesign.nd3d.objects.Cube;
	import de.nulldesign.nd3d.view.AbstractView;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	
	[SWF(width=600,height=400,backgroundColor=0)]
	public class Textures extends AbstractView
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;	
		private var cube:Cube;
		
		[Embed(source="/assets/flash.png")]
		private var _i:Class;
		
		public function Textures()
		{
			super(600, 400);
			init();
		}
		private function init():void
		{
			var matList:Array = new Array();
			for(var inc:uint=0;inc<6;inc++)
			{
				var mat:BitmapMaterial = new BitmapMaterial(getBMD(),true,true,true,true);
				matList.push(mat);
			}
			
			renderer.additiveMode = true;
			renderer.dynamicLighting = true;
			
			cube = new Cube(matList,100,2);
			
			renderList.push(cube);
		}
		private function getBMD():BitmapData
		{
			var bmd:BitmapData = new BitmapData(100,100,true,0xff000000);
			for(var i:uint=0;i<100;i++)
			{
				bmd.setPixel32(Math.random()*100,Math.random()*100,Math.random()*0xff000000);
			}
			return bmd;
		}
		override protected function loop(e:Event):void
		{
			renderer.render(renderList,cam);
			cube.angleX -= (centreY - mouseY) * .0005;
			cube.angleY -= (centreX - mouseX) * .0005;
		}
	}
}