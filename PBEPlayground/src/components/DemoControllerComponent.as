package components
{
	import com.pblabs.engine.components.TickedComponent;
	import com.pblabs.engine.entity.PropertyReference;
	
	import flash.geom.Point;
	
	public class DemoControllerComponent extends TickedComponent
	{
		public var positionReference:PropertyReference;
		
		private var _direction:int = 1;
		
		public override function onTick(tickRate:Number):void
		{
			var position:Point = owner.getProperty(positionReference);
			
			if(position.x < -375)
			{
				_direction = 1;	
				position.y += 20;
			}
			else if(position.x > 375)
			{
				_direction = -1;
				position.y += 20;
			}
			
			position.x += _direction * 5;
			owner.setProperty(positionReference, position);
		}
	}
}