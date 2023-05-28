package
{
	import com.arcticcode.greenFlames.isometric.ComplexIsometricObject;
	import com.arcticcode.greenFlames.isometric.IsometricEngine;
	import com.arcticcode.greenFlames.isometric.IsometricObject;
	import com.arcticcode.greenFlames.isometric.IsometricUtils;
	
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class IsoClock extends Sprite
	{
		private var timer:Timer;
		private var clock:ComplexIsometricObject;
		private var grid:ComplexIsometricObject;
		private var engine:IsometricEngine;
		private var centreX:Number = stage.stageWidth*0.5;
		private var centreY:Number = stage.stageHeight*0.5;
		//
		private var hours:Number=0;
		private var mins:Number=0;
		private var secs:Number=0;
		private var d:Date = new Date();
		
		public function IsoClock()
		{
			init();
		}
		private function init():void
		{
			clock = new ComplexIsometricObject();
			grid = new ComplexIsometricObject();
			IsometricUtils.createXZGrid(grid,60,3,10,0,10,true,0xcccccc,false,0,"objects");
			engine = new IsometricEngine(clock.graphics,45,centreY+150,IsometricEngine.RIGHT,false,true);
			clock.addObject(new IsometricObject(0,0,0,10,10,10,false,0,true,Math.random()*0xffffff));
			clock.addObject(new IsometricObject(0,0,10,10,10,10,false,0,true,Math.random()*0xffffff));
			clock.addObject(new IsometricObject(0,0,20,60,10,10,false,0,true,Math.random()*0xffffff));
			engine.drawObjectsSimple(grid.objects,grid.graphics,true);
			addChild(grid);
			engine.drawObjectsSimple(clock.objects,clock.graphics,true);
			addChild(clock);
			
			timer = new Timer(25);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
		}
		private function onTimer(e:TimerEvent):void
		{
			trace(hours,mins,secs);
			d = new Date();
			hours = d.getHours()*10;
			mins = d.getMinutes()*10;
			secs = d.getSeconds()*10;
			
			hours >= 130 ? hours-=120 : null;
			
			clock.objects[2].x = hours+50;
			clock.objects[1].x = mins;
			clock.objects[0].x = secs;
			
			engine.drawObjectsSimple(clock.objects,clock.graphics,true);
			
			e.updateAfterEvent();
		}
	}
}