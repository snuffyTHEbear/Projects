package
{
	import flash.display.Sprite;
	import flash.media.Camera;
	import flash.media.Video;
	
	public class VideoTests extends Sprite
	{
		private var _video:Video;
		
		private var _camera:Camera;
		
		public function VideoTests()
		{
			_video = new Video();
			_video.x = stage.stageWidth * 0.5 - _video.width * 0.5;
			_video.y = stage.stageHeight * 0.5 - _video.height * 0.5;
			_camera = Camera.getCamera();
			_camera.setMode(_video.width, _video.height, stage.frameRate);
			_video.attachCamera(_camera);
			addChild(_video);
		}
	}
}