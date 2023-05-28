////////////////////////////////////////////////////////////////////////////////
//   Robert Daniels - http://arctic-code.com 
////////////////////////////////////////////////////////////////////////////////

package com.arcticcode.xbox360
{
	import com.arcticcode.xbox360.display.SimpleXboxGameInfo;
	import com.arcticcode.xbox360.utils.GamertagPositions;
	import com.arcticcode.xbox360.utils.Xbox360Utils;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filters.DropShadowFilter;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * Xbox360 AS3
	 * @author Robert Daniels - http://arctic-code.com/blog
	 *
	 * Acknowledgements
	 * Duncan Mackenzie for the Xbox Live Data Service for which this was not possible
	 * http://duncanmackenzie.net/Blog/using-my-xbox-live-data-service
	 *
	 */
	public class GamerCard extends MovieClip
	{
		
		/**
		 *Large
		 */
		public static const LARGE:String = "large";
		/**
		 *Small
		 */
		public static const SMALL:String = "small";
		
		/**
		 *
		 * @param gamertag - The Xbox Live gamertag
		 * @param gamertagReady - Called when the gamertag is ready
		 * @param size - Size of the gamertag either 'small' or 'large'
		 *
		 */
		public function GamerCard( gamertag:String, gamertagReady:Function = null, size:String = "small" )
		{
			_size = size;
			GamertagReady = gamertagReady;
			
			_defaultTextFormat = new TextFormat( 'X360 by Redge', 12, 0xFFFFFF );
			
			_xmlLoader = new URLLoader();
			_xmlLoader.addEventListener( Event.COMPLETE, loaderComplete_Handler );
			_xmlLoader.addEventListener( IOErrorEvent.IO_ERROR, loaderError_Handler );
			_imageLoader = new Loader();
			_imageLoader.contentLoaderInfo.addEventListener( Event.COMPLETE, loaderComplete_Handler );
//			_imageLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			_imageLoader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, loaderError_Handler );
			
			setupLoader( Xbox360Utils.getGamertagXML( gamertag ), GAMERTAG, true);
		}
		
		public var GamertagReady:Function;
		private const AVATAR_BODY:String = "Avatar Body";
		
		private const GAMERTAG:String = "gamertag";
		private const GAMER_PIC:String = "Gamer Pic";
		
		[Embed( source='assets/GamerscoreIconLarge.png', mimeType='image/png' )]
		private var GamerscoreIconLarge:Class;
		
		[Embed( source='assets/GamerscoreIconSmall.png', mimeType='image/png' )]
		private var GamerscoreIconSmall:Class;
		
		//552 x 318
		[Embed( source='assets/GamertagBackgroundLarge.png', mimeType='image/png' )]
		private var GamertagBackgroundLarge:Class;
		
		//250 x 144
		[Embed( source='assets/GamertagBackgroundSmall.png', mimeType='image/png' )]
		private var GamertagBackgroundSmall:Class;
		
		[Embed( source='assets/GoldCrown.png', mimeType='image/png' )]
		private var GoldCrown:Class;
		private const REPUTATION:String = "Reputation";
		
		
		//http://www.dafont.com/x360.font
		//In Flash Builder 4 add this to compiler options for font to embed correctly:
		//-managers flash.fonts.AFEFontManager
		[Embed( source='/assets/X360.ttf', fontName='X360 by Redge', mimeType='application/x-font-truetype' )]
		private var X360Font:Class;
		
		private var _avatar:Bitmap;
		
		private var _bg:Bitmap;
		
		private var _defaultTextFormat:TextFormat;
		
		private var _gamerscoreIcon:Bitmap;
		
		private var _gamerscoreTF:TextField;
		
		private var _gamertag:String;
		
		private var _gamertagTF:TextField;
		
		private var _imageLoader:Loader;
		
		private var _loaderDescription:String;
		
		private var _presence:XMLList;
		
		private var _presenceTF:TextField;
		
		private var _recentGames:XMLList;
		
		private var _reputationIcon:Bitmap;
		
		private var _shadowBlack:DropShadowFilter = new DropShadowFilter( 3.0, 45, 0, 0.9, 13.0, 13.0, 1.0, 3.0 );
		
		private var _shadowWhite:DropShadowFilter = new DropShadowFilter( 0, 45, 0xFFFFFF, 0.9, 0.9, 0.9, 1.0, 3.0 );
		
		private var _size:String;
		
		private var _statusTF:TextField;
		
		private var _urlRequest:URLRequest;
		
		private var _xml:XML;
		
		private var _xmlLoader:URLLoader;
		
		/**
		 *
		 * @param x - position on the x axis
		 * @param y - position on the y axis
		 *
		 */
		public function move( x:Number, y:Number ):void
		{
			this.x = x;
			this.y = y;
		}
		
		/**
		 *
		 * @return - size of the gamertag
		 *
		 */
		public function get size():String
		{
			return _size;
		}
		
		/**
		 *
		 * @param value - size of the gamertag
		 *
		 */
		public function set size( value:String ):void
		{
			_size = value;
			initGamertag();
		}
		
		/**
		 *Builds the large gamertag
		 *
		 */
		private function buildGamertagLarge():void
		{
			_bg = new GamertagBackgroundLarge();
			
			_gamertagTF = Xbox360Utils.setupTextField( _gamertag, 0, 0, 0xFFFFFF, _defaultTextFormat );
			
			setupLoader( Xbox360Utils.getAvatarBodyURL( _gamertag ), AVATAR_BODY, false);
		}
		
		/**
		 *builds the small gamertag
		 *
		 */
		private function buildGamertagSmall():void
		{
			_bg = new GamertagBackgroundSmall();
			
			_gamertagTF = Xbox360Utils.setupTextField( _gamertag, 0, 0, 0xFFFFFF, _defaultTextFormat );
			
			_gamerscoreIcon = new GamerscoreIconSmall();
			
			_gamerscoreTF = Xbox360Utils.setupTextField( _xml.GamerScore, 0, 0, 0xFFFFFF, _defaultTextFormat );
			var online:Boolean = _presence.Online == "true";
			_statusTF = Xbox360Utils.setupTextField( _presence.StatusText, 0, 0, online ? 0x00CC00 : 0xCC0000, _defaultTextFormat );
			
			setupLoader( Xbox360Utils.getGamerPic( _gamertag ), GAMER_PIC, false);
		}
		
		private function gameInfoReady( sxgi:SimpleXboxGameInfo ):void
		{
			addChild( sxgi );
			sxgi.x = GamertagPositions.SXGI_SMALL_X[ sxgi.number ];
			sxgi.y = GamertagPositions.SXGI_SMALL_Y;
		}
		
		private function getGameInfoSmall():void
		{
			var i:uint = 0;
			
			for each ( var gameInfo:XML in _recentGames.XboxUserGameInfo )
			{
				var sxgi:SimpleXboxGameInfo = new SimpleXboxGameInfo( gameInfo.Game.Name, gameInfo.Game.Image32Url, i, gameInfoReady );
				i++;
				
				if ( i == 5 )
				{
					break;
				}
			}
		}
		
		/**
		 *
		 *
		 */
		private function initGamertag():void
		{
			scrap();
			
			if ( _size == LARGE )
				buildGamertagLarge();
			else
				buildGamertagSmall();
			
			_bg.x -= _bg.width * 0.5;
			_bg.y -= _bg.height * 0.5;
			addChild( _bg );
			this.setChildIndex( _bg, 0 );
			
			this.filters = [ _shadowBlack ];
			
			if ( GamertagReady != null )
				GamertagReady();
		}
		
		/**
		 *
		 * @param e
		 *
		 */
		private function loaderComplete_Handler( e:Event ):void
		{
			switch ( _loaderDescription )
			{
				case GAMERTAG:
					_xml = new XML( _xmlLoader.data );
					parseXML();
					break;
				
				case GAMER_PIC:
					_avatar = _imageLoader.content as Bitmap;
					setupLoader( _xml.ReputationImageUrl, REPUTATION, false);
					break;
				
				case REPUTATION:
					_reputationIcon = _imageLoader.content as Bitmap;
					//addChild(_reputationIcon);
					modifyPixels( _reputationIcon.bitmapData, Xbox360Utils.REPUTATION_BACKGROUND_COLOR );
					getGameInfoSmall();
					positionGamertagSmallAssets();
					break;
				
				case AVATAR_BODY:
					_avatar = _imageLoader.content as Bitmap;
					//_avatar.x += _avatar.width - 10;
					//_avatar.y -= _avatar.height * 0.5;
					positionGamertagLargeAssets();
					break;
			}
		}
		
		/**
		 *Handles any errors thrown in loading content
		 * @param e - IOError
		 *
		 */
		private function loaderError_Handler( e:IOErrorEvent ):void
		{
			//TODO Handler visual output of error
			trace( e.text );
		}
		
		/**
		 *Used to recolor pixels of bitmaps
		 * @param bmd - BitmapData to replace pixels with color of NXE Blue
		 * @param color - Color to replace
		 *
		 */
		private function modifyPixels( bmd:BitmapData, color:uint ):void
		{
			for ( var i:uint = 0; i < bmd.width; i++ )
			{
				for ( var j:uint = 0; j < bmd.height; j++ )
				{
					if ( bmd.getPixel( i, j ) == color )
					{
						bmd.setPixel( i, j, Xbox360Utils.NXE_BLUE );
					}
				}
			}
		}
		
		/**
		 *Parses the XML returned from the Xbox live data service
		 *
		 */
		private function parseXML():void
		{
			trace(_xml, " ::::\n");
			_presence = new XMLList( _xml.PresenceInfo );
			_recentGames = new XMLList( _xml.RecentGames );
			delete _xml.PresenceInfo;
			delete _xml.RecentGames;
			_gamertag = _xml.Gamertag;
			trace( _xml + "\n\n" + _presence );
			
			initGamertag();
		}
		
		private function positionGamertagLargeAssets():void
		{
			addChild( _avatar );
		}
		
		private function positionGamertagSmallAssets():void
		{
			_avatar.x = GamertagPositions.AVATAR_SMALL_X;
			_avatar.y = GamertagPositions.AVATAR_SMALL_Y;
			_gamertagTF.x = GamertagPositions.GAMERTAG_TF_SMALL_X;
			_gamertagTF.y = GamertagPositions.GAMERTAG_TF_SMALL_Y;
			_gamerscoreIcon.x = GamertagPositions.GAMERSCORE_ICON_SMALL_X;
			_gamerscoreIcon.y = GamertagPositions.GAMERSCORE_ICON_SMALL_Y;
			_gamerscoreTF.x = GamertagPositions.GAMERSCORE_TF_SMALL_X;
			_gamerscoreTF.y = GamertagPositions.GAMERSCORE_TF_SMALL_Y;
			_reputationIcon.x = GamertagPositions.REPUTATION_SMALL_X;
			_reputationIcon.y = GamertagPositions.REPUTATION_SMALL_Y;
			_statusTF.x = GamertagPositions.STATUS_TF_SMALL_X;
			_statusTF.y = GamertagPositions.STATUS_TF_SMALL_Y;
			addChild( _avatar );
			addChild( _gamerscoreTF );
			addChild( _gamerscoreIcon );
			addChild( _reputationIcon );
			addChild( _statusTF );
			addChild( _gamertagTF );
			//Add all children when positioned correctly
		}
		
		/**
		 *
		 *
		 */
		private function scrap():void
		{
			this.filters = [];
			
			while ( this.numChildren > 0 )
			{
				this.removeChildAt( this.numChildren - 1 );
			}
		}
		
		private function setupLoader( url:String, description:String, data:Boolean = true ):void
		{
			if ( data )
			{
				_urlRequest = new URLRequest( url );
				_loaderDescription = description;
				_xmlLoader.load( _urlRequest );
			}
			else
			{
				_urlRequest = new URLRequest( url );
				_loaderDescription = description;
				_imageLoader.load( _urlRequest, null );
			}
		}
	}
}