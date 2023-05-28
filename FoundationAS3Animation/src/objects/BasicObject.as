package objects
{
	import flash.display.Sprite;
	import flash.display.Stage;
	
	public class BasicObject extends Sprite
	{
		private var _radius:Number;
		private var _colours:Array;
		private var _alphas:Array;
		private var _vx:Number = 0;
		private var _vy:Number = 0;
		
		public function BasicObject()
		{
			
		}

		public function get alphas():Array
		{
			return _alphas;
		}

		public function set alphas(v:Array):void
		{
			_alphas = v;
		}

		public function get colours():Array
		{
			return _colours;
		}

		public function set colours(v:Array):void
		{
			_colours = v;
		}
		
		public function addForce(force:Number, property:String):void
		{
			this[property] += force;
		}
		
		public function multiplyForce(force:Number, property:String):void
		{
			this[property] *= force;
		}

		public function applyFriction(f:Number):void
		{
			vx *= f;
			vy *= f;
		}
		
		public function applyVelocity():void
		{
			x += _vx;
			y += _vy;
		}
		
		public function get radius():Number
		{
			return _radius;
		}

		public function set radius(v:Number):void
		{
			_radius = v;
		}

		public function move(x:Number, y:Number):void
		{
			super.x = x;
			super.y = y;
		}
		
		public function moveToRandomStageCoordinates(stage:Stage):void
		{
			super.x = Math.random() * stage.stageWidth;
			super.y = Math.random() * stage.stageHeight;
		}

		public function get vy():Number
		{
			return _vy;
		}

		public function set vy(v:Number):void
		{
			_vy = v;
		}

		public function get vx():Number
		{
			return _vx;
		}

		public function set vx(v:Number):void
		{
			_vx = v;
		}
		public function drawCircle(radius:Number = 20, colour:uint = undefined):void
		{
			_radius = radius;
			super.graphics.beginFill(colour != undefined ? colour : Math.random() * 0xffffff, 1);
			super.graphics.drawCircle(0, 0, _radius);
			super.graphics.endFill();
		}
		public function drawSquare(width:Number = 10, height:Number = 10):void
		{
			super.graphics.beginFill(_colours[0], 0.85);
			super.graphics.drawRect(-width*0.5, -height*0.5, width, height);
			super.graphics.endFill();
		}
	}
}