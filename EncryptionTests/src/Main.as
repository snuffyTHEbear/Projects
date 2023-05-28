package {
	import com.arcticcode.greenFlames.array.ArrayUtils;
	
	import flash.display.Sprite;

	public class Main extends Sprite
	{		
		private var bytes:Array = new Array("1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z","A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", " ");
		private var bytesEncrypted:Array = new Array();		
		public function Main()
		{
			var str:String = "Hello World 2009";
			
			for(var i:uint=0;i<bytes.length;i++)
			{
				var s:String = i.toString();
				if(s.length == 1)
				{
					s = "0" + s + "00";
				}
				else if(s.length==2)
				{
					s = "0" + s + "0";
				}
				else
				{
					s = "0" + s;
				}
				bytesEncrypted.push(s);
			}
			
			bytesEncrypted = ArrayUtils.manualShuffle(bytesEncrypted);
			
			for(i=0;i<bytesEncrypted.length;i++)
			{
				trace("\""+bytesEncrypted[i]+"\",");
			}
			
		}
		private function encrypt(val:String):String
		{
			var string:String = "";
			var len:uint = val.length;
			
			for(var i:uint = 0;i < len;i++)
			{
				string += bytesEncrypted[bytes.indexOf(val.charAt(i).toLowerCase())];
			}
			
			return string;
		}
		private function decrypt(val:String):String
		{
			var string:String = "";
			var len:uint = val.length;
			
			for(var i:uint = 0;i<len;i+=4)
			{
				var str:String = val.substring(i,i+4);
				string += bytes[bytesEncrypted.indexOf(str)];
			}
			
			return string;
		}
	}
}
