package
{
	import de.nulldesign.nd3d.geom.Vertex;
	import de.nulldesign.nd3d.material.LineMaterial;
	import de.nulldesign.nd3d.objects.Line3D;
	import de.nulldesign.nd3d.view.AbstractView;
	
	import flash.events.Event;
	
	[SWF(width=600,height=400,backgroundColor=0x000000)]
	public class Lines extends AbstractView
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;	
		private var line:Line3D;
		
		public function Lines()
		{
			super(600,400);
			init();
		}
		private function init():void
		{
			for(var inc:uint=0;inc<10;inc++)
			{
				var l:Line3D = new Line3D(new Vertex(ranNum(),ranNum(),ranNum()),new Vertex(ranNum(),ranNum(),ranNum()),new LineMaterial(Math.random()*0xffffff,1,1,false,false));
				renderList.push(l);
			}
			
			//line = new Line3D(new Vertex(-300,0,0),new Vertex(300,0,0),new LineMaterial(0xffffff,1,2,false,false));
			//renderList.push(line);
		}
		private function ranNum():Number
		{
			return Math.random()*200-100;
		}
		override protected function loop(e:Event):void
		{
			renderer.render(renderList,cam);
			/* line.angleX += (centreY - mouseY) * .0005;
			line.angleY += (centreX - mouseX) * .0005; */
			
			/* cam.angleX += (centreY - mouseY) * .0007;
			cam.angleY += (centreX - mouseX) * .0007;  */
			
			cam.angleX += .067;
			cam.angleY += .039;
		}
	}
}