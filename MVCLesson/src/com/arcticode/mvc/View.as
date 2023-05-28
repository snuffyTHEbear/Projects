package com.arcticode.mvc
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * 
	 * @author Rob
	 * View handles all user interaction, think GUI
	 */	

	public class View extends Sprite
	{
		private var model:Model;
		private var controller:Controller;
		
		private var displayText:TextField = new TextField();
		private var inputText:TextField = new TextField();
		private var greenButton:Sprite = new Sprite();
		
		public function View(model:Model, controller:Controller)
		{
			this.model = model;
			this.controller = controller;
			
			displayText.text = model.textForView;
			displayText.width = 640;
			
			inputText.type = "input";
			inputText.y = 20;
			inputText.width = 100;
			inputText.height = 20;
			inputText.border = true;
			
			greenButton.graphics.beginFill(0x00cc00);
			greenButton.graphics.drawRect(0,0,100,20);
			greenButton.graphics.endFill();
			greenButton.y = 40;
			greenButton.width = 100;
			
			addChild(displayText);
			addChild(inputText);
			addChild(greenButton);
			
			greenButton.addEventListener("click",greenButton_clickHandler);
			model.addEventListener(Event.CHANGE, model_changeHandler);
		}
		private function greenButton_clickHandler(e:MouseEvent):void
		{
			controller.saveTextForModel(inputText.text);
			trace("click");
		}
		private function model_changeHandler(e:Event):void
		{
			displayText.text = model.textForView;
		}
	}
}