package view
{
	import org.papervision3d.events.FileLoadEvent;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.parsers.DAE;

	public class BasicPrimitive extends DisplayObject3D
	{
		private var _model:DAE;
		/**
		 *Used to hold a primitive object (Ramp, planter rail) 
		 * 
		 */		
		public function BasicPrimitive(model:String, materialList:MaterialsList = null)
		{
			_model = new DAE(false);
			_model.load(model, materialList);
			_model.addEventListener(FileLoadEvent.LOAD_COMPLETE, init);
		}
		private function init(e:FileLoadEvent):void
		{
			this.addChild(_model);
		}

		public function get model():DisplayObject3D
		{
			return _model;
		}
	}
}