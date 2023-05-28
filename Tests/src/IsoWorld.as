package
{
	import caurina.transitions.Tweener;
	
	import com.arcticcode.greenFlames.isometric.core.IsometricEngine;
	import com.arcticcode.greenFlames.isometric.core.objects.ComplexIsometricObject;
	import com.arcticcode.greenFlames.isometric.core.objects.IsometricSprite;
	import com.arcticcode.greenFlames.isometric.geom.IsoDimensions;
	import com.arcticcode.greenFlames.isometric.graphics.GraphicsOptions;
	import com.arcticcode.greenFlames.isometric.graphics.fill.FillOptions;
	import com.arcticcode.greenFlames.isometric.graphics.line.LineStyle;
	import com.arcticcode.greenFlames.isometric.utils.IsometricUtils;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.arcticcode.greenFlames.isometric.view.BaseIsometricView;
	
	public class IsoWorld extends BaseIsometricView
	{
		private var menu:ComplexIsometricObject;
		
		private var tweenIn:Object = {h:100, time:1.3, transition:"easeoutexpo", onUpdate:onProgress};
		
		private var tweenOut:Object = {h:25, time:0.7, transition:"easeoutexpo", onUpdate:onProgress};
		
		public function IsoWorld()
		{
			init();
			setup();
		}
		
		private function setup():void
		{
			engine = new IsometricEngine(null, centreX, centreY + 150, IsometricEngine.RIGHT, false, true);
			var go:GraphicsOptions = new GraphicsOptions(new LineStyle(), new FillOptions(0xfe5ca7));
			menu = IsometricUtils.createXZGrid(5, 1, new IsoDimensions(15, 25, 15), go, IsometricUtils.SPRITES);
			go.graphics = menu.graphics;
			
			for (var i:uint = 0; i < menu.objects.length; i++)
			{
				IsometricSprite(menu.objects[i]).graphicsOptions = go;
				IsometricSprite(menu.objects[i]).graphicsOptions.graphics = IsometricSprite(menu.objects[i]).graphics;
			}
			
			engine.drawObjectsComplexForward(menu.objects);
			engine.addToDisplayList(menu.objects, menu);
			addChild(menu);
		
			//engine.addEventListeners(menu.objects, MouseEvent.MOUSE_OVER, onOver);
			//DisplayUtils.batchButtonModes(menu.objects, true);
		}
		
		private function onOver(e:MouseEvent):void
		{
			Tweener.addTween(e.target, tweenIn);
			e.target.addEventListener(MouseEvent.MOUSE_OUT, onOut);
		}
		
		private function onOut(e:MouseEvent):void
		{
			Tweener.addTween(e.target, tweenOut);
		}
		
		private function onProgress():void
		{
			for (var i:uint = 0; i < menu.objects.length; i++)
			{
				engine.renderer.g = menu.objects[i].graphics;
				engine.drawObject(menu.objects[i], true);
			}
		}
	}
}