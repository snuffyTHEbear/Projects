package springing
{
	import display.objects.Ball;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class DoubleSpring extends Sprite
	{
		private var _balls:Vector.<Ball> = new Vector.<Ball>();
		private var _numBalls:uint = 10;
		private var _spring:Number = 0.1;
		private var _friction:Number = 0.8;
		private var _springLength:Number = 250;
		
		public function DoubleSpring()
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init( e:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, init );
			
			var i:uint;
			
			for ( i = 0; i < _numBalls; i++ )
			{
				var b:Ball = new Ball( 5 );
				b.move( Math.random() * stage.stageWidth, Math.random() * stage.stageHeight );
				addChild( b );
				_balls.push( b );
				b.addEventListener( MouseEvent.MOUSE_DOWN, onPress );
			}
			stage.addEventListener( MouseEvent.MOUSE_UP, mouseUp );
			
			addEventListener( Event.ENTER_FRAME, loop );
		}
		
		private function mouseUp( e:MouseEvent ):void
		{
			var i:uint;
			
			for ( i = 0; i < _numBalls; i++ )
			{
				_balls[ i ].isDragging = false;
				_balls[ i ].stopDrag();
			}
		}
		
		private function onPress( e:MouseEvent ):void
		{
			e.target.startDrag();
			e.target.isDragging = true;
		}
		
		private function loop( e:Event ):void
		{
			var i:uint;
			var j:uint;
			var len:uint = _balls.length;
			
			graphics.clear();
			graphics.lineStyle( 0 );
			graphics.moveTo( _balls[ 0 ].x, _balls[ 0 ].y );
			
			for(i=0;i<len;i++)
			{
				if(!_balls[i].isDragging)
				{
					for(j = 0;j<len;j++)
					{
						if(_balls[j] != _balls[i])
						{
							if(!_balls[j].isDragging)
							{
								springTo(_balls[i], _balls[j]);
							}
						}
					}
				}
			}
			drawLine();	
		}
		
		private function drawLine():void
		{
			var i:uint;
			
			var len:uint = _balls.length;
			for(i=0;i<len;i++)
			{
				graphics.lineTo( _balls[ i ].x, _balls[ i ].y );
			}
			graphics.lineTo(_balls[0].x, _balls[0].y);
		}
		
		private function checkBounds( obj:Ball ):void
		{
			if ( obj.x + obj.radius > stage.stageWidth )
			{
				obj.x = stage.stageWidth - obj.radius;
			}
			else if ( obj.x - obj.radius < 0 )
			{
				obj.x = obj.radius;
			}
			
			if ( obj.y + obj.radius > stage.stageHeight )
			{
				obj.y = stage.stageHeight - obj.radius;
			}
			else if ( obj.y - obj.radius < 0 )
			{
				obj.y = obj.radius;
			}
		}
		
		private function springTo( ballA:Ball, ballB:Ball ):void
		{
			var dx:Number = ballB.x - ballA.x;
			var dy:Number = ballB.y - ballA.y;
			var angle:Number = Math.atan2( dy, dx );
			var targetX:Number = ballB.x - Math.cos( angle ) * _springLength;
			var targetY:Number = ballB.y - Math.sin( angle ) * _springLength;
			ballA.vx += ( targetX - ballA.x ) * _spring;
			ballA.vy += ( targetY - ballA.y ) * _spring;
			ballA.vx *= (ballA.radius / 10);
			ballA.vy *= (ballA.radius / 10);
			ballA.applyVelocity();
			checkBounds(ballA);
		}
	}
}