package dump
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import robDaniels.greenFlames.src.graphics.Light;
	import robDaniels.greenFlames.src.graphics.Point3D;
	import robDaniels.greenFlames.src.graphics.Triangle;
	
	public class Cube extends Sprite
	{
		
		private var points:Array;
		
		private var triangles:Array;
		
		private var numPoints:uint = 8;
		
		private var fl:Number = 250;
		
		private var vpX:Number = stage.stageWidth / 2;
		
		private var vpY:Number = stage.stageHeight / 2;
		
		private var _color:uint;
		
		private var offsetX:Number = 0;
		
		private var offsetY:Number = 0;
		
		public function Cube()
		{
			init();
		}
		
		private function init():void
		{
			points = new Array();
			//front
			points[0] = new Point3D(-100, -100, -100);
			points[1] = new Point3D(100, -100, -100);
			points[2] = new Point3D(100, 100, -100);
			points[3] = new Point3D(-100, 100, -100);
			//back
			points[4] = new Point3D(-100, -100, 100);
			points[5] = new Point3D(100, -100, 100);
			points[6] = new Point3D(100, 100, 100);
			points[7] = new Point3D(-100, 100, 100);
			
			for(var i:uint = 0; i < numPoints; i++)
			{
				points[i].setVanishingPoint(vpX, vpY);
				points[i].setCenter(0, 0, 200);
			}
			//triangles[] = new Triangle(points[], points[], _color);
			triangles = new Array();
			//front
			triangles[0] = new Triangle(points[0], points[1], points[2], 0xff6600);
			triangles[1] = new Triangle(points[0], points[2], points[3], 0xff6600);
			//top
			triangles[2] = new Triangle(points[0], points[5], points[1], 0x66ff00);
			triangles[3] = new Triangle(points[0], points[4], points[5], 0x66ff00);
			//back
			triangles[4] = new Triangle(points[4], points[6], points[5], 0x0066ff);
			triangles[5] = new Triangle(points[4], points[7], points[6], 0x0066ff);
			//bottom
			triangles[6] = new Triangle(points[3], points[2], points[6], 0xf6f600);
			triangles[7] = new Triangle(points[3], points[6], points[7], 0xf6f600);
			//right
			triangles[8] = new Triangle(points[4], points[0], points[3], 0x000000);
			triangles[9] = new Triangle(points[4], points[3], points[7], 0x000000);
			//left
			triangles[10] = new Triangle(points[1], points[5], points[6], 0x000000);
			triangles[11] = new Triangle(points[1], points[6], points[2], 0x000000);
			
			var light:Light = new Light(0, 0, -100, 1);
			for(i = 0; i < triangles.length; i++)
			{
				triangles[i].light = light;
			}
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onEnterFrame(event:Event):void
		{
			var angleX:Number = (mouseY - vpY) * .001;
			var angleY:Number = (mouseX - vpX) * .001;
			for(var i:uint = 0; i < numPoints; i++)
			{
				var point:Point3D = points[i];
				point.rotateX(angleX);
				point.rotateY(angleY);
			}
			graphics.clear();
			for(i = 0; i < triangles.length; i++)
			{
				triangles[i].draw(graphics);
			}
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.LEFT:
					offsetX -= 5;
					break;
				
				case Keyboard.RIGHT:
					offsetX += 5;
					break;
				
				case Keyboard.UP:
					offsetY -= 5;
					break;
				
				case Keyboard.DOWN:
					offsetY += 5;
					break;
				
				default:
					break;
			}
			for(var i:Number = 0; i < points.length; i++)
			{
				//points[i].x += offsetX;
				//points[i].y += offsetY;
				points[i].setCenter(offsetX, offsetY, 200);
			}
		}
	}
}