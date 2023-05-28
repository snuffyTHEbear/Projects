package particles
{
	import objects.BasicObject;
	
	public class Particle extends BasicObject
	{
		private var _mass:Number;
		
		public function Particle(radius:Number = 5, colour:uint = undefined)
		{
			super.drawCircle(radius, colour);
		}

		public function get mass():Number
		{
			return _mass;
		}

		public function set mass(v:Number):void
		{
			_mass = v;
		}

	}
}