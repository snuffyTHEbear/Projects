package
{
	import com.arcticcode.greenFlames.components.MemFpsCount;
	import com.arcticcode.greenFlames.isometric.ComplexIsometricObject;
	import com.arcticcode.greenFlames.isometric.IsometricEngine;
	import com.arcticcode.greenFlames.isometric.IsometricObject;
	import com.arcticcode.greenFlames.ui.BasicContextMenu;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.ContextMenu;
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class SineIsometrics extends Sprite
	{
		private var yVal:Number = 0;
		private var angleY:Number = 0;
		private var yRange:Number = 50;
		private var ySpeed:Number = .135;
		private var centreX:Number = stage.stageWidth*0.5;
		private var centreY:Number = stage.stageHeight*0.5;
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
			engine = new IsometricEngine(null,centreX,centreY+50,IsometricEngine.LEFT,false);
			cont = new ComplexIsometricObject();
			engine.g = cont.graphics;
			addChild(cont);
			
			_fm = new MemFpsCount();
			_fm.autoUpdate = false;
			addChild(_fm);
				
			var cm:ContextMenu = BasicContextMenu.buildMenu(true,"Arctic-Code",null);
			this.contextMenu = cm;
			
			for(var i:uint=0;i<10;i++)
			{
				for(var j:uint=0;j<10;j++)
				{
					cont.addBox(new IsometricObject(i*15,0,j*15,10,0,10,false,0,true,Math.random()*0xffffff));
				}
			}
			
			stage.addEventListener(MouseEvent.CLICK,onClick);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onClick(e:MouseEvent):void
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			for(var i:uint=0;i<cont.boxes.length;i++)
			{
				cont.boxes[i].y = 0;
				cont.boxes[i].h = 0;
			}
			
			float =! float;
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(e:Event):void
		{
			yVal = (Math.sin(angleY) * yRange)+yRange;
			engine.clear();
			var i:uint=0;
			if(!float)
			{
				for(i=cont.boxes.length;i>2;i--)
				{
					cont.boxes[i-1].h = cont.boxes[i-2].h;
					engine.drawBox(cont.boxes[i-1]);
				}
				
				cont.boxes[1].h = cont.boxes[0].h;
				cont.boxes[0].h = yVal;
				engine.drawBox(cont.boxes[1]);
				engine.drawBox(cont.boxes[0]);
			}
			else
			{
				for(i=cont.boxes.length;i>2;i--)
				{
					cont.boxes[i-1].y = cont.boxes[i-2].y;
					engine.drawBox(cont.boxes[i-1]);
				}
				
				cont.boxes[1].y = cont.boxes[0].y;
				cont.boxes[0].y = yVal;
				engine.drawBox(cont.boxes[1]);
				engine.drawBox(cont.boxes[0]);
			}
			angleY += ySpeed;
			_fm.calculate();
		}
	}
}