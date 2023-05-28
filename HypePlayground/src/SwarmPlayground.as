package
{
	import com.arcticcode.greenFlames.display.shapes.BasicShape;
	import com.arcticcode.greenFlames.display.shapes.ShapeUtils;
	
	import flash.display.Sprite;
	
	import hype.extended.color.ColorPool;
	
	public class SwarmPlayground extends Sprite
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;
		private var _colorPool:ColorPool = new ColorPool();
		
		private var _shapeA:BasicShape;
		private var _shapeB:BasicShape;
		
		public function SwarmPlayground()
		{
			init();
		}
		private function init():void
		{
			for (var i:uint = 0 ; i < ShapeUtils._defaultHypeColors.length;i++ )
			{
				_colorPool.addColor(ShapeUtils._defaultHypeColors[i]);
			}
			
			//_colorPool.addColor
			//_colorPool.addColorsToPool(ShapeUtils._defaultHypeColors);
			
			_shapeA = new BasicShape(ShapeUtils.ROUNDED_SQUARE);
			_shapeA.move(centreX, centreY);
			_shapeB = new BasicShape(ShapeUtils.ROUNDED_SQUARE);
			_shapeB.move(50, 50);
			addChild(_shapeA);
			addChild(_shapeB);
			
			_colorPool.colorChildren(_shapeA);
			_colorPool.colorChildren(_shapeB);
			//_colorPool.colorObjects(_shapeA, _shapeB);
		}
	}
}