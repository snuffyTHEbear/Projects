package
{
	import com.arcticcode.greenFlames.components.MemFpsCount;
	import com.arcticcode.greenFlames.isometric.core.IsometricEngine;
	import com.arcticcode.greenFlames.isometric.core.objects.ComplexIsometricObject;
	import com.arcticcode.greenFlames.isometric.core.objects.IsometricObject;
	import com.arcticcode.greenFlames.isometric.geom.IsoDimensions;
	import com.arcticcode.greenFlames.isometric.geom.IsoPoint3D;
	import com.arcticcode.greenFlames.isometric.graphics.GraphicsOptions;
	import com.arcticcode.greenFlames.isometric.graphics.fill.FillOptions;
	import com.arcticcode.greenFlames.isometric.graphics.line.LineStyle;
	import com.arcticcode.greenFlames.ui.BasicContextMenu;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.ContextMenu;
	
	[SWF(width=600, height = 400, backgroundColor = 0xffffff)]
	public class SineIsometrics extends Sprite
	{
		private var yVal:Number = 0;
		
		private var angleY:Number = 0;
		
		private var yRange:Number = 50;
		
		private var ySpeed:Number = .135;
		
		private var centreX:Number = stage.stageWidth * 0.5;
		
		private var centreY:Number = stage.stageHeight * 0.5;
		
		private var float:Boolean = false;
		
		//
		private var _fm:MemFpsCount;
		
		private var engine:IsometricEngine;
		
		private var cont:ComplexIsometricObject;
		
		public function SineIsometrics()
		{
			init();
		}
		
		private function init():void
		{
			engine = new IsometricEngine(null, centreX, centreY + 50, IsometricEngine.LEFT, false);
			cont = new ComplexIsometricObject();
			engine.renderer.g = cont.graphics;
			addChild(cont);
			
			_fm = new MemFpsCount();
			_fm.autoUpdate = false;
			addChild(_fm);
			
			var cm:ContextMenu = BasicContextMenu.buildMenu(true, "Arctic-Code", null);
			this.contextMenu = cm;
			
			for (var i:uint = 0; i < 10; i++)
			{
				for (var j:uint = 0; j < 10; j++)
				{
					var pos:IsoPoint3D = new IsoPoint3D(i * 15, 0, j * 15);
					var dim:IsoDimensions = new IsoDimensions(10, 0, 10);
					var ls:LineStyle = new LineStyle();
					var fo:FillOptions = new FillOptions(Math.random() * 0xFFFFFF, 1)
					var go:GraphicsOptions = new GraphicsOptions(ls, fo, engine.renderer.graphics);
					cont.addObject(new IsometricObject(pos, dim, go));
				}
			}
			
			stage.addEventListener(MouseEvent.CLICK, onClick);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onClick(e:MouseEvent):void
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			for (var i:uint = 0; i < cont.objects.length; i++)
			{
				cont.objects[i].y = 0;
				cont.objects[i].h = 0;
			}
			
			float = !float;
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			yVal = (Math.sin(angleY) * yRange) + yRange;
			engine.renderer.clear();
			var i:uint = 0;
			if (!float)
			{
				for (i = cont.objects.length; i > 2; i--)
				{
					cont.objects[i - 1].h = cont.objects[i - 2].h;
					engine.drawObject(cont.objects[i - 1]);
				}
				
				cont.objects[1].h = cont.objects[0].h;
				cont.objects[0].h = yVal;
				engine.drawObject(cont.objects[1]);
				engine.drawObject(cont.objects[0]);
			}
			else
			{
				for (i = cont.objects.length; i > 2; i--)
				{
					cont.objects[i - 1].y = cont.objects[i - 2].y;
					engine.drawObject(cont.objects[i - 1]);
				}
				
				cont.objects[1].y = cont.objects[0].y;
				cont.objects[0].y = yVal;
				engine.drawObject(cont.objects[1]);
				engine.drawObject(cont.objects[0]);
			}
			angleY += ySpeed;
			_fm.calculate();
		}
	}
}