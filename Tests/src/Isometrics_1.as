package 
{
	import caurina.transitions.Tweener;
	
	import com.arcticcode.greenFlames.components.MemFpsCount;
	import com.arcticcode.greenFlames.isometric.core.IsometricEngine;
	import com.arcticcode.greenFlames.isometric.core.objects.CoordinateSystem;
	import com.arcticcode.greenFlames.isometric.core.objects.IsometricObject;
	import com.arcticcode.greenFlames.isometric.geom.IsoDimensions;
	import com.arcticcode.greenFlames.isometric.geom.IsoPoint3D;
	import com.arcticcode.greenFlames.isometric.graphics.GraphicsOptions;
	import com.arcticcode.greenFlames.isometric.graphics.fill.FillOptions;
	import com.arcticcode.greenFlames.isometric.graphics.line.LineStyle;
	import com.bit101.components.CheckBox;
	import com.bit101.components.ColorChooser;
	import com.bit101.components.HUISlider;
	import com.bit101.components.PushButton;
	
	import flash.display.Sprite;
	import flash.events.Event;

	[SWF(width=600,height=400,backgroundColor=0xFFFFFF)]
	//[Frame(factoryClass="com.arcticcode.greenFlames.preloader.BasePreloader")]
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
			
			//block = new IsometricObject(0,0,0,15,30,15,false,0,true,0xCCCCCC);
			block = new IsometricObject(new IsoPoint3D(0,0,0), new IsoDimensions(15, 30, 15), 
										new GraphicsOptions(new LineStyle(), new FillOptions(0xCCCCCC),
										null));
			
			engine.drawObject(block);
			
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
			wSlider.value = block.dimensions.width;
			hSlider = new HUISlider(this,5,90,"H",onSlide);
			hSlider.value = block.dimensions.height;
			dSlider = new HUISlider(this,5,110,"D",onSlide);
			dSlider.value = block.dimensions.depth;
			//
			fcp = new ColorChooser(this,45,140,block.graphicsOptions.fillOptions.color,onSlide);
			fToggle = new CheckBox(this,fcp.x+fcp.width+10,fcp.y,"Fill",onSlide);
			fToggle.selected = true;
			//
			lcp = new ColorChooser(this,45,170,block.graphicsOptions.lineStyle.color,onSlide);
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
			block.position.x = xSlider.value;
			block.position.y = ySlider.value;
			block.position.z = zSlider.value;
			
			block.dimensions.height = hSlider.value;
			block.dimensions.width = wSlider.value;
			block.dimensions.depth = dSlider.value;
			
			if(fToggle.selected)
			{
				block.graphicsOptions.fillOptions.alpha = 1;
				block.graphicsOptions.fillOptions.color = fcp.value;
			}
			else
			{
				block.graphicsOptions.fillOptions.alpha = 0;
			}
			
			if(lToggle.selected)
			{
				block.graphicsOptions.lineStyle.alpha = 1;
				block.graphicsOptions.lineStyle.color = lcp.value;
			}
			else
			{
				block.graphicsOptions.lineStyle.alpha = 0;
			}
			
			engine.colourAdjust = caToggle.selected;
			
			render();
		}
		private function render():void
		{
			if(Tweener.isTweening(block))
			{
				xSlider.value = block.position.x;
				ySlider.value = block.position.y;
				zSlider.value = block.position.z;
				//
				wSlider.value = block.dimensions.width;
				hSlider.value = block.dimensions.height;
				dSlider.value = block.dimensions.depth;
			}
			//engine.clear();
			engine.drawObject(block);
		}
	}
}