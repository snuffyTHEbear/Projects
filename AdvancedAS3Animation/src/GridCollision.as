package
{
	import __AS3__.vec.Vector;
	
	import com.arcticcode.greenFlames.graphics.CreateCircle;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class GridCollision extends Sprite
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;	
		private const GRID_SIZE:Number = 50;
		private const RADIUS:Number = 20;
		
		private var bmd1:BitmapData;
		private var bmd2:BitmapData;
		private var _balls:Vector.<DisplayObject>;
		private var _grid:CollisionGrid;
		private var _numBalls:uint = 50;
		private var _numChecks:uint = 0;
		
		public function GridCollision()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			init();
		}
		private function makeBalls():void
		{
			_balls = new Vector.<DisplayObject>(_numBalls);
			for(var i:int = 0;i<_numBalls;i++)
			{
				var b:CreateCircle = new CreateCircle(RADIUS,true,false,0,0.5);
				b.move(Math.random()*stage.stageWidth,Math.random()*stage.stageHeight);
				b._object.vx = Math.random() * 4 - 2;
				b._object.vy = Math.random() * 4 - 2;
				addChild(b);
				_balls[i] = b;
			}
		}
		private function checkCollision(ballA:CreateCircle,ballB:CreateCircle):void
		{
			_numChecks++;
			var dx:Number = ballB.x - ballA.x;
			var dy:Number = ballB.y - ballA.y;
			var dist:Number = Math.sqrt(dx*dx+dy*dy);
			if(dist < ballA.radius + ballB.radius)
			{
				ballA.color = 0xff0000;
				ballB.color = 0xff0000;
			}
		}
		private function basicCheck():void
		{
			for(var i:uint=0;i<_balls.length-1;i++)
			{
				var ba:CreateCircle = _balls[i] as CreateCircle;
				for(var j:uint=i+1;j<_balls.length;j++)
				{
					var bb:CreateCircle = _balls[j] as CreateCircle;
					checkCollision(ba,bb);
				}
			}
		}
		private function init():void
		{
			_grid = new CollisionGrid(stage.stageWidth,stage.stageHeight,GRID_SIZE);
			_grid.drawGrid(graphics);
			
			makeBalls();
			
			addEventListener(Event.ENTER_FRAME, loop);
			/*var startTime:int;
			var elapsed:int;
			
			startTime = getTimer();
			for(var i:int=0;i<10;i++)
			{
				_grid.check(_balls);
				var numChecks:int = _grid.checks.length;
				for(var j:int=0;j<numChecks;j+=2)
				{
					checkCollision(_grid.checks[j] as CreateCircle,_grid.checks[j+1] as CreateCircle);
				}
			}
			
			elapsed = getTimer() - startTime;
			trace("Elapsed:",elapsed);
			*/
			/*
			makeBalls();
			makeGrid();
			drawGrid();
			assignBalls();
			checkGrid();*/
			
			/*makeBalls();
			drawGrid();
			 var startTime:int;
			 var elapsed:int;
			 var i:int;
			 
			 startTime = getTimer();
			 
			 for(i=0;i<10;i++)
			 {
			 	makeGrid();
			 	assignBalls();
			 	checkGrid();
			 }
			 elapsed = getTimer() - startTime;
			 trace("Grid Based:",elapsed);
			 
			 startTime = getTimer();
			 for(i=0;i<10;i++)
			 {
			 	basicCheck();
			 }
			 elapsed = getTimer() - startTime;
			 trace("Basic Check:",elapsed);*/
		}
		private function loop(e:Event):void
		{
			for(var i:int=0;i<_numBalls;i++)
			{
				checkBounds(_balls[i] as CreateCircle);
			}
			_grid.check(_balls);
			var numChecks:int = _grid.checks.length;
			for(i=0;i<numChecks;i+=2)
			{
				checkCollision(_grid.checks[i] as CreateCircle,_grid.checks[i+1] as CreateCircle);
			}
		}
		private function checkBounds(ball:CreateCircle):void
		{
			var b:CreateCircle = ball;
			ball.x += ball._object.vx;
			ball.y += ball._object.vy;
			if(ball.x < RADIUS)
			{
				ball.x = RADIUS;
				ball._object.vx *= -1;
			}
			else if(ball.x > stage.stageWidth - RADIUS)
			{
				ball.x = stage.stageWidth - RADIUS;
				ball._object.vx *= -1;
			}
			if(ball.y < RADIUS)
			{
				ball.y = RADIUS;
				ball._object.vy *= -1;
			}
			else if(ball.y > stage.stageHeight - RADIUS)
			{
				ball.y = stage.stageHeight - RADIUS;
				ball._object.vy *= -1;
			}
			ball.color = 0;
		}
	}
}