package gui
{
	import com.bit101.components.HUISlider;
	
	import org.fly3D.geom.Point3D;
	
	public class AddPointControls extends Controls
	{
		private var _xInput:HUISlider;
		
		private var _yInput:HUISlider;
		
		private var _zInput:HUISlider;
		
		private var _vpXInput:HUISlider;
		
		private var _vpYInput:HUISlider;
		
		
		public function AddPointControls()
		{
			_xInput = new HUISlider(this, 5, 5, "X");
			_yInput = new HUISlider(this, 5, 25, "Y");
			_zInput = new HUISlider(this, 5, 45, "Z");
			_vpXInput = new HUISlider(this, 5, 65, "VPX");
			_vpYInput = new HUISlider(this, 5, 85, "VPY");
			
			setMaxMin(_xInput, 150, -150);
			setMaxMin(_yInput, 150, -150);
			setMaxMin(_zInput, 150, -150);
			setMaxMin(_vpXInput, 500, -500);
			setMaxMin(_vpYInput, 500, -500);
			
			drawBG();
		}
		
		public function getPoint():Point3D
		{
			var p:Point3D = new Point3D(_xInput.value, _yInput.value, _zInput.value);
			p.setVanishingPoint(_vpXInput.value, _vpYInput.value);
			return p;
		}
	}
}