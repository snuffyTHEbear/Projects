package
{
	import com.arcticcode.greenFlames.graphics.Tooltip;
	import com.arcticcode.greenFlames.isometric.ComplexIsometricObject;
	import com.arcticcode.greenFlames.isometric.IsometricEngine;
	import com.arcticcode.greenFlames.isometric.IsometricUtils;
	import com.gskinner.motion.GTween;
	
	import fl.motion.easing.Exponential;
	
	import flash.display.Sprite;
	import flash.events.Event;
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class TweenTests extends Sprite
	{
		private var engine:IsometricEngine;
		private var grid:ComplexIsometricObject;
		private const centreX:Number = stage.stageWidth*0.5;
		private const centreY:Number = stage.stageHeight*0.5;
		private var index:int=0;
		private var tt:Tooltip;
		private var tween:GTween = new GTween(null,2,{h:0},Exponential.easeInOut);
		
		public function TweenTests()
		{
			init();
		}
		private function init():void
		{
			grid = new ComplexIsometricObject();
			engine = new IsometricEngine(null,centreX,centreY+200,IsometricEngine.RIGHT,true,true);
			addChild(grid);
			
			tt = new Tooltip();
			addChild(tt);
			
			IsometricUtils.createXZGrid(grid,25,25,5,5,5,false,0,true,Math.random()*0xffffff,"shapes");
			//engine.drawObjectsSimple(grid.objects,grid.graphics,true);
			
			trace(grid.objects.length);
			
			for(var i:uint=0;i<grid.objects.length;i++)
			{
				grid.objects[i].fillColour = Math.random()*0xffffff;
			}
			
			engine.drawObjectsComplex(grid.objects);
			engine.addToDisplayList(grid.objects,grid);
						
			tween.addEventListener(Event.CHANGE, onProgress);
			tween.addEventListener(Event.COMPLETE, tweenComplete);
			
			tweenBlock();
		}
		private function onProgress(e:Event):void
		{
			//engine.drawObjectsSimple(grid.objects,grid.graphics,true);
			//engine.drawObjectsComplex(grid.objects);
			engine.g = tween.target.graphics;
			engine.drawObject(tween.target);
			tt.text = "Index: " + grid.objects.indexOf(tween.target).toString() + "\nH: " + Math.floor(tween.target.h).toString();
			tt.x = engine.xFlash(tween.target.x,tween.target.y+tween.target.h,tween.target.z);
			tt.y = engine.yFlash(tween.target.x,tween.target.y+tween.target.h,tween.target.z);
		}
		private function tweenComplete(e:Event):void
		{
			tweenBlock();
		}
		private function tweenBlock():void
		{
			index = Math.floor(Math.random()*grid.objects.length);
			var block:Object = grid.objects[index];
			tween.target = block;
			tween.proxy.h = Math.random()*100;
		}
	}
}