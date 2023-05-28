package springing
{
	import display.objects.Ball;
	import display.objects.Handle;
	
	import easing.Easer;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class SpringingTests extends Sprite
	{
		private var _ball:Ball;
		private var _springer:Springer;
		private var _easer:Easer;
		private var _handles:Vector.<Handle>;
		private var _positions:Vector.<Point>;
		
		public function SpringingTests()
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init( e:Event ):void
		{
			removeEventListener( e.type, init );
			
			_ball = new Ball( 120 );
			addChild( _ball );
			
			_handles = new Vector.<Handle>();
			_positions = new Vector.<Point>();
			
			_positions.push( new Point( 0, 0 ));
			_positions.push( new Point( stage.stageWidth, 0 ));
			_positions.push( new Point( stage.stageWidth, stage.stageHeight ));
			_positions.push( new Point( 0, stage.stageHeight ));
			
			var i:uint;
			var len:uint = _positions.length;
			
			for ( i = 0; i < len; i++ )
			{
				var h:Handle = new Handle(false);
				h.move( _positions[ i ].x, _positions[ i ].y );
				addChild( h );
				_handles.push( h );
			}
			
			_springer = new Springer( _ball, 400, 0.08 );
			_easer = new Easer(_ball, 0.2);
			
			addEventListener( Event.ENTER_FRAME, loop );
		}
		
		private function loop( e:Event ):void
		{
			var i:uint
			var len:uint = _handles.length;
			
			for ( i = 0; i < len; i++ )
			{
				_springer.update(_handles[i].x, _handles[i].y, 0.95);
			}
			
			_easer.update(mouseX, mouseY);
		}
	}
}