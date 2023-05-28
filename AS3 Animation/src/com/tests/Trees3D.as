package com.tests
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import org.fly3D.display.BasicDisplayObject3D;
	import org.fly3D.display.BasicScene;
	import org.fly3D.display.Tree;
	import org.fly3D.geom.Point3D;
	
	public class Trees3D extends BasicScene
	{
		private var _position:Point3D;
		
		private var _floor:Number = 200;
		
		private var _numTrees:uint = 100;
		
		private var _trees:Array;
		
		private var _friction:Number = 0.98;
		
		private var _ax:Number = 0;
		
		private var _ay:Number = 0;
		
		private var _az:Number = 0;
		
		private var _vx:Number = 0;
		
		private var _vy:Number = 0;
		
		private var _vz:Number = 0;
		
		private var _gravity:Number = 0.3;
		
		public function Trees3D(w:Number, h:Number)
		{
			super(w * 0.5, h * 0.5);
			
			_trees = new Array(_numTrees);
			
			for(var i:uint = 0; i < _numTrees; i++)
			{
				var tree:Tree = new Tree(Tree.LINE);
				_trees[i] = tree;
				tree.move(Math.random() * 2000 - 1000, _floor, Math.random() * 10000);
				add3DObject(tree);
			}
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			startRendering();
		}
		
		override protected function loop(e:Event):void
		{
			_vx += _ax;
			_vy += _ay;
			_vz += _az;
			_vy -= _gravity;
			render();
			_vz *= _friction;
			_vx *= _friction;
			_vy *= _friction;
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
				case Keyboard.UP:
				case Keyboard.DOWN:
					_az = 0;
					break;
				
				case Keyboard.RIGHT:
				case Keyboard.LEFT:
					_ax = 0;
					break;
				
				case Keyboard.SPACE:
					_ay = 0;
					break;
				default:
					break;
			}
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
				case Keyboard.UP:
					_az = -1;
					break;
				case Keyboard.DOWN:
					_az = 1;
					break;
				case Keyboard.LEFT:
					_ax = 1;
					break;
				case Keyboard.RIGHT:
					_ax = -1;
					break;
				case Keyboard.SPACE:
					_ay = 1;
					break;
				default:
					break;
			}
		}
		
		override protected function renderObjectToScreen(obj:BasicDisplayObject3D):void
		{
			depthSort();
			obj.position.z += _vz;
			obj.position.y += _vy;
			obj.position.x += _vx;
			if(obj.position.y < _floor)
			{
				obj.position.y = _floor;
			}
			if(obj.position.z < -(focalLength))
			{
				obj.position.z += 10000;
			}
			if(obj.position.z > 10000 - focalLength)
			{
				obj.position.z -= 10000;
			}
			var scale:Number = getScale(obj);
			obj.scaleX = obj.scaleY = scale;
			obj.x = vanishingPointX + obj.position.x * scale;
			obj.y = vanishingPointY + obj.position.y * scale;
			obj.alpha = scale;
		}
	}
}