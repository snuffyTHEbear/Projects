package
{
	import com.arcticcode.greenFlames.isometric.math.IsoMath;
	import com.bit101.components.HUISlider;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.GraphicsPathCommand;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class IsometricPlayground extends Sprite
	{
		//variables
		private var angle:Number = 0;
		private var radius:Number = 1;
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;
		private var data:Vector.<Number> = new Vector.<Number>();
		private var commands:Vector.<int> = new Vector.<int>();
		private var _colour:uint = Math.random() * 0xffffff;
		private var b:Bitmap;
		
		//controls
		private var radiusSlider:HUISlider;
		private var incAMaxSlider:HUISlider;
		private var incBMaxSlider:HUISlider;
		private var incAMinSlider:HUISlider;
		private var incBMinSlider:HUISlider;
		private var thicknessSlider:HUISlider;
		private var angleIncSlider:HUISlider;
		private var incAIncSlider:HUISlider;
		private var incBIncSlider:HUISlider;
		
		public function IsometricPlayground()
		{
			stage.scaleMode = "noScale";
			stage.align = "topLeft";
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function stageResize(e:Event):void
		{
			centreX = stage.stageWidth * 0.5;
			centreY = stage.stageHeight * 0.5;
			initControls();
			render(null);
		}
		private function initControls():void
		{
			while(this.numChildren > 0)
			{
				var child:DisplayObject = this.getChildAt(this.numChildren - 1) as DisplayObject;
				removeChild(child);
				child = null;
			}
			
			radiusSlider = new HUISlider(this, 10, 10, "Radius / Size", render);
			setSliderParams(radiusSlider, 0.01, 15, 1);
			
			thicknessSlider = new HUISlider(this, 10, 30, "Thickness", render);
			setSliderParams(thicknessSlider, 0, 15, 1);
			
			incAMaxSlider = new HUISlider(this, 10, 50, "Inc A Max", render);
			setSliderParams(incAMaxSlider, 0, 100, 10);
			
			incBMaxSlider = new HUISlider(this, 10, 70, "Inc B Max", render);
			setSliderParams(incBMaxSlider, 0, 10, 10);
			
			incAMinSlider = new HUISlider(this, 10, 90, "Inc A Min", render);
			setSliderParams(incAMinSlider, -100, 0, 0);
			
			incBMinSlider = new HUISlider(this, 10, 110, "Inc B Min", render);
			setSliderParams(incBMinSlider, -10, 0, 0);
			
			angleIncSlider = new HUISlider(this, 10, 130, "Angle Inc", render);
			setSliderParams(angleIncSlider, 0.01, 10, 0.05, 0.05);
		}
		private function setSliderParams(slider:HUISlider, min:Number, max:Number, val:Number, t:Number = 1):void
		{
			with(slider)
			{
				minimum = min;
				maximum = max;
				value = val;
				tick = t;
			}
		}
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			initControls();
			
			stage.addEventListener(Event.RESIZE, stageResize);
		}
		private function snapshot():void
		{
			
		}
		private function render(e:Event):void
		{
			radius = radiusSlider.value;
			
			angle = 0;
			
			//graphics.clear();
			
			data.splice(0, data.length);
			commands.splice(0, commands.length);
			trace(incAMaxSlider.value);//, incAMaxSlider.value);
			
			return;
			
			for(var i:int = incAMinSlider.value; i < incAMaxSlider.value; i++)
			{
				for(var j:int = incBMinSlider.value; j < incBMaxSlider.value; j++)
				{
					//graphics.lineStyle(thicknessSlider.value, j * 1000000);
					if(i == incAMinSlider.value && j == incBMinSlider.value)
					{
						commands.push(GraphicsPathCommand.MOVE_TO);
						data.push(IsoMath.xFlash(i * radius, 0, j * radius, angle, centreX), IsoMath.yFlash(i * radius, 0, j * radius, angle, centreY));
						//graphics.moveTo(IsoMath.xFlash(i * radius, 0, j * radius, angle, centreX), IsoMath.yFlash(i * radius, 0, j * radius, angle, centreY));
					}
					else
					{
						commands.push(GraphicsPathCommand.LINE_TO);
						data.push(IsoMath.xFlash(i * radius, 0, j * radius, angle, centreX), IsoMath.yFlash(i * radius, 0, j * radius, angle, centreY));
						//graphics.lineTo(IsoMath.xFlash(i * radius, 0, j * radius, angle, centreX), IsoMath.yFlash(i * radius, 0, j * radius, angle, centreY));
					}
					angle += angleIncSlider.value;
				}
			}
			graphics.clear();
			graphics.lineStyle(thicknessSlider.value, _colour);
			graphics.drawPath(commands, data);
		}
	}
}