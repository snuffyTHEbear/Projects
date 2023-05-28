package com.arcticcode.visual.controls
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * 
	 * @author Robert Daniels
	 * Basic handle which can be dragged around
	 * 
	 */	
	public class Handle extends Sprite
	{
		/**
		 *Colour of the handle 
		 */		
		private var _colour:uint;
		/**
		 *Draw the outer frame 
		 */		
		private var _outerFrame:Boolean;
		/**
		 *Reference to the handles graphics object 
		 */		
		private var g:Graphics;
		/**
		 *Called each time the handle is moved 
		 */		
		private var _callback:Function;
		private var _rect:Rectangle;
		private var _handleWidth:Number;
		private var _handleHeight:Number;
		/**
		 * 
		 * @param colour - Colour of the handle
		 * @param outerFrame - Draw the outer frame or not
		 * @param callback - If a function is given it's called each time the handle is moved
		 */		
		public function Handle(colour:uint, outerFrame:Boolean = false, callback:Function = null, handleWidth:Number = 100, handleHeight:Number = 100)
		{
			_colour = colour;
			_outerFrame = outerFrame;
			_callback = callback;
			g = this.graphics;
			_handleHeight = handleHeight;
			_handleWidth = handleWidth;
			init();
		}
		private function init():void
		{
			draw();
			super.buttonMode = true;
			super.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		}
		private function draw():void
		{
			g.clear();
			if(_outerFrame)
			{
				var _w:Number = _handleWidth * 0.5;
				var _h:Number = _handleHeight * 0.5;
				g.lineStyle(0, _colour);
				g.drawRect(-_w, -_h, _handleWidth, _handleHeight);
				/*g.moveTo(_w, _h);
				g.lineTo(-_w, -_h);
				g.moveTo(-_w, _h);
				g.lineTo(_w, -_h);*/
				//g.beginFill(_colour);
				//g.drawRect(-5, -5, 10, 10);
				//g.endFill();
				
				_rect = new Rectangle(x, y, _handleWidth, _handleHeight);
			}
			else
			{
				g.beginFill(_colour);
				g.drawCircle(0, 0, 5);
				g.endFill();
			}
		}
		private function mouseDown(e:MouseEvent):void
		{
			this.startDrag();
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			if(this.stage != null)this.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
		}
		private function mouseMove(e:MouseEvent):void
		{
			if(_callback != null)_callback();
		}
		private function mouseUp(e:MouseEvent):void
		{
			this.stopDrag();
			if(this.stage != null)this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			this.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		/**
		 * 
		 * @param val - Add / Remove the interactivity (buttonMode / MouseEvents)
		 * 
		 */		
		public function setInteractivity(val:Boolean):void
		{
			if(val)
			{
				super.buttonMode = true;
				super.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			}
			else
			{
				super.buttonMode = false;
				super.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			}
		}
		/**
		 * 
		 * @return - A random point within the handles rectangle (if outer frame is drawn) 
		 * 
		 */		
		public function getRandomPoint():Point
		{
			var p:Point = new Point();
			if(_rect != null)
			{
				p.x = Math.random() * _rect.width + _rect.x;
				p.y = Math.random() * _rect.height + _rect.y;
			}
			else 
			{
				p.x = x;
				p.y = y;
			}
			return localToGlobal(p);
		}
		/**
		 * 
		 *  @return - Global coordinates within the parent of the handles x and y coordinates 
		 * 
		 */		
		public function getCenterPoint():Point
		{
			return parent.localToGlobal(new Point(x, y));
		}

		public function get handleWidth():Number
		{
			return _handleWidth;
		}

		public function set handleWidth(value:Number):void
		{
			_handleWidth = value;
			draw();
		}

		public function get handleHeight():Number
		{
			return _handleHeight;
		}

		public function set handleHeight(value:Number):void
		{
			_handleHeight = value;
			draw();
		}
		public function move(x:Number, y:Number):void
		{
			super.x = x;
			super.y = y;
		}
	}
}