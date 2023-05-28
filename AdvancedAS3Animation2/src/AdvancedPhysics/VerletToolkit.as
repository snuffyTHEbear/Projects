package AdvancedPhysics
{
	import com.bit101.components.InputText;
	import com.bit101.components.PushButton;
	import com.bit101.components.Window;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class VerletToolkit extends Sprite
	{
		//
		private var _stageWidth:Number;
		private var _stageHeight:Number;
		private var _centreX:Number;
		private var _centreY:Number;
		
		//GUI
		private var _pointPropsWindow:Window;
		private var _stickPropsWindow:Window;
		private var _addPointButton:PushButton;
		
		//Properties
		private var _xInput:InputText;
		private var _yInput:InputText;
		private var _vxInput:InputText;
		private var _vyInput:InputText;
		
		
		public function VerletToolkit(stageWidth:Number, stageHeight:Number)
		{
			_stageWidth = stageWidth;
			_stageHeight = stageHeight;
			_centreX = _stageWidth * 0.5;
			_centreY = _stageHeight * 0.5;
			
			init();
			initGUI();
		}
		private function init():void
		{
			
		}
		private function initGUI():void
		{
			_addPointButton = new PushButton(this, 10, 10, "Add point", addPoint_Handler);
			_addPointButton.toggle = true;
		}
		private function addPoint_Handler(e:Event):void
		{
			if(_addPointButton.selected)
			{
				
			}
			else
			{
				
			}
		}
	}
}