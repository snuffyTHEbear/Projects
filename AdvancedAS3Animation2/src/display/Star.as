package display
{
	import flash.display.Sprite;
	
	public class Star extends Sprite
	{
		public function Star(radius:Number, color:uint = 0xFFFF00)
		{
			graphics.lineStyle(0);
			graphics.moveTo(radius, 0);
			
			graphics.beginFill(color);
			var i:uint, len:uint = 11;
			
			for(i=1;i<len;i++)
			{
				var r2:Number = radius;
				if(i % 2 > 0)
				{
					r2 = radius / 2;
				}
				
				var angle:Number = Math.PI * 2 / 10 * i;
				graphics.lineTo(Math.cos(angle) * r2, Math.sin(angle) * r2);
			}
		}
	}
}