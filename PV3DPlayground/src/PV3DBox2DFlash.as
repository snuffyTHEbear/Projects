package
{
	import flash.events.Event;
	
	import org.box2dflash.collision.AABB;
	import org.box2dflash.collision.shapes.CircleDef;
	import org.box2dflash.collision.shapes.PolygonDef;
	import org.box2dflash.common.math.Vec2;
	import org.box2dflash.dynamics.Body;
	import org.box2dflash.dynamics.BodyDef;
	import org.box2dflash.dynamics.World;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Sphere;
	import org.papervision3d.view.BasicView;
	
	[SWF(width=640,height=480,backgroundColor=0x000000, frameRate=24)]
	public class PV3DBox2DFlash extends BasicView
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;
		private var WORLD_SCALE:Number = 30;
		private var WIDTH:Number = 640;
		private var HEIGHT:Number = 480;
		private var world:World;
		private var iterations:int = 10;
		private var timeStep:Number = 1.0 / 30.0;	
		
		public function PV3DBox2DFlash()
		{
			super(640, 480, true, true);
			init();
		}
		private function createWorld():void
		{
			var worldBounds:AABB = new AABB();
			worldBounds.lowerBound = new Vec2(0,0);
			worldBounds.upperBound = new Vec2(WIDTH/WORLD_SCALE,HEIGHT/WORLD_SCALE);
			
			var gravity:Vec2 = new Vec2(0,10);
			var sleep:Boolean = true;
			
			world = new World(worldBounds, gravity, sleep);
		}
		private function createFloor():void
		{
			var floorShapeDef:PolygonDef = new PolygonDef();
			var floorBodyDef:BodyDef = new BodyDef();
			var floor:Body;
			
			floorShapeDef.setAsBox((WIDTH+40) / WORLD_SCALE/2, 100/WORLD_SCALE);
			
			floorBodyDef.position = new Vec2(WIDTH/WORLD_SCALE/2, (HEIGHT+95)/WORLD_SCALE);
			floor = world.createBody(floorBodyDef);
			floor.createShape(floorShapeDef);
			
			floor.setMassFromShapes();
		}
		private function createShapes():void
		{
			for(var i:uint = 0;i < 20; i++)
			{
				var radius:Number = Math.random() * 20 + 5;
				
				var bodyDef:BodyDef = new BodyDef();
				bodyDef.position = new Vec2(Math.random() * WIDTH / WORLD_SCALE, Math.random() * 50 / WORLD_SCALE);
				
				var body:Body = world.createBody(bodyDef);
				var shapeDef:CircleDef = new CircleDef();
				shapeDef.radius = radius / WORLD_SCALE;
				shapeDef.density = 1;
				shapeDef.friction = 0.7;
				shapeDef.restitution = 0.7;
				body.createShape(shapeDef);
				body.setMassFromShapes();
				
				var sphere:Sphere = new Sphere(null, radius);
				
				scene.addChild(sphere);
				body.userData = sphere;
			}
		}
		private function init():void
		{
			camera.focus = 10;
			camera.zoom = 100;
			
			createWorld();
			createFloor();
			createShapes();
			
			addEventListener(Event.ENTER_FRAME, onRenderTick);
		}
		override protected function onRenderTick(event:Event=null):void
		{
			world.step(timeStep, iterations);
			
			for(var b:Body = world.bodyList; b; b = b.next)
			{
				if(b.userData is DisplayObject3D)
				{
					b.userData.x = b.position.x * WORLD_SCALE - WIDTH * .5;
					b.userData.y = -b.position.y * WORLD_SCALE + HEIGHT * .5;
					b.userData.rotationZ = -b.angle * (180 / Math.PI);
				}
			}
			
			super.onRenderTick(event);
		}
	}
}