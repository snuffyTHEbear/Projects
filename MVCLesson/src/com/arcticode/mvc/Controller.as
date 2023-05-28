package com.arcticode.mvc
{
	/**
	 * 
	 * @author Rob
	 *
	 * Controller decides how application responds to user input
	 * take input from View and pass to Model or just update View 
	 */
	 	
	public class Controller
	{
		private var model:Model;
		
		public function Controller(model:Model)
		{
			this.model = model;
		}
		public function saveTextForModel(textForModel:String):void
		{
			model.saveText(textForModel);
		}
	}
}