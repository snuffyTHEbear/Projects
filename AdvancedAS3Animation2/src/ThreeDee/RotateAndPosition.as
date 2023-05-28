package ThreeDee
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	public class RotateAndPosition extends Sprite
	{
		private var holder:Sprite;
		private var faces:Array = new Array();
		
		public function RotateAndPosition()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void
		{			
			holder = new Sprite();
			holder.x = stage.stageWidth * 0.5;
			holder.y = stage.stageHeight * 0.5;
			addChild(holder);
			holder.z = 0;
			
			makeShape("z", 200);
			makeShape("z", -200);
			makeShape("x", 200, "rotationY", 90);
			makeShape("x", -200, "rotationY", -90);
			makeShape("y", 200, "rotationX", 90);
			makeShape("y", -200, "rotationX", -90);
			
			sortFaces();
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame); 
		}
		private function makeShape(position:String, positionValue:Number, rotation:String=null, rotationValue:Number=0):void
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill(Math.random() * 0xffffff, 0.85);
			shape.graphics.drawRect(-100, -100, 200, 200);
			shape.graphics.endFill();
			holder.addChild(shape);
			faces.push(shape);
			shape[position] = positionValue;
			if(rotation != null)shape[rotation] = rotationValue;
		}
		private function sortFaces():void
		{
			faces.sort(depthSort);
			
			for(var i:int = 0; i < faces.length; i++)
			{
				faces[i].parent.setChildIndex(faces[i], i);
			}
		}
		private function depthSort(objA:DisplayObject, objB:DisplayObject):int
		{
			trace(holder.transform.matrix3D);
			var posA:Vector3D = objA.transform.matrix3D.position;
			posA = holder.transform.matrix3D.deltaTransformVector(posA);
			var posB:Vector3D = objB.transform.matrix3D.position;
			posB = holder.transform.matrix3D.deltaTransformVector(posB);
			return posB.z - posA.z;
		}
		private function onEnterFrame(e:Event):void
		{
			holder.rotationY += 2;
			holder.rotationX += 1.5;
			sortFaces();
		}
	}
}