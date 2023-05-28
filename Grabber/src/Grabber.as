package
{
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.events.NativeProcessExitEvent;
	import flash.filesystem.File;
	import flash.system.Capabilities;
	
	public class Grabber extends Sprite
	{
		private var stageCover:Sprite;
		private var captureRect:Sprite;
		private var sx:Number;
		private var sy:Number;
		
		private var np:NativeProcess;
		private var npi:NativeProcessStartupInfo;
		
		public function Grabber()
		{
			super();
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			stageCover = new Sprite();
			stageCover.graphics.beginFill(0xFFFFFF, 0.01);
			stageCover.graphics.drawRect(0, 0, Capabilities.screenResolutionX, Capabilities.screenResolutionY);
			addChild(stageCover);
			
			stageCover.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			captureRect = new Sprite();
			captureRect.graphics.lineStyle(2, 0xcc0000);
			addChild(captureRect);
			
			np = new NativeProcess();
			npi = new NativeProcessStartupInfo();
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			sx = mouseX;
			sy = mouseY;
			stageCover.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		
		private function onMouseUp(e:MouseEvent):void
		{
			captureRect.graphics.clear();
			stageCover.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			var args:Vector.<String> = new Vector.<String>();
			args.push("-l");
			
			if(sx < mouseX)
				args.push(sx.toString());
			else
				args.push(mouseX.toString());
			
			args.push("-t");
			
			if(sy < mouseY)
				args.push(sy.toString());
			else
				args.push(mouseY.toString());
			
			args.push("-r");
			
			if(mouseX > sx)
				args.push(mouseX.toString());
			else
				args.push(sx.toString());
			
			args.push("-b");
			
			if(mouseY > sy)
				args.push(mouseY.toString());
			else
				args.push(sy.toString());
			
			args.push("-out");
			args.push(File.desktopDirectory.nativePath + "/grab.png");
			npi.arguments = args;
			npi.executable = File.applicationDirectory.resolvePath("Grabber.exe");
			np.addEventListener(NativeProcessExitEvent.EXIT, onExit);
			np.start(npi);
		}
		
		private function onExit(e:NativeProcessExitEvent):void
		{
			stage.nativeWindow.close();
		}
		
		private function onMouseMove(e:MouseEvent):void
		{
			captureRect.graphics.clear();
			captureRect.graphics.lineStyle(2, 0xcc0000);
			captureRect.graphics.drawRect(sx, sy, mouseX - sx, mouseY - sy);
			e.updateAfterEvent();
		}
	}
}