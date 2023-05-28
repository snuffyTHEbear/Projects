package org.fly3D.display
{
	import flash.display.Bitmap;

	public class Head extends BasicDisplayObject3D
	{
		[Embed(source = "assets/head.png", mimeType = "image/png")]
		private var _headClass:Class;
		private var _b:Bitmap;
		
		public function Head()
		{
			_b = new _headClass();
			_b.x -= _b.width * 0.5;
			_b.y -= _b.height * 0.5;
			addChild(_b);
			super();
		}
	}
}