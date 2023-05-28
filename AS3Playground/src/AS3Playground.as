package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	/**
	 * @author Robert Daniels
	 */
	public class AS3Playground extends Sprite
	{
		/**
		 *@Constructor
		 * Initialize the instances of this class
		 */
		public function AS3Playground()
		{
			/*
			 *Call init();
			 */
			init();
		}
		
		/**
		 *initializer
		 *
		 */
		private function init():void
		{
			/*
			 *Number of columns.
			 */
			var columns:Number = 60;
			/*
			 *Number of rows.
			 */
			var rows:Number = 2;
			/*
			 *Stage width divided by the number of columns: width of each box.
			 */
			var valA:Number = stage.stageWidth / columns;
			/*
			 *Stage height divided by the number of rows: height of each box.
			 */
			var valB:Number = stage.stageHeight / rows;
			
			/*
			 *Loops through the stage width incrementing by the width of each box.
			 */
			for (var i:Number = 0; i < valA * columns; i += valA)
			{
				/*
				 *Loops through the stage height incrementing by the height of each box.
				 */
				for (var j:Number = 0; j < valB * rows; j += valB)
				{
					trace(i, j);
					/*
					 *Creates a new Sprite by calling the createInvisibleBox(width, height); function which returns a Sprite.
					 */
					var b:Sprite = createInvisibleBox(valA, valB);
					/*
					 *Position the sprite with the variables i (x position) and j (y position).
					 */
					b.x = i;
					b.y = j;
					/*
					 *Add the sprite to the root(stage's) display list.
					 */
					addChild(b);
					/*
					 *Add an event listener which fires when the user mouses over the box.
					 */
					b.addEventListener(MouseEvent.MOUSE_OVER, onOver);
				}
			}
		}
		
		/**
		 *
		 * @param width: <code>Number</code>
		 * @param height: <code>Number</code>
		 * @return: <code>Sprite</code>
		 *
		 * Creates a <code>sprite</code> adds a <code>bitmap</code> to it's display list.
		 * The <code>bitmap</code>'s <code>bitmapData</code> is created with the parameters width and height which are required by the function.
		 * The <code>bitmapData</code> is also left transparent (default)
		 *
		 */
		private function createInvisibleBox(width:Number, height:Number):Sprite
		{
			/*
			 * Create the sprite.
			 */
			var s:Sprite = new Sprite();
			/*
			 *Set it's buttonMode to true giving it button behaviours.
			 */
			s.buttonMode = true;
			/*
			 *Add a new Bitmap to its display list, creating a new bitmapData in the process which is required when creating a Bitmap.
			 */
			s.addChild(new Bitmap(new BitmapData(width, height)));
			/*
			 *Return the sprite.
			 */
			return s;
		}
		
		/**
		 *
		 * @param e: <code>MouseEvent</code>
		 *
		 */
		private function onOver(e:MouseEvent):void
		{
			/*
			 *creates a new ColorTransform by getting the colorTransform property from the target.transform.
			 */
			var ct:ColorTransform = e.target.transform.colorTransform;
			/*
			 *Make the colour of the color transform random.
			 */
			ct.color = Math.random() * 0xffffff;
			/*
			 *Set the color transform of the target to the newly created color transform.
			 */
			e.target.transform.colorTransform = ct;
			/*
			 *Add an event listener to the target firing when the user mouses out of the target.
			 */
			e.target.addEventListener(MouseEvent.MOUSE_OUT, onOut);
		}
		
		/**
		 *
		 * @param e: <code>MouseEvent</code>
		 *
		 */
		private function onOut(e:MouseEvent):void
		{
			/*
			 *Set the targets color transform to a new one (original)
			 */
			e.target.transform.colorTransform = new ColorTransform();
			/*
			 *Remove the event listener which fires on the mouse out of the target
			 */
			e.target.removeEventListener(MouseEvent.MOUSE_OUT, onOut);
		}
	}
}