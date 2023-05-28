package
{
	import com.arcticcode.greenFlames.graphics.CreateRect;
	import com.arcticcode.greenFlames.isometric.core.IsometricEngine;
	import com.arcticcode.greenFlames.isometric.math.IsoMath;
	import com.arcticcode.greenFlames.xPreloader.XPreloader;
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.Text;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	[SWF(width=700, height = 500, backgroundColor = 0xffffff)]
	public class IsometricExp extends Sprite
	{
		//add interactivity to manipulate algorithm
		private var engine:IsometricEngine;
		
		private var centreX:Number = stage.stageWidth * 0.5;
		
		private var centreY:Number = stage.stageHeight * 0.5;
		
		private var cont:Sprite;
		
		private var bmd:BitmapData;
		
		private var b:Bitmap;
		
		private var startAngle:Number = 0;
		
		private var angleIncr:Number = 1;
		
		private var startNum:Number = -2;
		
		private var endNum:Number = 4;
		
		private var startNumB:Number = -8;
		
		private var endNumB:Number = 5;
		
		private var incr:Number = 1;
		
		private var incrB:Number = 1;
		
		private var colourMult:uint = 10000000;
		
		private var _text:Label;
		
		//
		private var processBtn:PushButton;
		
		private var startAngleInput:Text;
		
		private var angleIncrInput:Text;
		
		private var startNumInput:Text;
		
		private var endNumInput:Text;
		
		private var startNumBInput:Text;
		
		private var endNumBInput:Text;
		
		private var incrInput:Text;
		
		private var incrInputB:Text;
		
		private var colourMultInput:Text;
		
		private var pauseBtn:PushButton;
		
		private var paused:Boolean = false;
		
		private var userText:Label;
		
		private var _user:String = "";
		
		private var urls:Array;
		
		private var track:Label;
		
		private var trackInfo:Array;
		
		private var nextBtn:PushButton;
		
		private var prevBtn:PushButton;
		
		private var toggleAudio:PushButton;
		
		private var audio:Boolean = true;
		
		private var loader:XPreloader;
		
		private var bar:CreateRect;
		
		private var index:uint = 0;
		
		private var sound:Sound;
		
		private var perc:Label;
		
		private var sc:SoundChannel;
		
		public function IsometricExp()
		{
			init();
		}
		
		private function init():void
		{
			if (loaderInfo.parameters.ng_username != null)
			{
				_user = "Hi " + loaderInfo.parameters.ng_username;
			}
			else
			{
				_user = "Hi Guest";
			}
			
			urls = new Array("http://www.newgrounds.com/audio/download/182636", "http://www.newgrounds.com/audio/download/179637", "http://www.newgrounds.com/audio/download/189709");
			trackInfo = new Array("Psy-nigma - Fluttering Chimera", "RopeDrink - RD Mindframe", "Gillenium - Forever And Ever (Version 1)");
			
			engine = new IsometricEngine(null, centreX, centreY, IsometricEngine.RIGHT, false, true);
			
			loader = new XPreloader(urls[index], XPreloader.MP3, false);
			loader.addEventListener(Event.COMPLETE, onLoaded);
			loader.addEventListener(ProgressEvent.PROGRESS, onProg);
			loader.load();
			
			bar = new CreateRect(0, 16, true, true, 0xCCCCCC, 1, false);
			bar.move(stage.stageWidth - 230, 30);
			
			cont = new Sprite();
			//addChild(cont);
			
			bmd = new BitmapData(stage.stageWidth, stage.stageHeight, false, 0xffffff);
			b = new Bitmap(bmd);
			addChild(b);
			
			addChild(bar);
			
			engine.angle = 0;
			
			gui();
			
			userText = new Label(this, 5, 5, _user);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onProg(e:ProgressEvent):void
		{
			bar.width = e.bytesLoaded / e.bytesTotal * 100;
			perc.text = Math.ceil(e.bytesLoaded / e.bytesTotal * 100).toString() + " %";
		}
		
		private function onLoaded(e:Event):void
		{
			bar.width = 0;
			perc.text = "";
			sound = loader.content;
			sc = sound.play();
			sc.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		}
		
		private function gui():void
		{
			_text = new Label(this, 60, 25, "Angle Increment\n\nStart Value A\n\nEnd Value A\n\nStart Value B\n\nEnd Value B\n\nInrement A\n\nIncrement B\n\n\t\tColour Multiplier");
			//startAngleInput = new Text(this,5,5,startAngle.toString());
			//doLooks(startAngleInput);
			angleIncrInput = new Text(this, 5, 25, angleIncr.toString());
			doLooks(angleIncrInput);
			startNumInput = new Text(this, 5, 50, startNum.toString());
			doLooks(startNumInput);
			endNumInput = new Text(this, 5, 75, endNum.toString());
			doLooks(endNumInput);
			startNumBInput = new Text(this, 5, 100, startNumB.toString());
			doLooks(startNumBInput);
			endNumBInput = new Text(this, 5, 125, endNumB.toString());
			doLooks(endNumBInput);
			incrInput = new Text(this, 5, 150, incr.toString());
			doLooks(incrInput);
			incrInputB = new Text(this, 5, 175, incrB.toString());
			doLooks(incrInputB);
			colourMultInput = new Text(this, 5, 200, colourMult.toString());
			doLooks(colourMultInput, 100);
			processBtn = new PushButton(this, 5, 225, "Clear & Restart", onProcessClick);
			pauseBtn = new PushButton(this, 5, 250, "Pause Proccessing", onPause);
			nextBtn = new PushButton(this, stage.stageWidth - 25, 5, ">", onNext);
			nextBtn.setSize(20, 20);
			prevBtn = new PushButton(this, stage.stageWidth - 50, 5, "<", onPrev);
			prevBtn.setSize(20, 20);
			track = new Label(this, stage.stageWidth - 230, 6, trackInfo[index]);
			track.setSize(track.width, 20);
			perc = new Label(this, stage.stageWidth - 115, 28, "");
			toggleAudio = new PushButton(this, stage.stageWidth - 55, 30, "Audio Off", onToggleAudio);
			toggleAudio.setSize(50, 16);
		}
		
		private function onToggleAudio(e:Event):void
		{
			if (audio)
			{
				if (sound != null)
				{
					sc.stop();
					sound = null;
				}
				else
				{
					loader.close();
					bar.width = 0;
					perc.text = "";
				}
				track.text = "Audio Off";
				toggleAudio.label = "Audio On";
				nextBtn.alpha = 0.75;
				prevBtn.alpha = 0.75;
				nextBtn.removeEventListener(MouseEvent.CLICK, onNext);
				prevBtn.removeEventListener(MouseEvent.CLICK, onPrev);
			}
			else
			{
				loader.loadURL(urls[index], XPreloader.MP3, true);
				track.text = trackInfo[index];
				toggleAudio.label = "Audio On";
				nextBtn.alpha = 1;
				prevBtn.alpha = 1;
				nextBtn.addEventListener(MouseEvent.CLICK, onNext);
				prevBtn.addEventListener(MouseEvent.CLICK, onPrev);
			}
			audio = !audio;
		}
		
		private function onSoundComplete(e:Event):void
		{
			next();
		}
		
		private function onNext(e:Event):void
		{
			next();
		}
		
		private function next():void
		{
			index += 1;
			if (index == urls.length)
			{
				index = 0;
			}
			if (perc.text != "")
			{
				loader.close();
			}
			loader.loadURL(urls[index], XPreloader.MP3, true);
			track.text = trackInfo[index];
			if (sound != null)
			{
				sc.stop();
			}
			if (sound != null)
				sc.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		}
		
		private function onPrev(e:Event):void
		{
			prev();
		}
		
		private function prev():void
		{
			if (index == 0)
			{
				index = (urls.length - 1);
			}
			else
			{
				index -= 1;
			}
			if (perc.text != "")
			{
				loader.close();
			}
			loader.loadURL(urls[index], XPreloader.MP3, true);
			track.text = trackInfo[index];
			if (sound != null)
			{
				sc.stop();
			}
			if (sound != null)
				sc.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		}
		
		private function onPause(e:Event):void
		{
			if (paused)
			{
				addEventListener(Event.ENTER_FRAME, onEnterFrame);
				pauseBtn.label = "Pause Proccessing"
			}
			else
			{
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				pauseBtn.label = "Unpause Proccessing";
			}
			paused = !paused;
		}
		
		private function onProcessClick(e:Event):void
		{
			if (paused)
			{
				pauseBtn.label = "Pause Proccessing"
			}
			paused ? paused = false : null;
			bmd.fillRect(bmd.rect, 0xffffff);
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			//startAngle = Number(startAngleInput.text);
			//engine.angle = startAngle;
			angleIncr = Number(angleIncrInput.text);
			startNum = Number(startNumInput.text);
			endNum = Number(endNumInput.text);
			startNumB = Number(startNumBInput.text);
			endNumB = Number(endNumBInput.text);
			incr = Number(incrInput.text);
			incrB = Number(incrInputB.text);
			colourMult = uint(colourMultInput.text);
			//process();
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function doLooks(param:Text, w:Number = 50):void
		{
			param.setSize(w, 20);
		}
		
		private function onEnterFrame(e:Event):void
		{
			engine.angle += angleIncr;
			
			for (var i:Number = startNum; i < endNum; i += incr)
			{
				for (var j:Number = startNumB; j < endNumB; j += incrB)
				{
					var _x:Number = IsoMath.xFlash(i * 10, 0, j * 10, engine.angle, engine.xOrigin);
					var _y:Number = IsoMath.yFlash(i * 10, 0, j * 10, engine.angle, engine.yOrigin);
					var _c:uint = (j * 10) * colourMult;
					cont.graphics.clear();
					cont.graphics.lineStyle(0, _c);
					cont.graphics.drawCircle(_x, _y, 2);
					//cont.graphics.lineTo(_x,_y);
					bmd.draw(cont, cont.transform.matrix);
				}
			}
		}
	}
}