package
{
	import com.arcticcode.greenFlames.isometric.ComplexIsometricObject;
	import com.arcticcode.greenFlames.isometric.IsometricEngine;
	import com.arcticcode.greenFlames.isometric.IsometricUtils;
	import com.arcticcode.greenFlames.preloader.ContentLoadedEvent;
	import com.arcticcode.greenFlames.preloader.Preloader;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class IsometricVis extends Sprite
	{
		private var engine:IsometricEngine;
		private var rightGrid:ComplexIsometricObject;
		private var leftGrid:ComplexIsometricObject;
		private var levels:ComplexIsometricObject;
		private const centreX:Number = stage.stageWidth*0.5;
		private const centreY:Number = stage.stageHeight*0.5;
		private var ba:ByteArray=new ByteArray();
		private var soundLoader:Preloader;
		private var url:String = "D:/snuffyTHEbear Music/snuffyTHEbear Music/ksut_zeo__distorted_heartbeats.mp3";
		
		public function IsometricVis()
		{
			init();
		}
		private function init():void
		{
			engine = new IsometricEngine(null,centreX,centreY+100,IsometricEngine.RIGHT,true,true);
			rightGrid = new ComplexIsometricObject();
			addChild(rightGrid);
			IsometricUtils.createXZGrid(rightGrid,128,1,2,0,2,false,0,true,Math.random()*0xffffff,"shapes");
			engine.drawObjectsComplex(rightGrid.objects);
			engine.addToDisplayList(rightGrid.objects,rightGrid);
			
			soundLoader = new Preloader(url,Preloader.MP3,false);
			soundLoader.addEventListener(ContentLoadedEvent.CONTENT_LOADED, onLoaded);
			soundLoader.load();
		}
		private function onLoaded(e:ContentLoadedEvent):void
		{
			var sound:Sound = e.content as Sound;
			sound.play();
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(e:Event):void
		{
			
		}
		private function vis():void
		{
			SoundMixer.computeSpectrum(ba,true);
			for(var i:uint=0;i<128;i++)
			{
				rightGrid.objects[i].h = (ba.readFloat()*100);
				engine.g = rightGrid.objects[i].graphics;
				engine.drawObject(rightGrid.objects[i]);
			}
		}
	}
}