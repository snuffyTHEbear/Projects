import flash.media.Sound;
import flash.net.URLRequest;
import flash.events.Event;
import com.arcticcode.greenFlames.sound.recorder.SoundRecorder;
import org.bytearray.micrecorder.encoder.WaveEncoder;
import fr.kikko.lab.ShineMP3Encoder;
import flash.utils.ByteArray;
import com.codeazur.as3swf.SWFData;
import com.codeazur.as3swf.tags.TagEnd;
import com.codeazur.as3swf.tags.TagShowFrame;
import com.codeazur.as3swf.data.SWFSymbol;
import com.codeazur.as3swf.tags.TagSymbolClass;
import com.codeazur.as3swf.tags.TagDoABC;
import com.codeazur.as3swf.tags.TagDefineSound;
import com.codeazur.as3swf.tags.TagDefineSceneAndFrameLabelData;
import com.codeazur.as3swf.data.SWFScene;
import com.codeazur.as3swf.tags.TagSetBackgroundColor;
import com.codeazur.as3swf.tags.TagFileAttributes;
import com.codeazur.as3swf.SWF;
import efnx.events.WaveformEvent;
import flash.display.Loader;
import flash.events.ErrorEvent;
import flash.events.ProgressEvent;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

var _controls:WaveformRecodingControls2 = new WaveformRecodingControls2();
addChild(_controls);

_controls.x = stage.stageWidth * 0.5;
_controls.y = stage.stageHeight * 0.5;

var modelSound:Sound = new Sound(new URLRequest("overtake.mp3"));
modelSound.addEventListener(Event.COMPLETE, modelSoundLoaded);

var soundB:Sound;

var modelSpectr:Spectr;
var userSpectr:Spectr;

var _soundRecorder:SoundRecorder=new SoundRecorder();
var _wavEncoder:WaveEncoder = new WaveEncoder();
var _mp3Encoder:ShineMP3Encoder;
var _wavData:ByteArray;
var _mp3Data:ByteArray;

function modelSoundLoaded(e:Event):void
{
	modelSpectr = new Spectr(_controls.modelWaveform.width,_controls.modelWaveform.height,modelSound);
	modelSpectr.addEventListener(Event.COMPLETE, modelWaveformComplete);
	_controls.modelWaveform.addChild(modelSpectr);
	
	_controls.recordBtn.addEventListener(MouseEvent.CLICK, recordClick);
}

function modelWaveformComplete(e:Event):void
{
	soundB = new Sound(new URLRequest("tennis-court.mp3"));
	soundB.addEventListener(Event.COMPLETE, soundBLoaded);
}

function soundBLoaded(e:Event):void
{
	userSpectr = new Spectr(_controls.userWaveform.width,_controls.userWaveform.height,soundB);
	_controls.userWaveform.addChild(userSpectr);
	_controls.userWaveform.buttonMode = true;
	_controls.userWaveform.addEventListener(MouseEvent.MOUSE_DOWN, waveformMouseDown);
}

function waveformMouseDown(e:MouseEvent):void
{
	_controls.userWaveform.addEventListener(MouseEvent.MOUSE_MOVE, waveformMouseMove);
}

function waveformMouseMove(e:MouseEvent):void
{
	_controls.userWaveform.x = _controls.mouseX;
	e.updateAfterEvent();
}

function recordClick(e:MouseEvent):void
{
	if (_soundRecorder.isRecording)
	{
		
	}
	else
	{
		_soundRecorder.startRecording();
		_controls.stopUserBtn.addEventListener(MouseEvent.CLICK, stopUserClick);
		_controls.recordBtn.removeEventListener(MouseEvent.CLICK, recordClick);
	}
}

function stopUserClick(e:MouseEvent):void
{
	_controls.stopUserBtn.removeEventListener(MouseEvent.CLICK, stopUserClick);
	_soundRecorder.stopRecording();
	_wavData = _wavEncoder.encode(_soundRecorder.soundData);
	_mp3Encoder = new ShineMP3Encoder(_wavData);
	_mp3Encoder.addEventListener(Event.COMPLETE, mp3EncodeComplete);
	_mp3Encoder.addEventListener(ErrorEvent.ERROR, mp3EncodeError);
	//_mp3Encoder.addEventListener(ProgressEvent.PROGRESS, mp3EncodeProgress);
	_mp3Encoder.start();
}

function mp3EncodeProgress(event:ProgressEvent):void
{
	
	trace("\n" + event.bytesLoaded + " : " + event.bytesTotal);
}

function mp3EncodeError(event:ErrorEvent):void
{
	
	trace("\nError : " + event.text);
}

function mp3EncodeComplete(e:Event):void
{
	_mp3Data = _mp3Encoder.mp3Data;
	var swf:ByteArray = createSWFFromMP3(_mp3Data);
	var loader:Loader = new Loader();
	loader.contentLoaderInfo.addEventListener(Event.INIT, initHandler);
	loader.loadBytes(swf);
	
	
}

function initHandler(e:Event):void
{
	// Get the sound class definition
	var SoundClass:Class = LoaderInfo(e.currentTarget).applicationDomain.getDefinition("MP3Wrapper_soundClass") as Class;
	// Instantiate the sound class
	var usound:Sound = new SoundClass() as Sound;
	// Play the sound
	//sound.play();
	
	userSpectr = new Spectr(_controls.userWaveform.width,_controls.userWaveform.height,usound);
	_controls.userWaveform.addChild(userSpectr);
	_controls.recordBtn.addEventListener(MouseEvent.CLICK, recordClick);
}

function playClick(e:MouseEvent):void
{
	_soundRecorder.addEventListener(Event.COMPLETE, soundRecorderPlayComplete);
	_soundRecorder.playRecording();
}

function soundRecorderPlayComplete(e:Event):void
{
	
}