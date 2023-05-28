package
{
	import com.arcticcode.greenFlames.isometric.core.IsometricEngine;
	import com.arcticcode.greenFlames.isometric.core.objects.ComplexIsometricObject;
	import com.arcticcode.greenFlames.isometric.core.objects.IsometricObject;
	import com.arcticcode.greenFlames.isometric.core.objects.IsometricShape;
	import com.arcticcode.greenFlames.isometric.geom.IsoDimensions;
	import com.arcticcode.greenFlames.isometric.geom.IsoPoint3D;
	import com.arcticcode.greenFlames.isometric.graphics.GraphicsOptions;
	import com.arcticcode.greenFlames.isometric.graphics.fill.FillOptions;
	import com.arcticcode.greenFlames.isometric.graphics.line.LineStyle;
	import com.arcticcode.greenFlames.isometric.utils.IsometricUtils;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	[SWF(width=600, height = 400, backgroundColor = 0xffffff)]
	public class IsometricBoundsTests extends Sprite
	{
		private var engine:IsometricEngine;
		
		private var centreX:Number = stage.stageWidth * 0.5;
		
		private var centreY:Number = stage.stageHeight * 0.5;
		
		private var grid:ComplexIsometricObject;
		
		private var block:IsometricShape;
		
		private var bounds:Object;
		
		private var vx:Number = 0;
		
		private var vz:Number = 0;
		
		private var friction:Number = 0.97;
		
		private var dir:String = "";
		
		public function IsometricBoundsTests():void
		{
			//trace(Math.round(54/10)*10,Math.round(56/10)*10);
			init();
		}
		
		private function init():void
		{
			engine = new IsometricEngine(null, centreX, centreY + 150, IsometricEngine.RIGHT, false, true);
			var go:GraphicsOptions = new GraphicsOptions(new LineStyle(0, 0), new FillOptions(0xffffff, 1));
			grid = IsometricUtils.createXZGrid(15, 15, new IsoDimensions(10, 0, 10), go, IsometricUtils.OBJECTS);
			engine.drawObjectsSimpleForward(grid.objects);
			addChild(grid);
			block = new IsometricShape(new IsoPoint3D(0, 0, 0), new IsoDimensions(10, 15, 10), new GraphicsOptions(new LineStyle(), new FillOptions(Math.random() * 0xFFFFFF)));
			engine.renderer.g = block.graphics;
			//var index:uint = Math.floor(Math.random()*grid.objects.length);
			//block.x = grid.objects[index].x;
			//block.z = grid.objects[index].z;
			engine.drawObject(block);
			addChild(block);
			engine.drawObject(block);
			bounds = IsometricUtils.calculateGridBounds(15, 0, 15, 10, 0, 10);
			//bounds.maxX -= block.w;
			//bounds.maxZ -= block.d;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function onKey(e:KeyboardEvent):void
		{
			if (dir != "")
			{
				vx = 0;
				vz = 0;
			}
			switch (e.keyCode)
			{
				case Keyboard.UP:
					dir = e.keyCode.toString();
					vx = 5;
					break;
				
				case Keyboard.DOWN:
					dir = e.keyCode.toString();
					vx = -5;
					break;
				
				case Keyboard.LEFT:
					dir = e.keyCode.toString();
					vz = 5;
					break;
				
				case Keyboard.RIGHT:
					dir = e.keyCode.toString();
					vz = -5;
					break;
			}
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			if (e.keyCode.toString() != dir)
			{
				
			}
			else
			{
				dir = "";
				block.x = Math.round(block.x / 10) * 10;
				block.z = Math.round(block.z / 10) * 10;
				vx = 0;
				vz = 0;
			}
		}
		
		private function loop(e:Event):void
		{
			checkBounds();
			block.x += vx;
			block.z += vz;
			engine.renderer.clear();
			engine.drawObject(block);
		}
		
		private function checkBounds():void
		{
			trace(block.x, block.z, bounds.maxX, bounds.maxZ);
			if (block.isometricObject.x >= bounds.maxX - block.isometricObject.width)
			{
				vx = 0;
				block.x = bounds.maxX - block.isometricObject.width;
			}
			else if (block.x <= bounds.minX)
			{
				vx = 0;
				block.x = bounds.minX;
			}
			if (block.z >= bounds.maxZ)
			{
				vz = 0;
				block.z = bounds.maxZ;
			}
			else if (block.z <= bounds.minZ)
			{
				vz = 0;
				block.z = bounds.minZ;
			}
		}
	}
}