/*package AdvancedPhysics
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;

	public class VerletStage extends Sprite
	{
		private var _constraints:Rectangle;
		private var _points:Vector.<VerletPoint> = new Vector.<VerletPoint>();
		private var _sticks:Vector.<VerletStick> = new Vector.<VerletStick>();
		private var stageW:Number;
		private var stageH:Number;
		private var centreX:Number;
		private var centreY:Number;
		private var _velocities:Vector.<Object> = new Vector.<Object>();
		
		public function VerletStage()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void
		{
			stageW = stage.stageWidth;
			stageH = stage.stageHeight;
			centreX = stageW * 0.5;
			centreY = stageH * 0.5;
			
			_constraints = Verlet.makeConstraints(stageW,stageH);

			for(var i:int = -15;i<15;i++)
			{
				Verlet.makePoint(Math.cos(i*Math.PI/60)*300+centreX, Math.sin(i*Math.PI/60)*300+centreY, _points);
				_velocities.push({x:0,y:0});
			}
			
			for(i=1;i<_points.length;i++)
			{
				_points[i].val = i + i;
				Verlet.makeStick(_points[i-1],_points[i],-1,_sticks);
			}
			
			//Verlet.makeStick(_points[i-1], _points[0], -1, _sticks);
			//Verlet.makeStick(_points[0], _points[7],-1,_sticks);
			//Verlet.makeStick(_points[12], _points[3], -1, _sticks);
			
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(e:Event):void
		{
			for(var i:int = 0;i<_velocities.length;i++)
			{
				//_velocities[i].x = Math.random() * 0.5 - 0.25;
				//_velocities[i].y = Math.random() * 0.5 - 0.25;
			}
			_velocities[0].x = Math.random() * 0.5 - 0.25;
			_velocities[0].y = Math.random() * 0.5 - 0.25;
			Verlet.completeUpdateRender(_points,_sticks,_constraints,graphics,1,_velocities);
		}
	}
}*/

package AdvancedPhysics
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;

	public class VerletStage extends Sprite
	{
		private var _square:VerletSquare;
		private var _constraints:Rectangle;
		private var _velocities:Vector.<Object> = new Vector.<Object>();
		
		public function VerletStage()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);			
		}
		private function init(e:Event):void
		{
			_constraints = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			
			var _pa:VerletPoint = new VerletPoint(10, 0);
			var _pb:VerletPoint = new VerletPoint(110, 0);
			var _pc:VerletPoint = new VerletPoint(110, 100);
			var _pd:VerletPoint = new VerletPoint(10, 100);
			
			_square = new VerletSquare(_pa, _pb, _pc, _pd, _constraints);
			_square._points[0].vx = 10;
			_square._points[3].vy = 1;
			_square._points[1].vy = 1;
			_square._points[2].vy = 1;
			_square._points[0].vy = 1;
			
			for(var i:int=0;i<4;i++)
			{
				_velocities.push({y:0.5, x:0});
			}
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(e:Event):void
		{
			_square.update(graphics,_velocities);
		}
	}
}