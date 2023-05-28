package
{
	import deng.fzip.FZip;
	import deng.fzip.FZipFile;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.text.TextField;

	public class Main extends Sprite
	{
		private var zip:FZip;
		private var tf:TextField;
		private var index:uint = 0;
		private var count:uint = 0;
		private var done:Boolean = false;
		
		public function Main() {
			// lets not scale
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			// status text
			tf = new TextField();
			tf.height = 20;
			tf.width = 576;
			addChild(tf);
			// load zip
			zip = new FZip();
			zip.addEventListener(Event.OPEN, onOpen);
			zip.addEventListener(Event.COMPLETE, onComplete);
			zip.load(new URLRequest("C:/Users/Rob/Desktop/test.zip"));
		}
		
		private function onOpen(evt:Event):void {
			trace("evt");
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onComplete(evt:Event):void {
			trace("evt2");
			done = true;
		}
		
		private function onEnterFrame(evt:Event):void {
			// we only want to add 32 images at once to the display list
			// to save a bit of processor load when zip is cached
			for(var i:uint = 0; i < 32; i++) {
				// any new files available?
				if(zip.getFileCount() > index) {
					// yeah, get it
					var file:FZipFile = zip.getFileAt(index);
					// is this a png in the icons folder?
					if(file.filename.toLowerCase().indexOf(".jpg") != -1) {
						// yeah, display it
						var loader:Loader = new Loader();
						loader.loadBytes(file.content);
						loader.x = 18 * (count % 32);
						loader.y = 18 * Math.floor(count / 32) + 20;
						addChild(loader);
						count++;
					}
					index++;
				} else {
					// no new files available
					// check if we're done
					if(done) {
						removeEventListener(Event.ENTER_FRAME, onEnterFrame);
					}
					// and exit the loop
					break;
				}
			}
			// display load status
			tf.text = count + " files loaded";
		}
	}
}
