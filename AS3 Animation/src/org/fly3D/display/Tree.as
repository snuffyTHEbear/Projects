package org.fly3D.display
{
	import flash.display.Bitmap;
	
	public class Tree extends BasicDisplayObject3D
	{
		[Embed(source="assets/tree.png", mimeType = "image/png")] private var _treeClass:Class;
		private var b:Bitmap;
		
		public static const LINE:String = "line";
		public static const SPRITE:String = "sprite";
		
		public function Tree(type:String = "sprite")
		{
			switch(type)
			{
				
				case SPRITE:
					b = new _treeClass();
					addChild(b);
					b.x = -b.width * 0.5;
					b.y = -b.height;
					break;
				
				case LINE:
					graphics.lineStyle(0, 0x000000);
					graphics.lineTo(0, -140 - Math.random() * 20);
					graphics.moveTo(0, -30 - Math.random() * 30);
					graphics.lineTo(Math.random() * 80 - 40, -100 - Math.random() * 40);
					graphics.moveTo(0, -60 - Math.random() * 40);
					graphics.lineTo(Math.random() * 60 - 30, -110 - Math.random() * 20);
					break;
				
				default:
					b = new _treeClass();
					addChild(b);
					b.x = -b.width * 0.5;
					b.y = -b.height;
					break;
			}
			
			super();
		}
	}
}