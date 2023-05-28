package {
	import caurina.transitions.Tweener;
	
	import com.arcticcode.greenFlames.Math.MathUtils;
	import com.arcticcode.greenFlames.components.MemFpsCount;
	
	import de.nulldesign.nd3d.material.BitmapMaterial;
	import de.nulldesign.nd3d.material.LineMaterial;
	import de.nulldesign.nd3d.material.Material;
	import de.nulldesign.nd3d.material.PixelMaterial;
	import de.nulldesign.nd3d.material.WireMaterial;
	import de.nulldesign.nd3d.objects.Cube;
	import de.nulldesign.nd3d.objects.Sphere;
	import de.nulldesign.nd3d.view.AbstractView;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	[SWF(width=600,height=400,backgroundColor="#000000")]
	public class Main extends AbstractView
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;	
		private var cube:Cube;
		private var sphere:Sphere;
		private var _fm:MemFpsCount = new MemFpsCount(MemFpsCount.MBUNITS,MemFpsCount.MB, false);
		
		public function Main()
		{
			super(600,400);
			init();
		}
		private function init():void
		{
			addChild(_fm);
			_fm.textFormat = new TextFormat("Arial", 10,0xffffff);
			
			var matList:Array = new Array();
			//var bmd:BitmapData = new BitmapData(100,100,true);
			
			for(var i:int=0;i<6;i++)
			{
				var mat:Material = new Material(Math.random()*0xff0000,0.75,false,true,true);
				//var pmat:PixelMaterial = new PixelMaterial(0xffffff,1,5);
				//var lmat:LineMaterial = new LineMaterial(0xffffff,1,2,false,false);
				//bmd.perlinNoise(100,100,2,Math.random()*1000,false,true,7,false,null);
				//bmd.noise(Math.random()*1000,0,255,2 | 4, false);
				//var bmat:BitmapMaterial = new BitmapMaterial(bmd,false,true,true,true);
				var wmat:WireMaterial = new WireMaterial(0xffffff,5,1,true,0,0);
				
				matList.push(mat);
			} 
			
			//createDebugOutPut();
			//debugTxt.y = 15;
						
			//sphere = new Sphere(2,75,new WireMaterial(0,1,0.75,true,0xffffff,1));
						
			cube = new Cube(matList,100,4);
			
			renderList.push(cube);
			
			stage.addEventListener("click", stage_clickHandler);
		}
		private function getRandomRotation():Number
		{
			return MathUtils.degreesToRadians(Math.random()*360-180);
		}
		private function stage_clickHandler(e:MouseEvent):void
		{
			var tween:Object = {angleX:getRandomRotation(),angleY:getRandomRotation(),angleZ:getRandomRotation(),time:3.2,transition:"easeoutexpo"};
			Tweener.addTween(cube, tween);
		}
		override protected function loop(e:Event):void
		{
			//super.loop(e);
			renderer.render(renderList,cam);
			/*cube.angleX += (centreY - mouseY) * .0007;
			cube.angleY += (centreX - mouseX) * .0007;*/
			/* cam.angleX += (centreY - mouseY) * .0007;
			cam.angleY += (centreX - mouseX) * .0007; */
			
			_fm.calculate();
		}
	}
}
