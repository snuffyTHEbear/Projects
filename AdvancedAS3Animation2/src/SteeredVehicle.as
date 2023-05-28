package
{
	import com.arcticcode.greenFlames.geom.Vector2D;
	
	public class SteeredVehicle extends Vehicle
	{
		private var _maxForce:Number = 1;
		private var _steeringForce:Vector2D;
		private var _arrivalThreshold:Number = 100;
		private var _wanderRange:Number = 1;
		private var _wanderRadius:Number = 5;
		private var _wanderDistance:Number = 10;
		private var _wanderAngle:Number = 0;
		private var _avoidDistance:Number = 300;
		private var _avoidBuffer:Number = 10;
		private var _pathIndex:uint=0;
		private var _pathThreshold:Number = 20;
		private var _inSightDist:Number = 200;
		private var _tooCloseDist:Number = 60;
		
		public function SteeredVehicle()
		{
			_steeringForce = new Vector2D();
			super();
		}
		public function set inSightDist(val:Number):void
		{
			_inSightDist = val;
		}
		
		public function get inSightDist():Number
		{
			return _inSightDist;
		}
		public function set tooCloseDist(val:Number):void
		{
			_tooCloseDist = val;
		}
		public function get tooCloseDist():Number
		{
			return _tooCloseDist;
		}
		public function set pathIndex(val:uint):void
		{
			_pathIndex = val;
		}
		public function get pathIndex():uint
		{
			return _pathIndex;
		}
		public function set pathThreshold(val:Number):void
		{
			_pathThreshold = val;
		}
		public function get pathThreshold():Number
		{
			return _pathThreshold;
		}
		public function set maxForce(val:Number):void
		{
			_maxForce = val;
		}
		public function get maxForce():Number
		{
			return _maxForce;
		}
		public function set arrivalThreshold(val:Number):void
		{
			_arrivalThreshold = val;
		}
		public function get arrivalThreshold():Number
		{
			return _arrivalThreshold;
		}
		public function set wanderDistance(value:Number):void
		{
		    _wanderDistance = value;
		}
		public function get wanderDistance():Number
		{
		    return _wanderDistance;
		}
		public function set wanderRadius(value:Number):void
		{
		    _wanderRadius = value;
		}
		public function get wanderRadius():Number
		{
		    return _wanderRadius;
		}
		public function set wanderRange(value:Number):void
		{
		    _wanderRange = value;
		}
		public function get wanderRange():Number
		{
		    return _wanderRange;
		}
		override public function update():void
		{
			_steeringForce.truncate(_maxForce);
			_steeringForce = _steeringForce.divide(_mass);
			_velocity = _velocity.add(_steeringForce);
			_steeringForce = new Vector2D();
			super.update();
		}
		public function seek(target:Vector2D):void
		{
			var desiredVelocity:Vector2D = target.subtract(_position);
			desiredVelocity.normalize();
			desiredVelocity = desiredVelocity.multiply(_maxSpeed);
			var force:Vector2D = desiredVelocity.subtract(_velocity);
			_steeringForce = _steeringForce.add(force);
		}
		public function flee(target:Vector2D):void
		{
			var desiredVelocity:Vector2D = target.subtract(_position);
			desiredVelocity.normalize();
			desiredVelocity = desiredVelocity.multiply(_maxSpeed);
			var force:Vector2D = desiredVelocity.subtract(_velocity);
			_steeringForce = _steeringForce.subtract(force);
		}
		public function arrive(target:Vector2D):void
		{
			var desiredVelocity:Vector2D = target.subtract(_position);
			desiredVelocity.normalize();
			
			var dist:Number = _position.dist(target);
			if(dist > _arrivalThreshold)
			{
				desiredVelocity = desiredVelocity.multiply(_maxSpeed);
			}
			else
			{
				desiredVelocity = desiredVelocity.multiply(_maxSpeed * dist / _arrivalThreshold);
			}
			
			var force:Vector2D = desiredVelocity.subtract(_velocity);
			_steeringForce = _steeringForce.add(force);
		}
		public function pursue(target:Vehicle):void
		{
			var lookAheadTime:Number = position.dist(target.position) / _maxSpeed;
			var predTarget:Vector2D = target.position.add(target.velocity.multiply(lookAheadTime));
			seek(predTarget);
		}
		public function evade(target:Vehicle):void
		{
			var lookAheadTime:Number = position.dist(target.position) / _maxSpeed;
			var predTarget:Vector2D = target.position.subtract(target.velocity.multiply(lookAheadTime));
			flee(predTarget);
		}
		public function wander():void
		{
			var centre:Vector2D = velocity.clone().normalize().multiply(_wanderDistance);
			var offset:Vector2D = new Vector2D(0);
			offset.length = _wanderRadius;
			offset.angle = _wanderAngle;
			_wanderAngle += Math.random() * _wanderRange - _wanderRange * 0.5;
			var force:Vector2D = centre.add(offset);
			_steeringForce = _steeringForce.add(force);
		}
		public function avoid(objects:Array):void
		{
			for(var i:uint=0;i<objects.length;i++)
			{
				var obj:Object = objects[i];
				var objVector:Vector2D = new Vector2D(obj.x,obj.y);
				var heading:Vector2D = _velocity.clone().normalize();
				
				var difference:Vector2D = objVector.subtract(_position);
				var dotProd:Number = difference.dotProd(heading);
				
				if(dotProd > 0)
				{
					var feeler:Vector2D = heading.multiply(_avoidDistance);
					var projection:Vector2D = heading.multiply(dotProd);
					var dist:Number = projection.subtract(difference).length;
					
					if(dist < obj.radius + _avoidBuffer && projection.length < feeler.length)
					{
						var force:Vector2D = heading.multiply(_maxSpeed);
						force.angle += difference.sign(_velocity) * Math.PI/2;
						
						force = force.multiply(1.0 - projection.length / feeler.length);
						
						_steeringForce = _steeringForce.add(force);
						_velocity = _velocity.multiply(projection.length / feeler.length);
					} 
				} 
			}
		}
		public function followPath(path:Array, loop:Boolean = false):void
		{
			var wayPoint:Vector2D = path[_pathIndex];
			if(wayPoint == null)return;
			if(_position.dist(wayPoint) < _pathThreshold)
			{
				if(_pathIndex >= path.length - 1)
				{
					if(loop)
					{
						_pathIndex = 0;
					}
				}
				else
				{
					_pathIndex++;
				}
			}
			if(_pathIndex >= path.length - 1 && !loop)
			{
				arrive(wayPoint);
			}
			else
			{
				seek(wayPoint);
			}
		}
		public function flock(vehicles:Array):void
		{
			var averageVelocity:Vector2D = _velocity.clone();
			var averagePosition:Vector2D = new Vector2D();
			var inSightCount:int = 0;
			for(var i:uint=0;i<vehicles.length;i++)
			{
				var v:Vehicle = vehicles[i] as Vehicle;
				if(v != this && inSight(v))
				{
					averageVelocity = averageVelocity.add(v.velocity);
					averagePosition = averagePosition.add(v.position);
					if(tooClose(v))flee(v.position);
					inSightCount++;
				}
			}
			if(inSightCount > 0)
			{
				averageVelocity = averageVelocity.divide(inSightCount);
				averagePosition = averagePosition.divide(inSightCount);
				seek(averagePosition);
				_steeringForce.add(averageVelocity.subtract(_velocity));
			}
		}
		public function inSight(vehicle:Vehicle):Boolean
		{
			if(_position.dist(vehicle.position) > _inSightDist) return false;
			var heading:Vector2D = _velocity.clone().normalize();
			var difference:Vector2D = vehicle.position.subtract(_position);
			var dotProd:Number = difference.dotProd(heading);
			if(dotProd < 0)return false;
			return true;
		}
		public function tooClose(vehicle:Vehicle):Boolean
		{
			return _position.dist(vehicle.position) < _tooCloseDist;
		}
	}
}