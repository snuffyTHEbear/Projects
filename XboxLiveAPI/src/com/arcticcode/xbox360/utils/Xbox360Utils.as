package com.arcticcode.xbox360.utils
{
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 *
	 * Provides a means to retrieve Xbox live Gamertag Avatar images (full body and gamer picture)
	 * @author Robert Daniels
	 *
	 */
	public class Xbox360Utils
	{
		public static const NXE_BLUE:uint = 0x313F49;
		
		public static const REPUTATION_BACKGROUND_COLOR:uint = 0x757575;
		
		public static var AVATAR_URL:String = "http://avatar.xboxlive.com/avatar/";
		
		public static var AVATAR_BODY_IMAGE:String = "/avatar-body.png";
		
		public static var AVATAR_PIC_IMAGE:String = "/avatarpic-l.png";
		
		public static var GAMERSCORE_ICON_URL:String = "http://www.xbox.com/xweb/lib/images/MyXbox/gamerscore_icon.png";
		
		//http://duncanmackenzie.net/Blog/using-my-xbox-live-data-service
		public static const XBOX_360_API:String = "http://xboxapi.duncanmackenzie.net/gamertag.ashx?GamerTag=";
		
		public static function getGamertagXML(gamertag:String):String
		{
			return XBOX_360_API + gamertag;
		}
		
		public static function getAvatarBodyURL(gamertag:String):String
		{
			return(AVATAR_URL + gamertag + AVATAR_BODY_IMAGE);
		}
		
		public static function getGamerPic(gamertag:String):String
		{
			return(AVATAR_URL + gamertag + AVATAR_PIC_IMAGE);
		}
		
		/**
		 *
		 * @param text - String to show in the TextField
		 * @param x - position on the x axis
		 * @param y - position on the y axis
		 * @return - TextField
		 *
		 */
		public static function setupTextField(text:String, x:Number, y:Number, color:uint = 0xFFFFFF, textFormat:TextFormat = null):TextField
		{
			var tf:TextField = new TextField();
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.embedFonts = true;
			tf.defaultTextFormat = textFormat;
			tf.textColor = color;
			tf.selectable = false;
			tf.antiAliasType = AntiAliasType.ADVANCED;
			tf.text = text;
			tf.x = x;
			tf.y = y;
			return tf;
		}
	}
}