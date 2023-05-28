package tests
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.arctic3d.display.Arctic3DScene;
	import org.arctic3d.geom.Point3D;
	
	public class PointsTests extends Arctic3DScene
	{
		private var _points:Vector.<Point3D>;
		private var _circles:Vector.<Sprite>;
		private var _numPoints:uint = 5;
		
		public function PointsTests(w:Number=640, h:Number=480)
		{
			super(w, h);
		}
		
		override protected function init(e:Event):void
		{
			_points = new Vector.<Point3D>();
			_circles = new Vector.<Sprite>();
			var i:uint;
			for(i=0;i<_numPoints;i++)
			{
				var s:Sprite = new Sprite();
				s.graphics.beginFill(Math.random() * 0xffffff);
				s.graphics.drawCircle(0,0,25);
				s.graphics.endFill();
				addChild(s);
				var p:Point3D = new Point3D(i * 50, 0, 0);
				p.setCenter(0, 0, 200);
				p.setVanishingPoint(vpX, vpY);
				_circles.push(s);
				_points.push(p);
			}
			
			startRendering();
		}
		
		override protected function onRenderTick(e:Event):void
		{
			var angleX:Number = (mouseY - vpY) * .001;
			var angleY:Number = (mouseX - vpX) * .001;
			for(var i:uint = 0 ; i < _numPoints; i++)
			{
				_points[i].rotateX(angleX);
				_points[i].rotateY(angleY);
			}
			
			super.onRenderTick(e);
		}
		
		override protected function render():void
		{
			pointRenderer.depthSort(_points);
			
			var i:uint;
			for(i=0;i<_numPoints;i++)
			{
				_circles[i].x = _points[i].screenX;
				_circles[i].y = _points[i].screenY;
				_circles[i].scaleX = _circles[i].scaleY = _points[i].scale;
			}
		}
	}
}