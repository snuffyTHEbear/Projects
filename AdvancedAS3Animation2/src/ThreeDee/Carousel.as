package ThreeDee
{
	import com.arcticcode.greenFlames.ThreeDee.ThreeDeeUtils;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Carousel extends Sprite
	{
		private var holder:Sprite;
		private var items:Array;
		private var radius:Number = 200;
		private var numItems:int = 5;
		
		public function Carousel()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void
		{
			root.transform.perspectiveProjection.focalLength = 300;
			//root.transform.perspectiveProjection.fieldOfView = 110;
			
			holder = new Sprite();
			holder.x = stage.stageWidth * 0.5;
			holder.y = stage.stageHeight * 0.5;
			holder.z = 0;
			addChild(holder);
			
			items = new Array();
			
			for(var i:int = 0; i < numItems; i++)
			{
				var angle:Number = Math.PI * 2 / numItems * i;
				
				var face:Shape = makeItem();
				face.x = Math.cos(angle) * radius;
				face.z = Math.sin(angle) * radius;
				face.rotationY = -360 / numItems * i + 90;
				items.push(face);
				holder.addChild(face);
			}
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function makeItem():Shape
		{
			var face:Shape = new Shape();
			face.graphics.beginFill(Math.random() * 0xffffff);
			face.graphics.drawRect(-50,-50,100,100);
			face.graphics.endFill();
			return face;
		}
		private function onEnterFrame(e:Event):void
		{
			holder.rotationY += (stage.stageWidth * 0.5 - mouseX) * .01;
			//holder.y += (mouseY - holder.y) * .1;
			ThreeDeeUtils.sortOnZ(items);
		}
	}
}