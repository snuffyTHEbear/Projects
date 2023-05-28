package
{
	import com.arcticcode.greenFlames.graphics.Tooltip;
	
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class BasicCaption extends Sprite
	{
		private var cap:Sprite;
		private var tf:TextField;
		private var tt:Tooltip;
		public function BasicCaption()
		{
			init();
		}
		private function init():void
		{
			tt = new Tooltip("tooltip\ntooltip");
			addChild(tt);
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		private function test():void
		{
			cap = new Sprite();
			tf = new TextField();
			tf.defaultTextFormat = new TextFormat("Verdana",10,0xffffff);
			tf.autoSize = TextFieldAutoSize.CENTER;
			tf.text = "My Value";
			cap.addChild(tf);
			tf.x = -tf.width/2;
			tf.y = -tf.height/2;
			cap.graphics.lineStyle(4,0,1,false,"normal",CapsStyle.ROUND,JointStyle.ROUND);
			cap.graphics.beginFill(0,1);
			cap.graphics.moveTo(-tf.width/2,-tf.height/2);
			cap.graphics.lineTo(tf.width/2,-tf.height/2);
			cap.graphics.lineTo(tf.width/2,tf.height/2);
			cap.graphics.lineTo(tf.height/2,tf.height/2);
			cap.graphics.lineTo(0,tf.height+(tf.height/4));
			cap.graphics.lineTo(-tf.height/2,tf.height/2);
			cap.graphics.lineTo(-tf.width/2,tf.height/2);
			cap.graphics.lineTo(-tf.width/2,-tf.height/2);
			cap.graphics.endFill();
			addChild(cap);
			cap.x = 200;
			cap.y = 200;
			
			//stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		private function onMouseMove(e:MouseEvent):void
		{
			tt.x = mouseX;
			tt.y = mouseY;;
			e.updateAfterEvent();
		}
	}
}