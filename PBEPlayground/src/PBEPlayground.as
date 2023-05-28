package
{
	import com.pblabs.engine.core.Global;
	import com.pblabs.engine.core.NameManager;
	import com.pblabs.engine.core.ObjectType;
	import com.pblabs.engine.entity.IEntity;
	import com.pblabs.engine.entity.PropertyReference;
	import com.pblabs.engine.entity.allocateEntity;
	import com.pblabs.rendering2D.BasicSpatialManager2D;
	import com.pblabs.rendering2D.ISpatialManager2D;
	import com.pblabs.rendering2D.Scene2DComponent;
	import com.pblabs.rendering2D.SimpleSpatialComponent;
	import com.pblabs.rendering2D.SpriteRenderComponent;
	import com.pblabs.rendering2D.ui.SceneView;
	
	import components.HeroControllerComponent;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	[SWF(width=800, height=600, frameRate=60)]
	public class PBEPlayground extends Sprite
	{
		//[Embed(source="assets/fanship.png")]
		//private var _shipClass:Class;
		
		public function PBEPlayground()
		{
			Global.startup(this);
			
			createScene();
			
			createHero();
		}
		private function createScene():void
		{
			var scene:IEntity = allocateEntity();
			scene.initialize("scene");
			
			var spatial:BasicSpatialManager2D = new BasicSpatialManager2D();
			scene.addComponent(spatial, "spatial");
			
			var renderer:Scene2DComponent = new Scene2DComponent();
			renderer.spatialDatabase = spatial;
			
			var view:SceneView = new SceneView();
			view.width = stage.stageWidth;
			view.height = stage.stageHeight;
			renderer.sceneView = view;
			
			renderer.position = new Point();
			
			renderer.renderMask = new ObjectType("Renderable");
			
			scene.addComponent(renderer, "renderer");
		}
		private function createHero():void
		{
			var hero:IEntity = allocateEntity();
			hero.initialize("hero");
			
			createSpatial(hero, new Point(0, 0));//, new Point(60, 53));
			
			var render:SpriteRenderComponent = new SpriteRenderComponent();
			render.loadFromImage = "assets/fanship.png";
			render.layerIndex = 10;
			render.positionReference = new PropertyReference("@spatial.position");
			render.sizeReference = new PropertyReference("@spatial.size");
			
			hero.addComponent(render, "render");
			
			var controller:HeroControllerComponent = new HeroControllerComponent();
			controller.positionReference = new PropertyReference("@spatial.position");
			hero.addComponent(controller, "controller");
		}
		
		private function createBackground():void
		{
			var bg:IEntity = allocateEntity();
			bg.initialize("bg");
			
			createSpatial(bg, new Point());
		}	
		
		private function createSpatial(entity:IEntity, position:Point, size:Point = null):void
		{
			var spatial:SimpleSpatialComponent = new SimpleSpatialComponent();
			
			spatial.spatialManager = NameManager.instance.lookupComponentByName("scene", "spatial") as ISpatialManager2D;
			
			spatial.objectMask = new ObjectType("renderable");
			
			spatial.position = position;
			
			if(size != null)
			{
				spatial.size = size;
			}
			
			entity.addComponent(spatial, "spatial");
		}
	}
}