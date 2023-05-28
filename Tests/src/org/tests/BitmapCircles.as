package org.tests
{
	import com.arcticcode.greenFlames.graphics.ColourUtils;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class BitmapCircles extends Sprite
	{
		private var _bmd:BitmapData;
		private var _b:Bitmap;
		
		public function BitmapCircles()
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init( e:Event ):void
		{
			removeEventListener( e.type, init );
			
			_bmd = new BitmapData( 50, 50, false );
			_b = new Bitmap( _bmd );
			addChild( _b );
			_bmd.perlinNoise( 10, 10, 7, Math.random(), false, true, 7 );
			trace( averageOfTwoColors( 0xFF0000, 0x00FF00 ).toString( 16 ));
			
			
		}
		
		private function averageColor( ... rest ):uint
		{
			var numColors:uint = rest.length;
			var r:Number, g:Number, b:Number, a:Number, color:uint, i:uint;
			r = g = b = a = 0;
			
			for ( i = 0; i < numColors; i++ )
			{
				var c:uint;
				r += ColourUtils.extractRed( rest[ i ]);
				g += ColourUtils.extractGreen( rest[ i ]);
				b += ColourUtils.extractBlue( rest[ i ]);
				a += ColourUtils.extractAlpha( rest[ i ]);
			}
			
			r = r / numColors;
			g = g / numColors;
			b = b / numColors;
			a = a / numColors;
			
			color = ColourUtils.combineColours32( a, r, g, b );
			
			return color;
		}
		
		private function averageOfTwoColors( ca:uint, cb:uint ):uint
		{
			//return (ca + cb) / 2;//complex check?
			var r:Number = ( ColourUtils.extractRed( ca ) + ColourUtils.extractRed( cb )) / 2;
			var g:Number = ( ColourUtils.extractGreen( ca ) + ColourUtils.extractGreen( cb )) / 2;
			var b:Number = ( ColourUtils.extractBlue( ca ) + ColourUtils.extractBlue( cb )) / 2;
			var a:Number = ( ColourUtils.extractAlpha( ca ) + ColourUtils.extractAlpha( cb )) / 2;
			return ColourUtils.combineColours32( a, r, g, b );
		}
	}
}