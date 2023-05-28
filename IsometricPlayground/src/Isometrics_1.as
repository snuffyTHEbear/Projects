package
{
	import caurina.transitions.Tweener;
	
	import com.arcticcode.greenFlames.components.MemFpsCount;
	import com.arcticcode.greenFlames.isometric.CoordinateSystem;
	import com.arcticcode.greenFlames.isometric.IsometricEngine;
	import com.arcticcode.greenFlames.isometric.IsometricObject;
	import com.bit101.components.CheckBox;
	import com.bit101.components.ColorChooser;
	import com.bit101.components.HUISlider;
	import com.bit101.components.PushButton;
	
	import flash.display.Sprite;
	import flash.events.Event;
	[SWF(width=600,height=400,backgroundColor=0xFFFFFF)]
	[Frame(factoryClass="com.arcticcode.greenFlames.preloader.BasePreloader")]
	public class Isometrics_1 extends Sprite
	{
		private var engine:IsometricEngine;
		private var block:IsometricObject;
		private var centreX:Number = 0;
		private var centreY:Number = 0;
		//Position
		private var xSlider:HUISlider;
		private var ySlider:HUISlider;
		private var zSlider:HUISlider;
		//Size
		private var wSlider:HUISlider;
		private var hSlider:HUISlider;
		private var dSlider:HUISlider;
		//Colour
		private var fcp:ColorChooser;
		private var fToggle:CheckBox;
		//Line
		private var lcp:ColorChooser;
		private var lToggle:CheckBox;
		private var caToggle:CheckBox;
		//
		private var tweenBtn:PushButton;
		private var resetBtn:PushButton;
		private var tween:Object = {w:0,h:0,d:0,x:0,y:0,z:0,time:1,transition:"easeinoutexpo",onUpdate:render};
		//
		private var _cs:CoordinateSystem = new CoordinateSystem();
		
		public function Isometrics_1()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void
		{
			centreX = stage.stageWidth * 0.5;
			centreY = stage.stageHeight * 0.5+190;
			
			var _fm:MemFpsCount = new MemFpsCount();
			_fm.x = stage.stageWidth - 100;
			addChild(_fm);
			
			engine = new IsometricEngine(super.graphics,centreX,centreY);
			
			block = new IsometricObject(0,0,0,15,30,15,false,0,true,0xCCCCCC);
			
			engine.drawBox(block);
			
			_cs.x = centreX;
			_cs.y = centreY;
			addChild(_cs);
			
			setUpGUI();
		}
		private function setUpGUI():void
		{
			xSlider = new HUISlider(this,5,5,"X",onSlide);
			xSlider.value = block.x;
			ySlider = new HUISlider(this,5,25,"Y",onSlide);
			ySlider.value = block.y;
			zSlider = new HUISlider(this,5,45,"Z",onSlide);
			zSlider.value = block.z;
			//
			wSlider = new HUISlider(this,5,70,"W",onSlide);
			wSlider.value = block.w;
			hSlider = new HUISlider(this,5,90,"H",onSlide);
			hSlider.value = block.h;
			dSlider = new HUISlider(this,5,110,"D",onSlide);
			dSlider.value = block.d;
			//
			fcp = new ColorChooser(this,45,140,block.fillColour,onSlide);
			fToggle = new CheckBox(this,fcp.x+fcp.width+10,fcp.y,"Fill",onSlide);
			fToggle.selected = true;
			//
			lcp = new ColorChooser(this,45,170,block.lineColour,onSlide);
			lToggle = new CheckBox(this,lcp.x+lcp.width + 10, lcp.y,"Line",onSlide);	
			//
			tweenBtn = new PushButton(this,40,200,"Tween",onTween);		
			tweenBtn.setSize(100,16);
			resetBtn = new PushButton(this,40,220,"Reset", onReset);
			resetBtn.setSize(100,16);
			//
			caToggle = new CheckBox(this,5,240,"Colour Adjust: solid white/black",onSlide);
			caToggle.selected = engine.colourAdjust;
		}
		private function onReset(e:Event):void
		{
			tween.w = 15;
			tween.h = 30;
			tween.d = 15;
			//
			tween.x = 0;
			tween.y = 0;
			tween.z = 0;
			Tweener.addTween(block, tween);
		}
		private function onTween(e:Event):void
		{
			tween.w = Math.random() * 100;
			tween.h = Math.random() * 100;
			tween.d = Math.random() * 100;
			//
			tween.x = Math.random()*100;
			tween.y = Math.random()*100;
			tween.z = Math.random()*100;
			Tweener.addTween(block, tween);
		}
		private function onSlide(e:Event):void
		{
			block.x = xSlider.value;
			block.y = ySlider.value;
			block.z = zSlider.value;
			
			block.h = hSlider.value;
			block.w = wSlider.value;
			block.d = dSlider.value;
			
			if(fToggle.selected)
			{
				block.fill = true;
				block.fillColour = fcp.value;
			}
			else
			{
				block.fill = false;
			}
			
			if(lToggle.selected)
			{
				block.line = true;
				block.lineColour = lcp.value;
			}
			else
			{
				block.line = false;
			}
			
			engine.colourAdjust = caToggle.selected;
			
			render();
		}
		private function render():void
		{
			if(Tweener.isTweening(block))
			{
				xSlider.value = block.x;
				ySlider.value = block.y;
				zSlider.value = block.z;
				//
				wSlider.value = block.w;
				hSlider.value = block.h;
				dSlider.value = block.d;
			}
			//engine.clear();
			engine.drawBox(block);
		}
	}
}