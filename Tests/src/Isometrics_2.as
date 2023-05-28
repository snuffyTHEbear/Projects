package
{
	import com.arcticcode.greenFlames.components.MemFpsCount;
	import com.arcticcode.greenFlames.isometric.ComplexIsometricObject;
	import com.arcticcode.greenFlames.isometric.IsometricEngine;
	import com.arcticcode.greenFlames.isometric.IsometricObject;
	import com.bit101.components.PushButton;
	
	import flash.display.Sprite;
	import flash.events.Event;
	[SWF(width=600,height=400,backgroundColor=0xFFFFFF)]
	public class Isometrics_2 extends Sprite
	{
		private var engine:IsometricEngine;
		private var grid:ComplexIsometricObject;
		private var block:ComplexIsometricObject;
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5+190;
		//
		private var gridRowCount:uint = 30;
		//
		private var rightBtn:PushButton;
		private var leftBtn:PushButton;
		private var upBtn:PushButton;
		private var downBtn:PushButton;
		private var upRightBtn:PushButton;
		private var upLeftBtn:PushButton;
		private var downRightBtn:PushButton;
		private var downLeftBtn:PushButton;
		
		public function Isometrics_2()
		{
			init();
		}
		private function buildGUI():void
		{
			rightBtn = new PushButton(this,60,25,"Right",onMove);
			edit(rightBtn,50,16,"right");
			leftBtn = new PushButton(this,5,25,"Left",onMove);
			edit(leftBtn,50,16,"left");
			upBtn = new PushButton(this,32.5,5,"Up",onMove);
			edit(upBtn,50,16,"up");
			downBtn = new PushButton(this,32.5,45,"Down",onMove);
			edit(downBtn,50,16,"down");
			upRightBtn = new PushButton(this,85,5,"U/R",onMove);
			edit(upRightBtn,25,16,"ur");
			upLeftBtn = new PushButton(this,5,5,"U/L",onMove);
			edit(upLeftBtn,25,16,"ul");
			downRightBtn = new PushButton(this,85,45,"D/R",onMove);
			edit(downRightBtn,25,16,"dr");
			downLeftBtn = new PushButton(this,5,45,"D/L",onMove);
			edit(downLeftBtn,25,16,"dl");
			
			var _fm:MemFpsCount = new MemFpsCount();
			_fm.x = stage.stageWidth - 100;
			addChild(_fm);
		}
		private function edit(btn:PushButton,w:Number,h:Number,str:String):void
		{
			btn.setSize(w,h);
			btn.name = str;
		}
		private function onMove(e:Event):void
		{
			switch(e.target.name)
			{
				case "right":
				block.objects[0].x += 10;
				block.objects[0].z -= 10;
				break;
				
				case "left":
				block.objects[0].z += 10;
				block.objects[0].x -= 10;
				break;
				
				case "up":
				block.objects[0].x += 10;
				block.objects[0].z += 10;
				break;
				
				case "down":
				block.objects[0].x -= 10;
				block.objects[0].z -= 10;
				break;
				
				case "ul":
				block.objects[0].z+=10;
				break;
				
				case "ur":
				block.objects[0].x+=10;
				break;
				
				case "dl":
				block.objects[0].x-=10;
				break;
				
				case "dr":
				block.objects[0].z-=10;
				break;
			}
			render();
		}
		private function init():void
		{
			engine = new IsometricEngine(super.graphics,0,0,26.57,false,false);
			grid = new ComplexIsometricObject();
			block = new ComplexIsometricObject();
			block.addObject(new IsometricObject(0,0,0,10,25,10,false,0,true,0xCCCCCC));
			block.x = centreX;
			block.y = centreY;
			addChild(block);
						
			//block.x = centreX+50;
			//block.y = centreY-25;
			
			for(var i:uint=0;i<900;i++)
			{
				var xPos:Number = (Math.floor(i / gridRowCount) * 10);
				var yPos:Number = ((i % gridRowCount) * 10);
				var zPos:Number = (Math.floor(i/gridRowCount) * 10);
				grid.addObject(new IsometricObject(xPos,0,yPos,10,0,10,true,0,true,0xffffff));
			}
			
			engine.g = grid.graphics;
			engine.clear();
			for(i=grid.objects.length;i>0;i--)
			{
				engine.drawObject(grid.objects[i-1]);
			}
			
			addChild(grid);
			grid.x = centreX;
			grid.y = centreY;
			setChildIndex(grid,0);
			
			buildGUI();
			render();
		}
		private function render():void
		{
			engine.g = block.graphics;
			engine.clear();
			engine.drawObject(block.objects[0]);
		}
	}
}