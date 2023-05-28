package
{
	import com.arcticcode.greenFlames.ThreeDee.geom.Point3D;
	import com.bit101.components.HUISlider;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class SphericalLissajous extends Sprite
	{
		private var _centerX:Number = stage.stageWidth * 0.5;
		
		private var _centerY:Number = stage.stageHeight * 0.5;
		
		private var _angle:Number = 0.3;
		
		private var _p:Point3D;
		
		private var _circle:Sprite = new Sprite();
		
		private var _zSlider:HUISlider;
		
		public function SphericalLissajous()
		{
			_p = new Point3D(0, 0, 0);
			_p.setVanishingPoint(_centerX, _centerY);
			
			_circle.graphics.beginFill(0xcc0000);
			_circle.graphics.drawCircle(0, 0, 30);
			_circle.graphics.endFill();
			addChild(_circle);
			_circle.x = _centerX;
			_circle.y = _centerY;
			
			_zSlider = new HUISlider(this, 10, 10, "Z");
			_zSlider.maximum = 300;
			_zSlider.minimum = -300;
			_zSlider.value = 0;
			
			addEventListener(Event.ENTER_FRAME, enterFrame_Handler);
		}
		
		private function enterFrame_Handler(e:Event):void
		{
			_p.z = _zSlider.value;
			var scale:Number = _p.focalLength / (_p.focalLength + _p.z);
			_circle.scaleX = _circle.scaleY = scale;
			_circle.visible = _p.inView();
		}
		
		private function lissajous(x:Number, y:Number, z:Number):void
		{
		
		}
	}
}