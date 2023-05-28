package
{
	import com.arcticcode.greenFlames.graphics.ColourUtils;
	
	import fl.events.ColorPickerEvent;
	import fl.events.SliderEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	[SWF(width=600,height=400,backgroundColor=0xFFFFFF)]
	[Frame(factoryClass="com.arcticcode.greenFlames.preloader.BasePreloader")]
	
	public class ColourUtilsApp extends Sprite
	{
		private var bmd:BitmapData;
		private var b:Bitmap;
		//
		private var redBMD:BitmapData;
		private var redB:Bitmap;
		//
		private var greenBMD:BitmapData;
		private var greenB:Bitmap;
		//
		private var blueBMD:BitmapData;
		private var blueB:Bitmap;
		//		
		private var gui:GUI;
		private var textUtils:TextUtils;
		//
		private var redVal:uint = 255;
		private var greenVal:uint = 255;
		private var blueVal:uint = 255;
		private var alphaVal:uint = 255;
		private var colour:uint=0xFFFFFF;
		private var currOption:String = "ALL";
		
		public function ColourUtilsApp()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void
		{
			bmd = new BitmapData(75,25,true,ColourUtils.combineColours32(alphaVal,redVal,greenVal,blueVal));
			b = new Bitmap(bmd);
			b.x = 500;
			b.y = 25;
			addChild(b);
			//
			redBMD = new BitmapData(75,25,false,ColourUtils.combineColours24(redVal,0,0));
			redB = new Bitmap(redBMD);
			redB.x = 500;
			redB.y = 75;
			addChild(redB);
			//
			greenBMD = new BitmapData(75,25,false,ColourUtils.combineColours24(0,greenVal,0));
			greenB = new Bitmap(greenBMD);
			greenB.x = 500;
			greenB.y = 125;
			addChild(greenB);
			//
			blueBMD = new BitmapData(75,25,false,ColourUtils.combineColours24(0,0,blueVal));
			blueB = new Bitmap(blueBMD);
			blueB.x = 500;
			blueB.y = 175;
			addChild(blueB);
			//
			setUp();
		}
		private function setUp():void
		{
			gui = new GUI();
			gui.x = gui.width*0.5-20;
			gui.y = 5;
			addChild(gui);
			//
			gui.allRadio.addEventListener(MouseEvent.CLICK, onRadio);
			gui.blueRadio.addEventListener(MouseEvent.CLICK, onRadio);
			gui.greenRadio.addEventListener(MouseEvent.CLICK, onRadio);
			gui.redRadio.addEventListener(MouseEvent.CLICK, onRadio);
			gui.alphaRadio.addEventListener(MouseEvent.CLICK, onRadio);
			//
			gui.valSlider.addEventListener(SliderEvent.CHANGE, onSlide);
			gui.valSlider.addEventListener(SliderEvent.THUMB_DRAG, onSlide);
			gui.valSlider.addEventListener(SliderEvent.THUMB_RELEASE, onSlide);
			gui.valSlider.addEventListener(SliderEvent.THUMB_PRESS, onSlide);
			//
			gui.cp.addEventListener(ColorPickerEvent.CHANGE, onColorChange);
			//
			gui.alphaStep.addEventListener(Event.CHANGE, onStep);
			gui.grennStep.addEventListener(Event.CHANGE, onStep);
			gui.redStep.addEventListener(Event.CHANGE, onStep);
			gui.blueStep.addEventListener(Event.CHANGE, onStep);
			//
			gui.lightenBtn.addEventListener(MouseEvent.CLICK, onClick);
			gui.darkenBtn.addEventListener(MouseEvent.CLICK, onClick);
			gui.extractBtn.addEventListener(MouseEvent.CLICK, onClick);
			gui.comb24.addEventListener(MouseEvent.CLICK, onClick);
			gui.comb32.addEventListener(MouseEvent.CLICK, onClick);
			//
			gui.allRadio.selected = true;
		}
		private function reDraw():void
		{
			colour = ColourUtils.combineColours32(alphaVal,redVal,greenVal,blueVal);
			//
			switch(currOption)
			{
				case "RED":
				redVal = gui.valSlider.value;
				break;
				
				case "GREEN":
				greenVal = gui.valSlider.value;
				break;
				
				case "BLUE":
				blueVal = gui.valSlider.value;
				break;
				
				case "ALPHA":
				alphaVal = gui.valSlider.value;
				break;
				
				case "ALL":
				redVal = ColourUtils.extractRed(colour);
				greenVal = ColourUtils.extractGreen(colour);
				blueVal = ColourUtils.extractBlue(colour);
				break;
			}
			bmd.fillRect(bmd.rect, ColourUtils.combineColours32(alphaVal,ColourUtils.extractRed(colour),ColourUtils.extractGreen(colour),ColourUtils.extractBlue(colour)));
			redBMD.fillRect(redBMD.rect,ColourUtils.combineColours24(redVal,0,0));
			greenBMD.fillRect(greenBMD.rect,ColourUtils.combineColours24(0,greenVal,0));
			blueBMD.fillRect(blueBMD.rect,ColourUtils.combineColours24(0,0,blueVal));
			//
			gui.output.text = "ARGB Color: 0x" + colour.toString(16) + "\nRGB Color: 0x" + uint(ColourUtils.combineColours24(redVal,greenVal,blueVal)).toString(16) + "\nRed: " + redVal + "\nGreen: " + greenVal + "\nBlue: " + blueVal;
		}
		private function onClick(e:MouseEvent):void
		{
			trace(e.target.name);
			switch(e.target.name)
			{
				case "lightenBtn":
				colour = ColourUtils.lightenColour({red:ColourUtils.extractRed(colour),green:ColourUtils.extractGreen(colour),blue:ColourUtils.extractBlue(colour)},gui.redStep.value,gui.grennStep.value,gui.blueStep.value);
				redVal = ColourUtils.extractRed(colour);
				greenVal = ColourUtils.extractGreen(colour);
				blueVal = ColourUtils.extractBlue(colour);
				reDraw();
				break;
				
				case "darkenBtn":
				
				break
			}
		}
		private function onColorChange(e:ColorPickerEvent):void
		{
			colour = e.color;
			reDraw();
		}
		private function onStep(e:Event):void
		{
			trace(e.target.name,e.target.value);
		}
		private function onSlide(e:SliderEvent):void
		{
			trace(e.value);
			reDraw();
		}
		private function onRadio(e:MouseEvent):void
		{
			var str:String = e.target.name;
			currOption = (str.slice(0,str.indexOf("Radio",0))).toUpperCase();
			switch(currOption)
			{
				case "RED":
				gui.valSlider.value = redVal;
				break;
				
				case "GREEN":
				gui.valSlider.value = greenVal;
				break;
				
				case "BLUE":
				gui.valSlider.value = blueVal;
				break;
				
				case "ALPHA":
				gui.valSlider.value = alphaVal;
				break;
			}
		}
	}
}