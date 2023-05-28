package
{
	import com.arcticcode.greenFlames.graphics.CreateCircle;
	import com.bit101.components.Text;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width=600,height=400,backgroundColor=0xffffff)]
	public class MathographicsExp extends Sprite
	{
		private var angle:Number=0.1;
		private var circle:CreateCircle;
		private var centreY:Number = stage.stageHeight*0.5;
		private var centreX:Number = stage.stageWidth*0.5;
		private var speed:Number=0.1;
		private var n:Number=1;
		private var cont:Sprite;
		private var d:Number = (Math.PI*2)/6;
		//
		private var input:Text;
		
		public function MathographicsExp()
		{
			init();
		}
		private function init():void
		{
			cont = new Sprite();
			cont.x = centreX;
			cont.y = centreY;addChild(cont);
			//cont.graphics.beginFill(Math.random()*0xffffff);
			cont.graphics.lineStyle(0);
			
			//init();
			//loop();
			//star(180);
			//eSpiral(180,600);
			
			for(var i:uint=0;i<1000;i++)
			{
				//archimedes
				//var r:Number = (5*(angle / 2));
				//equiangular
				//var r:Number = Math.pow(1.09,angle);
				//fermat
				var r:Number = Math.sqrt(5*(2/angle))*25;
				//
				//Daisies
				//var r:Number = Math.sqrt(angle)*6;
				//
				var X:Number = r*Math.sin(angle);
				var Y:Number = r*Math.cos(angle);
				i==0 ? cont.graphics.moveTo(X,Y) : cont.graphics.lineTo(X,Y);
				//cont.graphics.drawCircle(X,Y,5);
				angle += speed;
			}
			//cont.graphics.drawCircle(X,Y,5);
			
		}
		private function eSpiral(count:uint=3,turns:uint=90):void
		{
			for(var i:uint=1;i<turns;i++)
			{
				var r:Number = 2*angle;
				i==1 ? cont.graphics.moveTo(200*Math.cos(r),200*Math.sin(r)) : cont.graphics.lineTo(200*Math.cos(r),200*Math.sin(r));
				angle += count;
			}
		}
		private function star(numPoints:uint):void
		{
			var num:uint = Math.floor(Math.random()*numPoints+1);
			for(var i:uint=0;i<numPoints;i++)
			{
				var a:Number = 360 * i * num / numPoints;
				
				i==0 ? cont.graphics.moveTo(50*Math.cos(a),50*Math.sin(a)) : cont.graphics.lineTo(50*Math.cos(a),50*Math.sin(a));
			}
		}
		private function loop():void
		{
			//graphics.lineStyle(0,0);
			for(var i:Number=0;i<360;i+=360/60)
			{
				trace(i);
				if(i==0)
				{
					cont.graphics.moveTo(50*Math.cos(i),50*Math.sin(i));
				}
				else
				{
					cont.graphics.lineTo(50*Math.cos(i),50*Math.sin(i));
				}
			}
		}
		private function init2():void
		{
			//circle = new CreateCircle(10,0,Math.random()*0xffffff,1);
			circle = new CreateCircle(10, true, true, Math.random() * 0xFFFFFF, 1, 1, 0, 1);
			circle.y = centreY;
			addChild(circle);
			
			graphics.lineStyle(0,0);
			graphics.moveTo(circle.x,circle.y);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(e:Event):void
		{
			//page 123+ Mathographics
			circle.x += speed*4;
			graphics.lineTo(circle.x,circle.y);
			//Compund wave
			//var Y:Number = (Math.sin(angle)) + (Math.sin(2*angle)) + (Math.sin(3*angle));
			var Y:Number = Math.PI/(7+(1.57-angle));
			circle.y = ( (Y) ) + centreY;
			angle += speed;
		}
	}
}