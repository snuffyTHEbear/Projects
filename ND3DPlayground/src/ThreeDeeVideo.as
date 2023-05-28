package
{
	import de.nulldesign.nd3d.material.BitmapMaterial;
	import de.nulldesign.nd3d.objects.Plane;
	import de.nulldesign.nd3d.view.AbstractView;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.media.Camera;
	import flash.media.Video;
	
	[SWF(width=600,height=400,backgroundColor=0)]
	public class ThreeDeeVideo extends AbstractView
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;	
		private var video:Video = new Video(320,240);
		private var bmd:BitmapData = new BitmapData(video.width,video.height);
		private var plane:Plane;
		
		public function ThreeDeeVideo()
		{
			super(600, 400);
			init();
		}
		private function init():void
		{
			//addChild(video);
			video.smoothing = true;
			video.attachCamera(Camera.getCamera());	
			
			plane = new Plane(320,240,4,4,new BitmapMaterial(bmd,true,false,true,false));
			renderList.push(plane);
		}
		override protected function loop(e:Event):void
		{
			renderer.render(renderList, cam);
			plane.angleX -= (centreY-mouseY) * .0005;
			plane.angleY -= (centreX-mouseX) * .0005;
			bmd.draw(video);
		}
	}
}