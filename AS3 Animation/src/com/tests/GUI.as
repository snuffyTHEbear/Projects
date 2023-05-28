package com.tests
{
	import com.bit101.components.PushButton;
	
	import flash.events.Event;
	
	import gui.AddPointControls;
	import gui.Controls;
	
	import org.fly3D.display.BasicScene;
	import org.fly3D.display.BasicShape3D;
	import org.fly3D.geom.Light;
	
	/**
	 *TODO - Add objects and allow them to be interacted with and modified via controls
	 * @author Rob
	 *
	 */
	public class GUI extends BasicScene
	{
		private var _light:Light;
		
		private var _child:BasicShape3D;
		
		private var _pointControls:AddPointControls;
		
		private var _closeControls:PushButton;
		
		private var _controls:Controls;
		
		public function GUI(w:Number, h:Number)
		{
			super(w * 0.5, h * 0.5, 250);
			
			setupControls();
		}
		
		private function setupControls():void
		{
			var addPointBtn:PushButton = new PushButton(this, 10, 10, "Point", addPoint);
			var addLightBtn:PushButton = new PushButton(this, 10, 30, "Light", addLight);
			_closeControls = new PushButton(this, 10, stage.stageHeight - 10, "Close", closeControls);
			
			addPointBtn.height = addLightBtn.height = _closeControls.height = 15;
			
			_pointControls = addChild(new AddPointControls()) as AddPointControls;
			_pointControls.visible = false;
		}
		
		private function closeControls(e:Event):void
		{
			_controls.closeControls();
		}
		
		private function addPoint(e:Event):void
		{
			_pointControls.visible = true;
			_pointControls.x = stage.stageWidth * 0.5 - _pointControls.width * 0.5;
			_pointControls.y = stage.stageHeight * 0.5 - _pointControls.height * 0.5;
			_controls = _pointControls;
		}
		
		private function addLight(e:Event):void
		{
		
		}
	}
}