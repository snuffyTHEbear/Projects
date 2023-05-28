package
{
	/*
	[TODO] - Use standard Colours for objects - metals - metal colours, ramps wood colours or standard colours editable at runtime
	Only thing to code logic for is loading parsing the models and layouts
	*/
	import flash.display.Sprite;
	
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	
	import view.Base;
	import view.BasicPrimitive;
	
	[SWF(width=640, height=480)]
	public class CoteHeath extends Sprite
	{
		[Embed(source="models/mat.jpg", mimeType="image/jpeg")]
		private var _mat:Class;
		
		private var _view:Base;
		private var _tube:BasicPrimitive;
		
		public function CoteHeath()
		{
			_view = new Base(stage.stageWidth, stage.stageHeight, true, true, "Target");
			addChild(_view);
			
			_tube = new BasicPrimitive("models/Tube_Optimized.DAE", new MaterialsList({all:new ColorMaterial()}));
			_tube.scale = 5.0;
			_view.addModel(_tube);
			_view.renderCallback = loop;
		}
		private function loop():void
		{
			_tube.rotationX += (stage.mouseY - stage.stageWidth * 0.5) * 0.01;
			_tube.rotationY += (stage.mouseX - stage.stageHeight * 0.5) * 0.01;
		}
	}
}