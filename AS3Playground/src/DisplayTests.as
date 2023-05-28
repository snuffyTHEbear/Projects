package
{
	import com.arcticcode.greenFlames.math.Corona;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	[SWF(width=640, height = 480)]
	public class DisplayTests extends Sprite
	{
		/*Stage properties (width, height, centre coordinates)*/
		private var centreX:Number = stage.stageWidth * 0.5;
		
		private var centreY:Number = stage.stageHeight * 0.5;
		
		private var sWidth:Number = stage.stageWidth;
		
		private var sHeight:Number = stage.stageHeight;
		
		/*Corona properties and values*/
		private var angle:Number = 0;
		
		private var radius:Number = 70;
		
		private var inc:Number = 0;
		
		private var total:int = 50;
		
		private var angleTotal:Number = 0;
		
		private var values:Vector.<Number> = new Vector.<Number>();
		
		private var angle2:Number = 0;
		
		public function DisplayTests()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.frameRate = 8;
			
			init();
		}
		
		private function init():void
		{
			for (inc = 0; inc < total; inc++)
			{
				angle2 += .001;
				values.push(Math.sin(angle2));
			}
			
			angle2 = 0;
			
			addEventListener(Event.ENTER_FRAME, enterFrame_Handler);
		}
		
		private function enterFrame_Handler(e:Event):void
		{
			total += Math.random() * 100 - 50;
			total <= 2 ? total = 2 : {};
			graphics.clear();
			graphics.lineStyle(2, 0);
			for (inc = 0; inc < total; inc++)
			{
				angle2 += Math.random() / 2;
				values[inc] = Math.cos(angle2); //Math.cos(values[inc]);
				var val:Number = values[inc]; //Math.random();
				angle = inc * 2 * Math.PI / total;
				if (inc == 0)
				{
					graphics.moveTo(Corona.calculateX(centreX, angle, radius, val, sWidth, 1.0),
									Corona.calculateY(centreY, angle, radius, val, sHeight, 1.0));
				}
				else
				{
					graphics.lineTo(Corona.calculateX(centreX, angle, radius, val, sWidth, 1.0),
									Corona.calculateY(centreY, angle, radius, val, sHeight, 1.0));
				}
			}
			
			graphics.lineTo(Corona.calculateX(centreX, angle, radius, values[0], sWidth, 1.0),
							Corona.calculateY(centreY, angle, radius, values[0], sHeight, 1.0));
		
			//removeEventListener(e.type, enterFrame_Handler);
		}
	}
}