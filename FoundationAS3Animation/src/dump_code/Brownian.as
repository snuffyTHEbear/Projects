package{
	import caurina.transitions.Tweener;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	
	import robDaniels.greenFlames.src.graphics.CreateCircle;
	import robDaniels.greenFlames.src.graphics.CreateRect;
	
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	
	public class Brownian extends Sprite{
		
		private var numDots:Number = 50;
		private var friction:Number = 0.95;
		private var dots:Array;
		private var _b:Bitmap;
		private var _bmd:BitmapData;
		private var _glow:GlowFilter;
		private var _vx:Number = 0;
		private var _vy:Number = 0;
		private var _xPos:Number;
		private var _yPos:Number;
		private var _points:Array;
		private var _colours:Array;
		private var m:CreateRect;
		
		public function Brownian(){
			init();
		}
		private function init():void{
			dots = new Array();
			
			_points = new Array();
			_colours = new Array();
			
			for(var p:uint = 0;p<numDots;p++)
			{
				var point:Point = new Point();
				var xy:Point = new Point(Math.random() * 590 + 10, Math.random() * 390 + 10);
				_points.push({A:point, B:xy});
				_colours.push(Math.random()*0xffffff);
			}
			
			//_xPos = Math.random() * 590 + 10;
			//_yPos = Math.random() * 390 + 10;
			
			_glow = new GlowFilter(0x333333,1,6,6,2,1);
			
			_bmd = new BitmapData(stage.stageWidth, stage.stageHeight, false,0xffffffff);
			_b = new Bitmap(_bmd,PixelSnapping.ALWAYS,false);
			addChild(_b);
			
			m = new CreateRect(stage.stageWidth,50,0xff0000,1,false);
			_b.mask = m;
			addChild(m);
			m.x = 0;
			m.y = stage.stageHeight * 0.5 - m.height / 2;
			
			for(var i:uint = 0;i<numDots;i++)
			{
				var dot:CreateCircle = new CreateCircle(1,0,0x000000,1);
				dot.x = Math.random()*stage.stageWidth;
				dot.y = Math.random()*stage.stageHeight;
				dot.vx = 0;
				dot.vy = 0;
				//addChild(dot);
				dots.push(dot);
			}
			
			graphics.lineStyle(0,0,0.1);
			doTween();
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function doTween():void
		{
			Tweener.addTween(m, {xPos:Math.random() * 590 + 10, yPos:Math.random() * 390 + 10, width:Math.random() * stage.stageWidth + 2, height:Math.random() * stage.stageHeight + 2, alpha:Math.random(), rot:Math.random() * 360 - 180, time:Math.random() * 5 + 1});
		}
		private function onEnterFrame(event:Event):void
		{
			if(!Tweener.isTweening(m))
			{
				doTween();
			}
			
			for(var s:uint=0;s<10;s++)
			{
			for(var c:uint=0;c<numDots;c++)
			{
				var obj:Object = _points[c];
				var _a:Point = obj.A;
				_a.x += Math.random() * 0.2 - 0.1;
				_a.y += Math.random() * 0.2 - 0.1;
				var _b:Point = obj.B;
				_b.x += _a.x;
				_b.y += _a.y;
				_a.x *= friction;
				_a.y *= friction;
				//_bmd.setPixel(_b.x, _b.y, Math.random() * 0xFFFFFF);
				_bmd.setPixel(_b.x, _b.y, _colours[c]);
				
				if(_b.x > stage.stageWidth)
				{
					_b.x = 0;
				}
				else if(_b.x < 0)
				{
					_b.x = stage.stageWidth;
				}
				if(_b.y > stage.stageHeight)
				{
					_b.y = 0;
				}
				else if(_b.y < 0)
				{
					_b.y = stage.stageHeight;
				}
			}
			/*
			_vx += Math.random() * 0.2 - 0.1;
			_vy += Math.random() * 0.2 - 0.1;
			_xPos += _vx;
			_yPos += _vy;
			_vx *= friction;
			_vy *= friction;
			_bmd.setPixel(_xPos, _yPos, Math.random() * 0xFFFFFF);
			*/
			/*
			for(var i:uint = 0;i<numDots;i++)
			{
				var dot:CreateCircle = dots[i];
				graphics.lineStyle(0,0,0.1);
				graphics.moveTo(dot.x, dot.y);
				dot.vx += Math.random() * 0.2 - 0.1;
				dot.vy += Math.random() * 0.2 - 0.1;
				dot.x += dot.vx;
				dot.y += dot.vy;
				dot.vx *= friction;
				dot.vy *= friction;
				graphics.lineTo(dot.x, dot.y);
				_bmd.draw(stage,new Matrix());
				graphics.clear();
				
				if(_xPos > stage.stageWidth)
				{
					_xPos = 0;
				}
				else if(_xPos < 0)
				{
					_xPos = stage.stageWidth;
				}
				if(_yPos > stage.stageHeight)
				{
					_yPos = 0;
				}
				else if(_yPos < 0)
				{
					_yPos = stage.stageHeight;
				}
				*/
			}
		}
	}
}