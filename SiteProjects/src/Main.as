package {
	import com.arcticcode.greenFlames.isometric.core.IsometricEngine;
	import com.arcticcode.greenFlames.isometric.core.objects.ComplexIsometricObject;
	import com.arcticcode.greenFlames.isometric.core.objects.IsometricObject;
	import com.arcticcode.greenFlames.isometric.geom.IsoDimensions;
	import com.arcticcode.greenFlames.isometric.graphics.GraphicsOptions;
	import com.arcticcode.greenFlames.isometric.graphics.fill.FillOptions;
	import com.arcticcode.greenFlames.isometric.graphics.line.LineStyle;
	import com.arcticcode.greenFlames.isometric.utils.IsometricUtils;
	import com.arcticcode.greenFlames.isometric.view.BaseIsometricView;
	
	import flash.events.Event;
	
	[SWF(width=640,height=480,backgroundColor=0xffffff)]
	public class Main extends BaseIsometricView
	{
		private var fo:FillOptions;
		private var ls:LineStyle;
		private var go:GraphicsOptions;
		private var grid:ComplexIsometricObject;
		private var index:int = 0;
		private var go2:GraphicsOptions;
		private var block:IsometricObject;
			
		public function Main()
		{
			stage.scaleMode = "noScale";
			super.init();
		}
		override protected function init():void
		{
			fo = new FillOptions(0xcccccc,1);
			ls = new LineStyle(0,0,1,false,"normal","round","round");
			go = new GraphicsOptions(null,fo,this.graphics);
			go2 = new GraphicsOptions(null,new FillOptions(0,1),this.graphics);
			
			engine = new IsometricEngine(go.graphics, centreX,centreY,IsometricEngine.RIGHT, true, true);
			grid = IsometricUtils.createXZGrid(2,
										2,
										new IsoDimensions(100,13,100),
										go,
										"objects");
			addChild(grid);
			
			for(var i:int=0;i<grid.objects.length/2;i++)
			{
				
				grid.objects[i].graphicsOptions = go2;
			}
			
			//grid.objects[10].graphicsOptions = new GraphicsOptions(null,new FillOptions(0xcc0000,1),this.graphics);
			
			//var indexes:Array = new Array(0,1,2,3,4,5,6,7,8,9,21,22,23,24,25,26,27,28,42,43,44,45,46,47,63,64,65,66,84,85);
			/* for(var i:int=0;i<indexes.length;i++)
			{
				grid.objects[indexes[i]].graphicsOptions = go2;
				//grid.objects[indexes[i]].height = i * 3;
			} */
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		override protected function onEnterFrame(e:Event):void
		{
			engine.renderer.clear();
			
			engine.drawObjectsSimpleReverse(grid.objects,true);
		}
	}
}
