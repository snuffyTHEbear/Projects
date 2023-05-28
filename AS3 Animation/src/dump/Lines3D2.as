package{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import robDaniels.greenFlames.src.graphics.Point3D;
	import robDaniels.greenFlames.src.graphics.Triangle;
	
	public class Lines3D2 extends Sprite{
		
		private var points:Array;
		private var triangles:Array;
		private var numPoints:uint = 15;
		private var fl:Number = 250;
		private var vpX:Number = stage.stageWidth / 2;
		private var vpY:Number = stage.stageHeight / 2;
		private var _color:uint;
		
		public function Lines3D2(){
			init();
		}
		private function init():void{
			points = new Array();
			for(var i:uint = 0; i< numPoints;i++)
			{			
				var point:Point3D = 
				new Point3D(Math.random()*200-100,
							Math.random()*200-100,
							Math.random()*200-100);
				point.setVanishingPoint(vpX, vpY);
				points.push(point);
			}
			points[0] = new Point3D(50,-250, 100);
			points[1] = new Point3D(50, 150, 100);
			points[2] = new Point3D(150, 150, 100);
			points[3] = new Point3D(150, 220, 100);
			points[4] = new Point3D(120, 250, 100);
			points[5] = new Point3D(-150, 250, 100);
			points[6] = new Point3D(-150, 190, 100);
			points[7] = new Point3D(-110, 150, 100);
			points[8] = new Point3D(-50, 150, 100);
			points[9] = new Point3D(-50, -150, 100);
			points[10] = new Point3D(-90, -150, 100);
			points[11] = new Point3D(-130, -120, 100);
			points[12] = new Point3D(-150, -120, 100);
			points[13] = new Point3D(-150, -220, 100);
			points[14] = new Point3D(-120, -250, 100);
			
			for(i = 0; i < numPoints; i ++)
			{
				points[i].setVanishingPoint(vpX, vpY);
				points[i].setCenter(0,0,200);
			}
			//triangles[] = new Triangle(points[], points[], _color);
			triangles = new Array();
			triangles[0] = new Triangle(points[0], points[1],points[9], 0x00ff00,1);
			triangles[1] = new Triangle(points[1], points[2], points[4], 0xff0000,1);
			triangles[2] = new Triangle(points[2], points[3], points[4], 0x0000ff,1);
			triangles[3] = new Triangle(points[1], points[4], points[5], 0xff6600,1);
			triangles[4] = new Triangle(points[5], points[6], points[7], 0x0066ff,1);
			triangles[5] = new Triangle(points[5], points[7], points[8], 0x66ff000,1);
			triangles[6] = new Triangle(points[1], points[5], points[8], 0xccff44,1);
			triangles[7] = new Triangle(points[1], points[8], points[9], 0x55cc33,1);
			triangles[8] = new Triangle(points[9], points[10], points[14], 0xff00ff,1);
			triangles[9] = new Triangle(points[10], points[11], points[14], 0x000000,1);
			triangles[10] = new Triangle(points[11], points[12], points[14], 0xcccccc,1);
			triangles[11] = new Triangle(points[12], points[13], points[14], 0xffff00,1);
			triangles[12] = new Triangle(points[9], points[14], points[0], 0x00ffff,1);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:Event):void
		{
			var angleX:Number = (mouseY - vpY) * .001;
			var angleY:Number = (mouseX - vpX) * .001;
			for(var i:uint = 0;i<numPoints;i++)
			{
				var point:Point3D = points[i];
				point.rotateX(angleX);
				point.rotateY(angleY);
			}
			graphics.clear();
			for(i = 0;i<triangles.length;i++)
			{
				triangles[i].draw(graphics);
			}
			graphics.lineStyle(1,0);
			graphics.beginFill(0xffcccc);
			graphics.moveTo(points[0].screenX, points[0].screenY);
			for(i = 1; i< numPoints; i++)
			{
				graphics.lineTo(points[i].screenX, points[i].screenY);
			}
			graphics.lineTo(points[0].screenX, points[0].screenY);
			graphics.endFill();
		}
	}
}