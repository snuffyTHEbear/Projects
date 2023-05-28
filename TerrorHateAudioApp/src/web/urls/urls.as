package web.urls
{
	public class urls
	{
		public static const MP3_PLAYLIST_NAME:String = "Terrohate_GreatNorthernTrendKill.xml";
		//CUBE_FACE_A/B/C/D/E/F - SMALL - LARGE
		public static const JPG_NAMES:Array = new Array("GNTK_AA","GNTK_BACK","GNTK_EP_NOTES");
		public static const BASE_URL:String = "http://arctic-code.com/Audio/Apps/TH_GNT/";
		public static const ZIP_NAME:String = "http://arctic-code.com/Audio/Zips/Terrorhate - Great Northern Trenkill.rar";
		
		public static function get playlistURL():String
		{
			return BASE_URL + MP3_PLAYLIST_NAME;
		}
		public static function get baseURL():String
		{
			return BASE_URL;
		}
		public function get jpgNames():Array
		{
			return JPG_NAMES;
		}
	}
}