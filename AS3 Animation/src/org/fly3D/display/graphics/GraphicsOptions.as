package org.fly3D.display.graphics
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	
	public class GraphicsOptions
	{
		public var line:Boolean;
		
		public var fill:Boolean;
		
		public var fillColour:uint;
		
		public var lineColour:uint;
		
		public var fillAlpha:Number;
		
		public var lineAlpha:Number;
		
		public var lineThickness:Number;
		
		public var type:String;
		
		//Bitmap
		public var bitmapData:BitmapData;
		
		public var bitmapRepeat:Boolean;
		
		public var bitmapSmooth:Boolean;
		
		public var bitmapMatrix:Matrix;
		
		//Gradient
		public var gradientType:String;
		
		public var gradientColors:Array;
		
		public var gradientAlphas:Array;
		
		public var gradientRatios:Array;
		
		public var gradientMatrix:Matrix;
		
		public var gradientSpreadMethod:String;
		
		public var gradientInterpolationMethod:String;
		
		public var gradientFocalPointRatio:Number;
		
		public var g:Graphics;
		
		public static const SOLID_COLOR:String = "solidColour";
		
		public static const BITMAP:String = "bitmap";
		
		public static const GRADIENT:String = "gradient";
		
		public static const RANDOM:String = "random";
		
		public static const FACES:String = "faces";
		
		public static const LINE:String = "line";
		
		public static const CURVE:String = "curve";
		
		public function GraphicsOptions(graphics:Graphics, type:String = GraphicsOptions.SOLID_COLOR)
		{
			g = graphics;
			this.type = type;
		}
		
		public function startDraw($colour:uint):void
		{
			if(line)
			{
				g.lineStyle(lineThickness, lineColour, lineAlpha);
			}
			if(fill)
			{
				switch(type)
				{
					case SOLID_COLOR:
						g.beginFill(fillColour, fillAlpha);
						break;
					
					case BITMAP:
						g.beginBitmapFill(bitmapData, bitmapMatrix, bitmapRepeat, bitmapSmooth);
						break;
					
					case GRADIENT:
						g.beginGradientFill(gradientType, gradientColors, gradientAlphas, gradientRatios, gradientMatrix, gradientSpreadMethod, gradientInterpolationMethod, gradientFocalPointRatio);
						break;
					
					case RANDOM:
						g.beginFill(Math.random() * 0xFFFFFF, fillAlpha);
						break;
					
					case FACES: //[TODO use alpha prop from triangle?]
						g.beginFill($colour, fillAlpha);
						break;
				}
			}
		}
		
		public function setBeginFill(fill:Boolean, color:uint = 0xCC0000, alpha:Number = 1.0):void
		{
			this.fill = fill;
			fillColour = color;
			fillAlpha = alpha;
		}
		
		public function setLineStyle(line:Boolean, color:uint = 0x000000, thickness:Number = 0, alpha:Number = 1.0):void
		{
			this.line = line;
			lineColour = color;
			lineThickness = thickness;
			lineAlpha = alpha;
		}
		
		public function setBitmapFill(bitmap:BitmapData, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false):void
		{
			bitmapData = bitmap;
			bitmapMatrix = matrix;
			bitmapRepeat = repeat;
			bitmapSmooth = smooth;
		}
		
		public function setGradientFill(type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0):void
		{
			gradientType = type;
			gradientAlphas = alphas;
			gradientColors = colors;
			gradientFocalPointRatio = focalPointRatio;
			gradientInterpolationMethod = interpolationMethod;
			gradientMatrix = matrix;
			gradientRatios = ratios;
			gradientSpreadMethod = spreadMethod;
		}
	}
}