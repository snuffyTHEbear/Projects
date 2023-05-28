package
{
	import com.arcticcode.greenFlames.components.MemFpsCount;
	import com.arcticcode.greenFlames.isometric.core.IsometricEngine;
	import com.arcticcode.greenFlames.isometric.core.objects.ComplexIsometricObject;
	import com.arcticcode.greenFlames.isometric.core.objects.CoordinateSystem;
	import com.arcticcode.greenFlames.isometric.core.objects.IsometricSprite;
	import com.arcticcode.greenFlames.isometric.geom.IsoDimensions;
	import com.arcticcode.greenFlames.isometric.geom.IsoPoint3D;
	import com.arcticcode.greenFlames.isometric.graphics.GraphicsOptions;
	import com.arcticcode.greenFlames.isometric.graphics.fill.FillOptions;
	import com.arcticcode.greenFlames.isometric.graphics.line.LineStyle;
	import com.arcticcode.greenFlames.isometric.view.BaseIsometricView;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	
	import gs.TweenLite;
	import gs.easing.Expo;
	
	[SWF(width=640, height = 480, backgroundColor = 0xFFFFFF)]
	public class Main extends BaseIsometricView
	{
		private var grid:ComplexIsometricObject;
		
		private var _fm:MemFpsCount = new MemFpsCount(MemFpsCount.MBUNITS, false);
		
		private var val:Number = 0;
		
		private var block:IsometricSprite;
		
		public function Main()
		{
			super.init();
		}
		
		override protected function init():void
		{
			var cs:CoordinateSystem = new CoordinateSystem();
			cs.x = centreX;
			cs.y = centreY;
			//	addChild(cs);
			
			//_fm.textFormat = new TextFormat("Verdana", 12, 0xffffff);
			addChild(_fm);
			
			engine = new IsometricEngine(null, centreX, centreY, IsometricEngine.RIGHT, true, true, false);
			var ls:LineStyle = new LineStyle(1, 0xffffff, 1, false, "normal", "round", "round");
			var fo:FillOptions = new FillOptions(0xcc0000, 1);
			var go:GraphicsOptions = new GraphicsOptions(ls, fo);
			
			block = new IsometricSprite(new IsoPoint3D(0, 0, 0), new IsoDimensions(20, 10, 20), go);
			block.graphicsOptions.graphics = block.graphics;
			engine.addToDisplayList(block, this, true);
			block.buttonMode = true;
			engine.drawObject(block.isometricObject, true, true, false);
			
			/* this.graphics.beginFill(0xcc0000,1);
			   this.graphics.drawCircle(IsoMath.xFlash(0,0,0,engine.angle,centreX),IsoMath.yFlash(0,0,0,engine.angle,centreY),30);
			 this.graphics.endFill(); */
			
			block.addEventListener(MouseEvent.MOUSE_OVER, blockOver);
			block.addEventListener(MouseEvent.MOUSE_OUT, blockOut);
		}
		
		private function blockOver(e:MouseEvent):void
		{
			TweenLite.to(block.isometricObject, 2, {height:60, ease:Expo.easeOut, onUpdate:update});
		}
		
		private function blockOut(e:MouseEvent):void
		{
			TweenLite.to(block.isometricObject, 1.3, {height:10, ease:Expo.easeOut, onUpdate:update});
		}
		
		private function update():void
		{
			engine.drawObject(block.isometricObject, true, true, false);
		}
		
		private function getRanNum():Number
		{
			return (Math.random() * 30);
		}
		
		override protected function onEnterFrame(e:Event):void
		{
			_fm.calculate();
			val += 0.1345;
			block.height += Math.sin(val);
			engine.renderer.drawObject(block, true, true, false);
		}
	}
}
