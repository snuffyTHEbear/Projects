package
{
	import flash.display.Sprite;
	
	import hype.extended.color.ColorPool;
	import hype.extended.layout.ShapeLayout;
	import hype.framework.core.ObjectPool;
	import hype.framework.display.BitmapCanvas;
	
	import objects.BasicObject;
	
	[SWF(width = 640, height = 480 )]
	public class Doodles extends Sprite
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;
		
		private var _pool:ObjectPool;
		private var _colorPool:ColorPool = new ColorPool();
		private var _canvas:BitmapCanvas;
		private var _layout:ShapeLayout;
		
		public function Doodles()
		{
			init();
		}
		private function init():void
		{
			_colorPool.addColorsToPool(0xE7854C, 0xE7714C, 0xE0491B, 0x63B2B9 , 0xACE5EB);
			_pool = new ObjectPool(BasicObject, 50);
			_pool.onRequestObject = create;
			stage.scaleMode = "noScale";
		}
		private function create(bo:BasicObject):void
		{
			bo.move(centreX, centreY);
			bo.scaleX = bo.scaleY = 0;
			addChild(bo);
			_colorPool.colorObject(bo);
			
		}
	}
}