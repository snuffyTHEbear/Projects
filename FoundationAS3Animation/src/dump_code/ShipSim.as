package{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import robDaniels.greenFlames.src.graphics.AsteroidShip;
	
	public class ShipSim extends Sprite{
				
		private var ship:AsteroidShip;
		private var vr:Number = 0;
		private var thrust:Number = 0;
		private var vx:Number = 0;
		private var vy:Number = 0;
		private var friction:Number = 0.97;
		
		public function ShipSim(){
			init();
		}
		private function init():void{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;	
			ship = new AsteroidShip();
			addChild(ship);
			ship.x = stage.stageWidth / 2;
			ship.y = stage.stageHeight / 2;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		private function onKeyDown(event:KeyboardEvent):void{
			switch(event.keyCode)
			{
				case Keyboard.LEFT:
				vr = -5;
				break;
				
				case Keyboard.RIGHT:
				vr = 5;
				break;
				
				case Keyboard.UP:
				thrust = 0.2;
				ship.draw(true);
				break;
				
				default:
				break;
			}
		}
		private function onKeyUp(event:KeyboardEvent):void{
			if(event.keyCode != Keyboard.UP){
				vr = 0;
			}else{
				vr = 0;
				thrust = 0;
				ship.draw(false);
			}
		}
		private function onEnterFrame(event:Event):void{
			ship.rotation += vr;
			var angle:Number = ship.rotation * Math.PI / 180;
			var ax:Number = Math.cos(angle) * thrust;
			var ay:Number = Math.sin(angle) * thrust;
			vx += ax;
			vy += ay;
			vx *= friction;
			vy *= friction;
			ship.x += vx;
			ship.y += vy;
			var top:Number = 0;
			var bottom:Number = stage.stageHeight;
			var left:Number = 0;
			var right:Number = stage.stageWidth;
			if(ship.x - ship.width / 2 > right)
			{
				ship.x = left - ship.width / 2;
			}
			else if(ship.x + ship.width < left)
			{
				ship.x = right + ship.width / 2;
			}
			if(ship.y - ship.height / 2 > bottom)
			{
				ship.y = top - ship.height / 2;
			}
			else if(ship.y + ship.height < top)
			{
				ship.y = bottom + ship.height / 2;
			}
		}
	}
}