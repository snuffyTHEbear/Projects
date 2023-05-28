package
{
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.NetStreamPlayOptions;
	import flash.net.NetStreamPlayTransitions;

	public class LiveStream extends EventDispatcher
	{
		private var _stream:NetStream;
		private var _nso:NetStreamPlayOptions;
		private var _sound:Sound;
		private var _url:String;
		
		public function LiveStream(url:String="")
		{
			_url = url;
			_nso = new NetStreamPlayOptions();
			_nso.transition = NetStreamPlayTransitions.SWITCH;
			_nso.streamName = _url;
			_stream = new NetStream(new NetConnection(),NetStream.DIRECT_CONNECTIONS);
			_stream.bufferLength = 2500;
		}
		public function load():void
		{
			
		}
		public function close():void
		{
			
		}
		public function clearBuffer():void
		{
			_stream.play2(_nso);
		}
	}
}