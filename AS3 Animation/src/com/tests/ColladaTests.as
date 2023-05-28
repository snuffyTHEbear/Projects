package com.tests
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import org.fly3D.display.BasicScene;
	import org.fly3D.display.BasicShape3D;
	import org.fly3D.display.graphics.GraphicsOptions;
	import org.fly3D.geom.Light;
	import org.fly3D.parsers.ColladaDAEParser;
	
	public class ColladaTests extends BasicScene
	{
		private var _collada:BasicShape3D;
		private var _parser:ColladaDAEParser;
		private var _light:Light;
		private var _go:GraphicsOptions;
		
		public function ColladaTests(w:Number, h:Number)
		{
			super(w * 0.5, h * 0.5);
			
			_light = new Light();
			_collada = new BasicShape3D(_light);
			_parser = new ColladaDAEParser("assets/Plane.DAE", _collada, daeParsed);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			e.target.removeEventListener(e.type, arguments.callee);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, stageKey);
			//addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function daeParsed():void
		{
		
			//trace("Parsed");
		}
		
		private function stageKey(e:KeyboardEvent):void
		{
		
		}
		
		private function loop(e:Event):void
		{
		
		}
	}
}