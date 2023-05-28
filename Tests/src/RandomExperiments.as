////////////////////////////////////////////////////////////////////////////////
//   Robert Daniels - http://arctic-code.com 
////////////////////////////////////////////////////////////////////////////////

package
{
	import com.arcticcode.greenFlames.display.DisplayUtils;
	import com.arcticcode.greenFlames.math.MathUtils;
	import flash.display.Sprite;
	import flash.events.Event;
	[SWF( width=600, height=400, backgroundColor=0xffffff )]
	public class RandomExperiments extends Sprite
	{
		
		public function RandomExperiments()
		{
			init();
		}

		private var a:Number = 0;
		private const centreX:Number = stage.stageWidth * 0.5;
		private const centreY:Number = stage.stageHeight * 0.5;
		private var cont:Sprite;
		
		private function init():void
		{
			trace(( 10 % 2 ), ( 11 % 3 ));
			var num:Number = 56.781256;
			trace( num );
			num = Number( MathUtils.truncate( num, 5 ));
			trace( num );
			num = 10.909090;
			trace( num );
			
			cont = new Sprite();
			DisplayUtils.doCentreOne( cont, centreX, centreY );
			addChild( cont );
			cont.graphics.lineStyle( 0, 0 );
			
			testFour();
			DisplayUtils.doCentreOne( cont, stage.stageWidth, stage.stageHeight );
			//addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function moireFrame( rad:Number = 50 ):void
		{
			for ( var theta:Number = 0; theta < 360; theta += 5 )
			{
				var r:Number = rad / 2;
				var X:Number = r * Math.cos( MathUtils.degreesToRadians( theta )) + centreX;
				var Y:Number = r * Math.sin( MathUtils.degreesToRadians( theta )) + centreY;
				graphics.moveTo( X, Y );
				r = rad;
				X = r * Math.cos( MathUtils.degreesToRadians( theta )) + centreX;
				Y = r * Math.sin( MathUtils.degreesToRadians( theta )) + centreY;
				graphics.lineTo( X, Y );
			}
		}
		
		private function moireFrame2( rad:Number = 50, ang:Number = 10 ):void
		{
			var a:Number = ang;
			
			for ( var theta:Number = 0; theta < 360; theta += 5 )
			{
				var r:Number = rad / 2;
				var X:Number = r * Math.cos( MathUtils.degreesToRadians( theta )) + centreX;
				var Y:Number = r * Math.sin( MathUtils.degreesToRadians( theta )) + centreY;
				graphics.moveTo( X, Y );
				r = rad;
				X = r * Math.cos( MathUtils.degreesToRadians( theta + a )) + centreX;
				Y = r * Math.sin( MathUtils.degreesToRadians( theta + a )) + centreY;
				graphics.lineTo( X, Y );
			}
		}
		
		private function nonlinearity():void
		{
			graphics.lineStyle( 0, 1 );
			
			for ( var i:Number = 1; i < 100; i += 1.25 )
			{
				graphics.moveTo( i, 0 );
				graphics.lineTo( i, 80 );
			}
			
			for ( i = 1; i < 100; i += 1.25 )
			{
				graphics.moveTo( i, 0 );
				graphics.lineTo( i + 10, 80 );
			}
		}
		
		private function onEnterFrame( e:Event ):void
		{
			graphics.clear();
			graphics.lineStyle( 0, 0 );
			moireFrame( 300 );
			graphics.lineStyle( 0, 0 );
			moireFrame2( 300, a );
			a++;
		}
		
		private function testFour():void
		{
			for ( var n:Number = 0; n < 5; n += 0.2 )
			{
				for ( var X:Number = 0; X < 3; X++ )
				{
					var Y:Number = ( X * n ) * 50;
					cont.graphics.lineTo( X * 50, Y );
				}
			}
		}
		
		private function testOne():void
		{
			for ( var i:int = -30; i < 30; i++ )
			{
				var Y:Number = MathUtils.square( i );
				
				if ( i == -30 )
				{
					cont.graphics.moveTo( i, Y );
				}
				else
				{
					cont.graphics.lineTo( i, Y );
				}
			}
		}
		
		private function testThree():void
		{
			for ( var i:Number = 1; i < 10; i++ )
			{
				for ( var X:Number = -10; X < 10; X++ )
				{
					var Y:Number = Math.pow( X, i );
					X == -10 ? cont.graphics.moveTo( i, Y ) : cont.graphics.lineTo( i, Y );
				}
			}
		}
		
		private function testTwo():void
		{
			for ( var i:int = -100; i < 100; i++ )
			{
				var Y:Number = Math.sin( i ) * 50;
				
				if ( i == -100 )
				{
					cont.graphics.moveTo( i, Y );
				}
				else
				{
					cont.graphics.lineTo( i, Y );
				}
			}
		}
	}
}