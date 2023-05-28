package
{
	import com.arcticcode.greenFlames.sound.recorder.SoundRecorder;
	import com.arcticcode.greenFlames.system.SystemUtils;
	import com.arcticcode.greenFlames.xPreloader.XPreloader;
	import com.codeazur.as3swf.SWF;
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFScene;
	import com.codeazur.as3swf.data.SWFSymbol;
	import com.codeazur.as3swf.tags.TagDefineSceneAndFrameLabelData;
	import com.codeazur.as3swf.tags.TagDefineSound;
	import com.codeazur.as3swf.tags.TagDoABC;
	import com.codeazur.as3swf.tags.TagEnd;
	import com.codeazur.as3swf.tags.TagFileAttributes;
	import com.codeazur.as3swf.tags.TagSetBackgroundColor;
	import com.codeazur.as3swf.tags.TagShowFrame;
	import com.codeazur.as3swf.tags.TagSymbolClass;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import fr.kikko.lab.ShineMP3Encoder;
	
	import org.bytearray.micrecorder.encoder.WaveEncoder;

	public class WaveformRecorderCore extends Sprite
	{
		public const CONTROLS_ONLINE:String = "controlsOnline";
		public const CONTROLS_OFFLINE:String = "controlsOffline";
		public var controlsType:String;

		private var soundLoader:XPreloader;

		private var _onlineControls:WaveformRecordingControls2;
		private var _offlineControls:WaveformRecordingControls;
		private var _controls:MovieClip;

		private var _modelSoundString:String;
		private var _path:String = "";
		public var context:LoaderContext = new LoaderContext();
		private var modelSound:Sound;
		private var userSound:Sound;

		private var modelSpectr:Spectr;
		private var userSpectr:Spectr;

		private var _initialized:Boolean = false;

		private var _soundRecorder:SoundRecorder = new SoundRecorder();
		private var _wavEncoder:WaveEncoder = new WaveEncoder(2);
		private var _mp3Encoder:ShineMP3Encoder;
		private var _wavData:ByteArray;
		private var _mp3Data:ByteArray;

		private var _soundChannel:SoundChannel;
		
		private var _folder:String = "waveform_audio";

		//Add check if recorded sound is available for when setting controls

		public function WaveformRecorderCore()
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}

		public function get initialized():Boolean
		{
			return _initialized;
		}

		public function set initialized( value:Boolean ):void
		{
			_initialized = value;
		}

		public function get modelSoundString():String
		{
			return _modelSoundString;
		}

		public function set modelSoundString( value:String):void
		{
			_modelSoundString = value;
			if(_path.charAt(_path.length - 1) != "/")
			{
				if(controlsType == CONTROLS_OFFLINE)
				{
					_folder = "waveform_audio";
				}
			}
			trace(_path + "\n" + _folder + "\n" + _modelSoundString);
			trace("\n" + _path + _folder + "/" + _modelSoundString + ".mp3");
			modelSound = new Sound( new URLRequest( _path + _folder + "/" + _modelSoundString + ".mp3" ));
			modelSound.addEventListener( Event.COMPLETE, modelSoundLoaded );
		}

		public function get controls():MovieClip
		{
			return _controls;
		}

		public function get dragger():MovieClip
		{
			return WaveformRecordingControls2( _controls ).dragger;
		}

		private function init( e:Event ):void
		{
			removeEventListener( e.type, init );
			controlsType = SystemUtils.inAIR() ? CONTROLS_OFFLINE : CONTROLS_ONLINE;

			if ( controlsType == CONTROLS_ONLINE )
			{
				folder = "waveform_audio";
				_onlineControls = new WaveformRecordingControls2();
				addChild( _onlineControls );

				_controls = _onlineControls;

				_controls.closeBtn.addEventListener( MouseEvent.CLICK, close );
			}
			else if ( controlsType == CONTROLS_OFFLINE )
			{
				folder = "waveform_audio";
				_offlineControls = new WaveformRecordingControls();
				addChild( _offlineControls );
				_offlineControls.x = stage.stageWidth * 0.5;
				_offlineControls.y = stage.stageHeight * 0.5;
				_controls = _offlineControls;
			}
			
			setControls( false, false, false, false, false );
			_initialized = true;

		}

		private function close( e:MouseEvent ):void
		{
			removeAllListeners();
			this.dispatchEvent( new Event( Event.CLOSE ));
			removeChild( _controls );
			addEventListener( Event.ADDED_TO_STAGE, init );
			_initialized = false;
		}

		/**
		 * Enables / Disables controls
		 * @param mPlayBtn - Model Play Button
		 * @param mStopBtn - Model Stop Button
		 * @param uPlayBtn - User Play Button
		 * @param uStopBtn - User Stop Button
		 * @param uRecordBtn - User Record Button
		 *
		 */
		private function setControls( mPlayBtn:Boolean, mStopBtn:Boolean, uPlayBtn:Boolean, uStopBtn:Boolean, uRecordBtn:Boolean ):void
		{
			setButtonState( _controls.playModelBtn, mPlayBtn );
			setButtonState( _controls.stopModelBtn, mStopBtn );
			setButtonState( _controls.playUserBtn, uPlayBtn );
			setButtonState( _controls.stopUserBtn, uStopBtn );
			setButtonState( _controls.recordBtn, uRecordBtn );
		}

		private function setButtonState( btn:SimpleButton, state:Boolean ):void
		{
			btn.alpha = state ? 1 : 0.75;
			btn.enabled = state;
		}

		private function modelSoundLoaded( e:Event ):void
		{
			modelSpectr = new Spectr( _controls.modelWaveform.width, _controls.modelWaveform.height, modelSound, true );
			modelSpectr.addEventListener( Event.COMPLETE, modelWaveformComplete );
			_controls.modelWaveform.addChild( modelSpectr );

			setControls( true, false, false, false, true );

			_controls.swapChildren( _controls.playModelBtn, _controls.modelWaveform );

			_controls.playModelBtn.addEventListener( MouseEvent.CLICK, playModelSound );
			_controls.recordBtn.addEventListener( MouseEvent.CLICK, recordClick );
		}

		private function playModelSound( e:MouseEvent ):void
		{
			setControls( false, true, false, false, false );

			_soundChannel = modelSound.play();
			_soundChannel.addEventListener( Event.SOUND_COMPLETE, modelSoundPlaybackComplete );
		}

		private function modelSoundPlaybackComplete( e:Event ):void
		{
			_soundChannel.removeEventListener( e.type, arguments.callee );
			setControls( true, false, _soundRecorder.hasRecording, false, true );
		}

		private function modelWaveformComplete( e:Event ):void
		{
			modelSpectr.removeEventListener( Event.COMPLETE, modelWaveformComplete );
		}

		private function soundBLoaded( e:Event ):void
		{
			userSpectr = new Spectr( _controls.userWaveform.width, _controls.userWaveform.height, userSound );
			_controls.userWaveform.addChild( userSpectr );
			_controls.userWaveform.buttonMode = true;
			_controls.userWaveform.addEventListener( MouseEvent.MOUSE_DOWN, waveformMouseDown );
		}

		private function waveformMouseDown( e:MouseEvent ):void
		{
			_controls.userWaveform.addEventListener( MouseEvent.MOUSE_MOVE, waveformMouseMove );
		}

		private function waveformMouseMove( e:MouseEvent ):void
		{
			_controls.userWaveform.x = _controls.mouseX;
			e.updateAfterEvent();
		}

		private function recordClick( e:MouseEvent ):void
		{

			if ( _soundRecorder.hasRecording )
			{
				if ( userSpectr )
				{
					if ( userSpectr.parent == _controls.userWaveform )
					{
						_controls.userWaveform.removeChild( userSpectr );
						_wavData.clear();
						_mp3Data.clear();
					}
				}
				_soundRecorder.reset();
			}
			_soundRecorder.startRecording();
			setControls( false, false, false, true, false );
			_controls.stopUserBtn.addEventListener( MouseEvent.CLICK, stopUserClick );
			_controls.recordBtn.removeEventListener( MouseEvent.CLICK, recordClick );
		}

		public function removeAllListeners():void
		{
			if(!_controls)
				return;
			
			_controls.recordBtn.removeEventListener( MouseEvent.CLICK, recordClick );
			_controls.stopUserBtn.removeEventListener( MouseEvent.CLICK, stopUserClick );
			_controls.playUserBtn.removeEventListener( MouseEvent.CLICK, playClick );
			_controls.userWaveform.removeEventListener( MouseEvent.MOUSE_DOWN, waveformMouseDown );
			_controls.playModelBtn.removeEventListener( MouseEvent.CLICK, playModelSound );
			if(controlsType == CONTROLS_ONLINE)
				_controls.closeBtn.removeEventListener( MouseEvent.CLICK, close );
		}

		private function stopUserClick( e:MouseEvent ):void
		{
			_controls.stopUserBtn.removeEventListener( MouseEvent.CLICK, stopUserClick );
			_soundRecorder.stopRecording();
			_wavData = _wavEncoder.encode( _soundRecorder.soundData );
			
			_mp3Encoder = new ShineMP3Encoder( _wavData );
			_mp3Encoder.addEventListener( Event.COMPLETE, mp3EncodeComplete );
			_mp3Encoder.addEventListener( ErrorEvent.ERROR, mp3EncodeError );
			//_mp3Encoder.addEventListener(ProgressEvent.PROGRESS, mp3EncodeProgress);
			_mp3Encoder.start();
		}

		private function mp3EncodeProgress( event:ProgressEvent ):void
		{

			trace( "\n" + event.bytesLoaded + " : " + event.bytesTotal );
		}

		private function mp3EncodeError( event:ErrorEvent ):void
		{

			trace( "\nError : " + event.text );
		}

		private function mp3EncodeComplete( e:Event ):void
		{
			_mp3Data = _mp3Encoder.mp3Data;
			if ( _mp3Data.length > 0 )
			{
				var swf:ByteArray = createSWFFromMP3( _mp3Data );
				var loader:Loader = new Loader();
				
				loader.contentLoaderInfo.addEventListener( Event.INIT, initHandler );
				loader.loadBytes( swf, context );
			}
			else
			{
				setControls( true, false, false, false, true );
				//throw new Error( "Error encoding mp3 data, length is equal to zero" );
			}
		}

		private function initHandler( e:Event ):void
		{
			// Get the sound class definition
			var SoundClass:Class = LoaderInfo( e.currentTarget ).applicationDomain.getDefinition( "MP3Wrapper_soundClass" ) as Class;
			// Instantiate the sound class
			var usound:Sound = new SoundClass() as Sound;
			// Play the sound
			//sound.play();
			
			userSpectr = new Spectr( _controls.userWaveform.width, _controls.userWaveform.height, usound );
			_controls.userWaveform.addChild( userSpectr );
			_controls.swapChildren( _controls.playUserBtn, _controls.userWaveform );
			setControls( true, false, _soundRecorder.hasRecording, false, true );
			_controls.recordBtn.addEventListener( MouseEvent.CLICK, recordClick );
			_controls.playUserBtn.addEventListener( MouseEvent.CLICK, playClick );
		}

		private function playClick( e:MouseEvent ):void
		{
			_soundRecorder.addEventListener( Event.COMPLETE, soundRecorderPlayComplete );
			_soundRecorder.playRecording();
			setControls( false, false, false, true, false );
		}

		private function soundRecorderPlayComplete( e:Event ):void
		{
			_soundRecorder.removeEventListener( Event.COMPLETE, soundRecorderPlayComplete );
			setControls( true, false, _soundRecorder.hasRecording, false, true );
		}

		public function reset( modelSound:String ):void
		{
			if ( modelSound == modelSoundString )
			{
				//return;
			}
			removeAllListeners();
			setControls( false, false, false, false, false );
			if(userSpectr != null)
			{
				if ( userSpectr.parent == _controls.userWaveform )
				{
					_controls.userWaveform.removeChild( userSpectr );
				}
			}
			_controls.modelWaveform.removeChild( modelSpectr );
			if(_soundRecorder != null && _soundRecorder.hasRecording)
			{
				_soundRecorder.reset();
			}
			modelSoundString = modelSound;
			
			if(controlsType == CONTROLS_ONLINE)
				_controls.closeBtn.addEventListener( MouseEvent.CLICK, close );
		}

		protected function createSWFFromMP3( mp3:ByteArray ):ByteArray
		{
			// Create an empty SWF
			// Defaults to v10, 550x400px, 50fps, one frame (works fine for us)
			var swf:SWF = new SWF();

			// Add FileAttributes tag
			// Defaults: as3 true, all other flags false (works fine for us)
			swf.tags.push( new TagFileAttributes());

			// Add SetBackgroundColor tag
			// Default: white background (works fine for us)
			swf.tags.push( new TagSetBackgroundColor());

			// Add DefineSceneAndFrameLabelData tag 
			// (with the only entry being "Scene 1" at offset 0)
			var defineSceneAndFrameLabelData:TagDefineSceneAndFrameLabelData = new TagDefineSceneAndFrameLabelData();
			defineSceneAndFrameLabelData.scenes.push( new SWFScene( 0, "Scene 1" ));
			swf.tags.push( defineSceneAndFrameLabelData );

			// Add DefineSound tag
			// The ID is 1, all other parameters are automatically
			// determined from the mp3 itself.
			swf.tags.push( TagDefineSound.createWithMP3( 1, mp3 ));

			// Add DoABC tag
			// Contains the AS3 byte code for the document class and the 
			// class definition for the embedded sound
			swf.tags.push( TagDoABC.create( abc ));

			// Add SymbolClass tag
			// Specifies the document class and binds the sound class
			// definition to the embedded sound
			var symbolClass:TagSymbolClass = new TagSymbolClass();
			symbolClass.symbols.push( SWFSymbol.create( 1, "MP3Wrapper_soundClass" ));
			symbolClass.symbols.push( SWFSymbol.create( 0, "MP3Wrapper" ));
			swf.tags.push( symbolClass );

			// Add ShowFrame tag
			swf.tags.push( new TagShowFrame());

			// Add End tag
			swf.tags.push( new TagEnd());

			// Publish the SWF
			var swfData:SWFData = new SWFData();
			swf.publish( swfData );

			return swfData;
		}

		private static var abcData:Array = [ 0x10, 0x00, 0x2e, 0x00, 0x00, 0x00, 0x00, 0x19, 0x07, 0x6d, 0x78, 0x2e, 0x63, 0x6f, 0x72, 0x65, 0x0a, 0x49, 0x46, 0x6c, 0x65, 0x78, 0x41, 0x73, 0x73, 0x65, 0x74, 0x0a, 0x53, 0x6f, 0x75, 0x6e, 0x64, 0x41, 0x73, 0x73, 0x65, 0x74, 0x0b, 0x66, 0x6c, 0x61, 0x73, 0x68, 0x2e, 0x6d, 0x65, 0x64, 0x69, 0x61, 0x05, 0x53, 0x6f, 0x75, 0x6e, 0x64, 0x12, 0x6d, 0x78, 0x2e, 0x63, 0x6f, 0x72, 0x65, 0x3a, 0x53, 0x6f, 0x75, 0x6e, 0x64, 0x41, 0x73, 0x73, 0x65, 0x74, 0x00, 0x15, 0x4d, 0x50, 0x33, 0x57, 0x72, 0x61, 0x70, 0x70, 0x65, 0x72, 0x5f, 0x73, 0x6f, 0x75, 0x6e, 0x64, 0x43, 0x6c, 0x61, 0x73, 0x73, 0x0a, 0x4d, 0x50, 0x33, 0x57, 0x72, 0x61, 0x70, 0x70, 0x65, 0x72, 0x0d, 0x66, 0x6c, 0x61, 0x73, 0x68, 0x2e, 0x64, 0x69, 0x73, 0x70, 0x6c, 0x61, 0x79, 0x06, 0x53, 0x70, 0x72, 0x69, 0x74, 0x65, 0x0a, 0x73, 0x6f, 0x75, 0x6e, 0x64, 0x43, 0x6c, 0x61, 0x73, 0x73, 0x05, 0x43, 0x6c, 0x61, 0x73, 0x73, 0x2a, 0x68, 0x74, 0x74, 0x70, 0x3a, 0x2f, 0x2f, 0x77, 0x77, 0x77, 0x2e, 0x61, 0x64, 0x6f, 0x62, 0x65, 0x2e, 0x63, 0x6f, 0x6d, 0x2f, 0x32, 0x30, 0x30, 0x36, 0x2f, 0x66, 0x6c, 0x65, 0x78, 0x2f, 0x6d, 0x78, 0x2f, 0x69, 0x6e, 0x74, 0x65, 0x72, 0x6e, 0x61, 0x6c, 0x07, 0x56, 0x45, 0x52, 0x53, 0x49, 0x4f, 0x4e, 0x06, 0x53, 0x74, 0x72, 0x69, 0x6e, 0x67, 0x07, 0x33, 0x2e, 0x30, 0x2e, 0x30, 0x2e, 0x30, 0x0b, 0x6d, 0x78, 0x5f, 0x69, 0x6e, 0x74, 0x65, 0x72, 0x6e, 0x61, 0x6c, 0x06, 0x4f, 0x62, 0x6a, 0x65, 0x63, 0x74, 0x0c, 0x66, 0x6c, 0x61, 0x73, 0x68, 0x2e, 0x65, 0x76, 0x65, 0x6e, 0x74, 0x73, 0x0f, 0x45, 0x76, 0x65, 0x6e, 0x74, 0x44, 0x69, 0x73, 0x70, 0x61, 0x74, 0x63, 0x68, 0x65, 0x72, 0x0d, 0x44, 0x69, 0x73, 0x70, 0x6c, 0x61, 0x79, 0x4f, 0x62, 0x6a, 0x65, 0x63, 0x74, 0x11, 0x49, 0x6e, 0x74, 0x65, 0x72, 0x61, 0x63, 0x74, 0x69, 0x76, 0x65, 0x4f, 0x62, 0x6a, 0x65, 0x63, 0x74, 0x16, 0x44, 0x69, 0x73, 0x70, 0x6c, 0x61, 0x79, 0x4f, 0x62, 0x6a, 0x65, 0x63, 0x74, 0x43, 0x6f, 0x6e, 0x74, 0x61, 0x69, 0x6e, 0x65, 0x72, 0x0a, 0x16, 0x01, 0x16, 0x04, 0x18, 0x06, 0x16, 0x07, 0x18, 0x08, 0x16, 0x0a, 0x18, 0x09, 0x08, 0x0e, 0x16, 0x14, 0x03, 0x01, 0x01, 0x01, 0x04, 0x14, 0x07, 0x01, 0x02, 0x07, 0x01, 0x03, 0x07, 0x02, 0x05, 0x09, 0x02, 0x01, 0x07, 0x04, 0x08, 0x07, 0x04, 0x09, 0x07, 0x06, 0x0b, 0x07, 0x04, 0x0c, 0x07, 0x04, 0x0d, 0x07, 0x08, 0x0f, 0x07, 0x04, 0x10, 0x07, 0x01, 0x12, 0x09, 0x03, 0x01, 0x07, 0x04, 0x13, 0x07, 0x09, 0x15, 0x09, 0x08, 0x02, 0x07, 0x06, 0x16, 0x07, 0x06, 0x17, 0x07, 0x06, 0x18, 0x0d, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x01, 0x00, 0x05, 0x00, 0x02, 0x00, 0x02, 0x03, 0x09, 0x03, 0x01, 0x04, 0x05, 0x00, 0x05, 0x02, 0x09, 0x05, 0x00, 0x08, 0x00, 0x06, 0x07, 0x09, 0x07, 0x00, 0x0b, 0x01, 0x08, 0x00, 0x00, 0x09, 0x00, 0x01, 0x00, 0x04, 0x01, 0x0a, 0x06, 0x01, 0x0b, 0x11, 0x01, 0x07, 0x00, 0x0a, 0x00, 0x05, 0x00, 0x01, 0x0c, 0x06, 0x00, 0x00, 0x08, 0x08, 0x03, 0x01, 0x01, 0x04, 0x00, 0x00, 0x06, 0x01, 0x02, 0x04, 0x00, 0x01, 0x09, 0x01, 0x05, 0x04, 0x00, 0x02, 0x0c, 0x01, 0x06, 0x04, 0x01, 0x03, 0x0c, 0x00, 0x01, 0x01, 0x01, 0x02, 0x03, 0xd0, 0x30, 0x47, 0x00, 0x00, 0x01, 0x00, 0x01, 0x03, 0x03, 0x01, 0x47, 0x00, 0x00, 0x03, 0x02, 0x01, 0x01, 0x02, 0x0a, 0xd0, 0x30, 0x5d, 0x04, 0x20, 0x58, 0x00, 0x68, 0x01, 0x47, 0x00, 0x00, 0x04, 0x02, 0x01, 0x05, 0x06, 0x09, 0xd0, 0x30, 0x5e, 0x0a, 0x2c, 0x11, 0x68, 0x0a, 0x47, 0x00, 0x00, 0x05, 0x01, 0x01, 0x06, 0x07, 0x06, 0xd0, 0x30, 0xd0, 0x49, 0x00, 0x47, 0x00, 0x00, 0x06, 0x02, 0x01, 0x01, 0x05, 0x17, 0xd0, 0x30, 0x5d, 0x0d, 0x60, 0x0e, 0x30, 0x60, 0x0f, 0x30, 0x60, 0x03, 0x30, 0x60, 0x03, 0x58, 0x01, 0x1d, 0x1d, 0x1d, 0x68, 0x02, 0x47, 0x00, 0x00, 0x07, 0x01, 0x01, 0x06, 0x07, 0x03, 0xd0, 0x30, 0x47, 0x00, 0x00, 0x08, 0x01, 0x01, 0x07, 0x08, 0x06, 0xd0, 0x30, 0xd0, 0x49, 0x00, 0x47, 0x00, 0x00, 0x09, 0x02, 0x01, 0x01, 0x06, 0x1b, 0xd0, 0x30, 0x5d, 0x10, 0x60, 0x0e, 0x30, 0x60, 0x0f, 0x30, 0x60, 0x03, 0x30, 0x60, 0x02, 0x30, 0x60, 0x02, 0x58, 0x02, 0x1d, 0x1d, 0x1d, 0x1d, 0x68, 0x05, 0x47, 0x00, 0x00, 0x0a, 0x01, 0x01, 0x08, 0x09, 0x03, 0xd0, 0x30, 0x47, 0x00, 0x00, 0x0b, 0x02, 0x01, 0x09, 0x0a, 0x0b, 0xd0, 0x30, 0xd0, 0x60, 0x05, 0x68, 0x08, 0xd0, 0x49, 0x00, 0x47, 0x00, 0x00, 0x0c, 0x02, 0x01, 0x01, 0x08, 0x23, 0xd0, 0x30, 0x65, 0x00, 0x60, 0x0e, 0x30, 0x60, 0x0f, 0x30, 0x60, 0x11, 0x30, 0x60, 0x12, 0x30, 0x60, 0x13, 0x30, 0x60, 0x07, 0x30, 0x60, 0x07, 0x58, 0x03, 0x1d, 0x1d, 0x1d, 0x1d, 0x1d, 0x1d, 0x68, 0x06, 0x47, 0x00, 0x00 ];

		private static function abcDataToByteArray():ByteArray
		{
			var ba:ByteArray = new ByteArray();
			for ( var i:uint = 0; i < abcData.length; i++ )
			{
				ba.writeByte( abcData[ i ]);
			}
			return ba;
		}

		public function get folder():String
		{
			return _folder;
		}

		public function set folder(value:String):void
		{
			_folder = value;
		}

		public function set path(value:String):void
		{
			_path = value;
		}


		private static var abc:ByteArray = abcDataToByteArray();
	}
}