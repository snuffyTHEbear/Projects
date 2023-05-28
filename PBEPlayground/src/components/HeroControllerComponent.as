package components
{
	import com.pblabs.engine.components.TickedComponent;
	import com.pblabs.engine.core.InputKey;
	import com.pblabs.engine.core.InputManager;
	import com.pblabs.engine.entity.PropertyReference;
	
	import flash.geom.Point;
	
	public class HeroControllerComponent extends TickedComponent
	{
		public var positionReference:PropertyReference;
		
		public override function onTick(tickRate:Number):void
		{
			var position:Point = owner.getProperty(positionReference);
			
			if(InputManager.isKeyDown(InputKey.RIGHT))
			{
				position.x += 15;
			}
			else if(InputManager.isKeyDown(InputKey.LEFT))
			{
				position.x -= 15;
			}
			if(InputManager.isKeyDown(InputKey.UP))
			{
				position.y -= 15;
			}
			else if(InputManager.isKeyDown(InputKey.DOWN))
			{
				position.y += 15;
			}
			
			if(position.x > 375)
			{
				position.x = -375;
			}
			else if(position.x < -375)
			{
				position.x = 375;
			}
			if(position.y > 275)
			{
				position.y = -275;
			}
			else if(position.y < -275)
			{
				position.y = 275;
			}
			
			owner.setProperty(positionReference, position);
		}
	}
}