package {
	import caurina.transitions.Tweener;
	
	import com.arcticcode.greenFlames.xPreloader.XPreloader;
	
	import flash.display.BitmapData;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.Security;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.view.BasicView;
	
	import visual.audio.AudioPlayer;
	import visual.cube.CreateCube;
	
	import web.urls.urls;
	
	[SWF(width=600,height=400,backgroundColor=0x000000)]
	public class Main extends BasicView
	{
		private var centreX:Number = stage.stageWidth * 0.5;
		private var centreY:Number = stage.stageHeight * 0.5;
		private var imageLoader:XPreloader=new XPreloader("",XPreloader.IMAGE,false);
		private var dataLoader:XPreloader;
		private var cont:DisplayObject3D;
		private var _rotateFree:Boolean = false;
		private var _dloadBtn:downloadZIPButton;
		private var _isOrbit:Boolean = false;
		private var _cube:CreateCube;
		private var _cubeRotate:Boolean = true;
		private var _playlist:XMLList;
		private var _u:Font = new _unfin();
		private var _tf:TextField;
		private var _playlistIndex:uint = 1;
		private var _player:AudioPlayer = new AudioPlayer(_u);
		private var _largeImage:BitmapMaterial;
		private var _thumbA:THUMB_A=new THUMB_A();
		private var _thumbB:THUMB_B=new THUMB_B();
		private var _thumbC:THUMB_C=new THUMB_C();
		private var _artworkBtn:viewArtworkButton = new viewArtworkButton();
		private var _closeImageBtn:closeImage = new closeImage();
		private var _scrollInfo:scrrolToZoom = new scrrolToZoom();
		private var _plane:Plane;
		private var _ds:DropShadowFilter = new DropShadowFilter(1,90,0,1,3,3,0.85,3,false,false,false);
		private var _bmat:BitmapMaterial;
		private var _ac_link:authorLink = new authorLink();
		private var _fs_info:fullbrowserInfo = new fullbrowserInfo();
		public function Main()
		{
			Security.allowInsecureDomain("http://arctic-code.com/");
			Font.registerFont(_unfin);
			init();
		}
		private function init():void
		{
			cont = new DisplayObject3D();
			scene.addChild(cont);
			
			_cube = new CreateCube();
			cont.addChild(_cube.cube);
						
			viewport.interactive = true;
			viewport.buttonMode = true;
			
			_tf = new TextField();
			_tf.embedFonts = true;
			_tf.autoSize = "left";
			_tf.defaultTextFormat = new TextFormat(_u.fontName,20,0xff6600,false,false,false,null,null,"center");
			_tf.text = "Terrorhate presents\nGreat Northern Trendkill";
			addChild(_tf);
			_tf.filters = [_ds];
			_tf.selectable = false;
			_tf.x = stage.stageWidth * 0.5 - _tf.width * 0.5;
			
			dataLoader = new XPreloader(urls.playlistURL,XPreloader.XML,false);
			dataLoader.addEventListener(Event.COMPLETE, loaded);
			dataLoader.addEventListener(ProgressEvent.PROGRESS, progress);
			dataLoader.load();
			
			_dloadBtn = new downloadZIPButton();
			_dloadBtn.x = stage.stageWidth-_dloadBtn.width/2 - 5;
			_dloadBtn.y = stage.stageHeight-_dloadBtn.height/2-5;
			addChild(_dloadBtn);
			
			_ac_link.x = stage.stageWidth - _ac_link.width/2;
			_ac_link.y = _ac_link.height/2;
			addChild(_ac_link);
			_ac_link.addEventListener(MouseEvent.CLICK, onACOpen);
			_ac_link.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			_ac_link.addEventListener(MouseEvent.MOUSE_OUT, onOut);
			
			_fs_info.x = stage.stageWidth - _fs_info.width/2;
			_fs_info.y = _ac_link.y + _ac_link.height/2 + _fs_info.height + 10;
			_fs_info.addEventListener(MouseEvent.CLICK, onFullscreen);
			_fs_info.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			_fs_info.addEventListener(MouseEvent.MOUSE_OUT, onOut);
			//addChild(_fs_info);
						
			addChild(_player);
			_player.x = stage.stageWidth * 0.5
			_player.y = stage.stageHeight - _player.height / 2 + 10;
			
			_thumbA.y = stage.stageHeight*0.5 - 75;
			_thumbA.x = 35;
			_thumbA.name = urls.JPG_NAMES[0] + "_SMALL";
			_thumbB.x = 35;
			_thumbB.y = stage.stageHeight*0.5;
			_thumbB.name = urls.JPG_NAMES[1] + "_SMALL";
			_thumbC.x = 35;
			_thumbC.y = stage.stageHeight*0.5 + 75;
			_thumbC.name = urls.JPG_NAMES[2] + "_SMALL";
			
			_artworkBtn.x = _artworkBtn.height*0.5 + 75;
			_artworkBtn.y = stage.stageHeight * 0.5;
			_artworkBtn.rotation = -90;
			_artworkBtn.enabled = false;
			addChild(_artworkBtn);
			
			_scrollInfo.x = stage.stageWidth * 0.5;
			_scrollInfo.y = _tf.height + 10;
			addChild(_scrollInfo);
			//_scrollInfo.visible = false;
			
			_closeImageBtn.x = stage.stageWidth * 0.5;
			_closeImageBtn.y = 400;
			addChild(_closeImageBtn);
			_closeImageBtn.visible = false;
			
			_closeImageBtn.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			_closeImageBtn.addEventListener(MouseEvent.MOUSE_OUT, onOut);
			_closeImageBtn.addEventListener(MouseEvent.CLICK, onCloseImage);
			
			imageLoader.addEventListener(Event.COMPLETE, imageLoaded);
			imageLoader.addEventListener(ProgressEvent.PROGRESS,progress);
			
			_bmat = new BitmapMaterial(new BitmapData(700,700,false,0xffffff),true);
			_bmat.interactive = true;
			//_bmat.doubleSided = true;
			_bmat.smooth = true;
			_plane = new Plane(_bmat,700,700,4,4);
			//_plane.z = -400;
			_plane.x = -700;
			_plane.y = 500;
			_plane.visible = false;
			scene.addChild(_plane);
			
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, onScroll);
			
			createThumbs(_thumbA,_thumbB,_thumbC);
			singleRender();
		}
		private function onACOpen(e:MouseEvent):void
		{
			navigateToURL(new URLRequest("http://arctic-code.com/blog"),"_blank");
		}
		private function onFullscreen(e:MouseEvent):void
		{
			stage.displayState = StageDisplayState.FULL_SCREEN;
		}
		private function createThumbs(...rest):void
		{
			for(var inc:uint=0;inc<rest.length;inc++)
			{
				rest[inc].addEventListener(MouseEvent.MOUSE_OVER, onOver);
				rest[inc].addEventListener(MouseEvent.CLICK, onThumbClick);
				rest[inc].addEventListener(MouseEvent.MOUSE_OUT, onOut);
				addChild(rest[inc]);
			}
		}
		private function onThumbClick(e:MouseEvent):void
		{
			_cubeRotate = false;
			//loadBitmap();
			loadBitmap(urls.BASE_URL+e.target.name+".jpg");
		}
		private function loadBitmap(val:String):void
		{
			imageLoader.loadURL(val,XPreloader.IMAGE,true);
		}
		private function imageLoaded(e:Event):void
		{
			//_plane = new Plane(new BitmapMaterial(e.target.content.bitmapData as BitmapData,true),450,450,4,4);
			//_bmat.destroy();
			_bmat.bitmap.draw(e.target.content);
			//_bmat = new BitmapMaterial(e.target.content.bitmapData as BitmapData,true);
			
			updatePlane();
		}
		private function updatePlane():void
		{
			//scene.removeChild(_cube.cube);
			Tweener.addTween(_cube.cube, {rotationX:0,rotationY:0,rotationZ:0,x:-600,y:300,z:0,time:2.3});
			//scene.addChild(_plane);
			_plane.visible = true;
			Tweener.addTween(_plane,{z:-400,x:0,y:0,time:1.4});
			//stage.addEventListener(MouseEvent.MOUSE_WHEEL, onScroll);
			//_scrollInfo.visible = true;
			_closeImageBtn.visible = true;
		}
		private function onCloseImage(e:MouseEvent):void
		{
			Tweener.addTween(_cube.cube, {rotationX:0,rotationY:0,rotationZ:0,x:0,y:0,z:0,time:1.7});
			_cubeRotate = true;
			Tweener.addTween(_plane,{z:0,x:-700,y:500,time:0.6});
			_plane.visible = false;
			//_scrollInfo.visible = false;
			_closeImageBtn.visible = false;
			//stage.removeEventListener(MouseEvent.MOUSE_WHEEL, onScroll);
		}
		private function onScroll(e:MouseEvent):void
		{
			if(_cubeRotate && _cube.cube.z - (e.delta*3) > -650 && _cube.cube.z - (e.delta*3) < 200)
			{
				_cube.cube.z -= (e.delta*3);
			}
			else if(_plane.z - (e.delta*3) > -700 && _plane.z - (e.delta*3) < 450)
			{
				_plane.z -= (e.delta*3);
			}
		}
		private function onOver(e:MouseEvent):void
		{
			e.target.filters = [new GlowFilter(0xff6600,1,3,3,0.85,3,false,false)];
		}
		private function onOut(e:MouseEvent):void
		{
			e.target.filters = [];
		}
		private function onDLoad(e:MouseEvent):void
		{
			navigateToURL(new URLRequest(urls.ZIP_NAME),"_blank");
		}
		override public function singleRender():void
		{
			super.singleRender();
			addEventListener(Event.ENTER_FRAME, onRenderTick);
		}
		override protected function onRenderTick(event:Event=null):void
		{
			if(_cubeRotate)
			{
				//_cube.cube.rotationX += 3.7;
				//_cube.cube.rotationY += 2.3;
				_cube.cube.rotationY += (stage.stageWidth * 0.5 - viewport.mouseX) * .01;
				_cube.cube.rotationX += (stage.stageHeight * 0.5 - viewport.mouseY) * .01;
				_cube.cube.rotationZ += 1.6;
			}
			else if(!_cubeRotate && !Tweener.isTweening(_plane))
			{
				_plane.rotationY = (stage.stageWidth * 0.5 - viewport.mouseX) * .1;
				_plane.rotationX = (stage.stageHeight * 0.5 - viewport.mouseY) * .1;
			}
			super.onRenderTick(event);
		}
		private function loaded(e:Event):void
		{
			_playlist = new XMLList(e.target.content);
			for each(var track:String in _playlist.*.@name)
			{
				
			}
			_player.playlist = _playlist;
			
		}
		private function progress(e:ProgressEvent):void
		{
			var p:Number = e.bytesLoaded / e.bytesTotal;
		}
	}
}
