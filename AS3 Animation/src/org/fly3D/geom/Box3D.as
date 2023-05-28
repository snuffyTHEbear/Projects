package org.fly3D.geom
{
	import org.fly3D.display.BasicDisplayObject3D;

	public class Box3D
	{
		public var top:Number, bottom:Number,
					left:Number, right:Number,
					back:Number, front:Number;
		
		/**
		 * 
		 * @param tp - Top
		 * @param bm - Bottom
		 * @param lt - Left
		 * @param rt - Right
		 * @param bk - Back
		 * @param ft - Front
		 * 
		 */					
		public function Box3D(tp:Number, bm:Number, lt:Number, rt:Number, bk:Number, ft:Number)
		{
			top = tp;
			bottom = bm;
			left = lt;
			right = rt;
			back = bk;
			front = ft;
		}
		public function checkBounds(obj:BasicDisplayObject3D, w:Number, h:Number, d:Number):void
		{
			if(obj.position.x + w > right)
			{
				obj.position.x = right - w;
				obj.velocity.x *= -1;
			}
			else if(obj.position.x - w < left)
			{
				obj.position.x = left + w;
				obj.velocity.x *= -1;
			}
			if(obj.position.y + h > bottom)
			{
				obj.position.y = bottom - h;
				obj.velocity.y *= -1;
			}
			else if(obj.position.y - h < top)
			{
				obj.position.y = top + h;
				obj.velocity.y *= -1;
			}
			if(obj.position.z + d > front)
			{
				obj.position.z = front - d;
				obj.velocity.z *= -1;
			}
			else if(obj.position.z - d < back)
			{
				obj.position.z = back + d;
				obj.velocity.z *= -1;
			}
		}
	}
}