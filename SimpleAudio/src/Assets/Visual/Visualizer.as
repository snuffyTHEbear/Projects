package Assets.Visual
{
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import robDaniels.greenFlames.src.graphics.CreateRect;
	import robDaniels.greenFlames.src.utils.DoCentre;
	
	public class Visualizer extends Sprite
	{
		private var _ba:ByteArray;
		private var _w:Number;
		private var _h:Number;
		private var _canvas:Sprite;
		private var _cont:Sprite;
		private var _bars:Array;
		private var _timer:Timer;
		private var _val:Number;
		private var _mVal:Number;
		private var _i:uint;
		private var _spread:Number;
		private var _bgColour:uint;
		private var _visColour:uint;
		private var _cval:Number;
		private var _isRunning:Boolean;
		
		public function Visualizer(width:Number,height:Number, bgColour:uint, visColour:uint)
		{
			_w = width;
			_h = height;
			_bgColour = bgColour;
			_visColour = visColour;
			init();
		}
		private function init():void
		{
			_cont = new Sprite();
			_cont.width = _w;
			_cont.height = _h;
			addChild(_cont);
			
			var _rect:CreateRect = new CreateRect(_w, _h,_bgColour,0.85,true);
			_cont.addChild(_rect);
			
			_canvas = new Sprite();
			_cont.addChild(_canvas);
			
			new DoCentre(_canvas, 300-256, _h);
			
			_val = 256;
			_mVal = 1;
			_cval = 512;
			_i = 0;
		}
		public function doVis(data:ByteArray):void
		{
			//SoundMixer.computeSpectrum(_ba, false);
			_ba = data;
			_canvas.graphics.clear();
			_canvas.graphics.moveTo(0,0);
			_canvas.graphics.beginFill(_visColour);
			for(_i=0;_i<_cval;_i++)
			{
				trace(_i);
				//var _c:CreateCircle;
				_spread = (_ba.readFloat() * 100);
				//trace("R",_spread);
				//_canvas.graphics.drawRect(i,0,_w,-_spread);
				//var _c:CreateCircle = new CreateCircle(5,0,0x000000,1,i,_spread)
				//_c = _cArray[i];
				if(_i>_val)
				{
					//_c.x = i;
					//_c.x = i - 256
					//_c.y = _spread;
					_canvas.graphics.drawRect(_i-_val,0,1,_spread);
					//_bmd.setPixel32(i-256,_spread,0xff000000);
				}
				else
				{
					//_c.x = 256 - i;
					//_c.y = -_spread;
					_canvas.graphics.drawRect(_i,0,1,-_spread);
					//_bmd.setPixel32(i-256,-_spread,0xff000000);
				}
				//_bmd.draw(_canvas,_mat);
				//_c.y = -_spread;
			}
			//e.updateAfterEvent();
		}
		public function set visWidth(val:Number):void
		{
			_w = val;
			_cont.width = _w;
		}
		public function get visWidth():Number
		{
			return _w;
		}
		public function set visHeight(val:Number):void
		{
			_h = val;
			_cont.height = _h;
		}
		public function get visHeight():Number
		{
			return _h;
		}
	}
}