package{
	import flash.display.Sprite;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	
	public class Random extends Sprite{
		private var numDots:uint = 300;
		private var maxRadius:Number = 25;
		private var iterations:Number = 6;
		public function Random(){
			init();
		}
		private function init():void{
			for(var i:uint = 0;i<numDots;i++)
			{
				var dot:CreateCircle = new CreateCircle(1,0);
				//Square//var radius:Number = Math.random()*maxRadius;
				//Circular//var radius:Number = Math.sqrt(Math.random())*maxRadius;
				
				//Square
				//dot.x = stage.stageWidth / 2 + Math.random() * 100 - 50;
				//dot.y = stage.stageHeight / 2 + Math.random() * 100 - 50;
				
				//Circular
				//var angle:Number = Math.random()*(Math.PI * 2);
				//dot.x = stage.stageWidth / 2 + Math.cos(angle) * radius;
				//dot.y = stage.stageHeight / 2 + Math.sin(angle) * radius;
				
				//Rectangular / Biased
				//var x1:Number = Math.random() * stage.stageWidth;
				//var x2:Number = Math.random() * stage.stageWidth;
				//dot.x = (x1 + x2) / 2;
				//dot.y = stage.stageHeight / 2 + Math.random() * 50 - 25;
				
				var xPos:Number = 0;
				for(var j:uint = 0; j<iterations;j++)
				{
					xPos += Math.random() * stage.stageWidth;
				}
				dot.x = xPos / iterations;
				
				var yPos:Number = 0;
				for(j=0;j<iterations;j++)
				{
					yPos += Math.random() * stage.stageHeight;
				}
				dot.y = yPos / iterations;
								
				addChild(dot);
			}
		}
	}
}