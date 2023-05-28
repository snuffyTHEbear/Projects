
/**
 * This is a generated class and is not intended for modfication.  To customize behavior
 * of this service wrapper you may modify the generated sub-class of this class - TwitterSearch.as.
 */
package services.twittersearch
{
import mx.rpc.AsyncToken;
import fr.core.model_internal;
import mx.rpc.AbstractOperation;
import services.twittersearch.Tweet
import fr.services.wrapper.HTTPServiceWrapper;
import mx.rpc.http.HTTPMultiService;
import mx.rpc.http.Operation;
import com.adobe.serializers.xml.XMLSerializationFilter;
[ExcludeClass]
internal class _Super_TwitterSearch extends HTTPServiceWrapper
{      
    private static var serializer0:XMLSerializationFilter = new XMLSerializationFilter();
       
    // Constructor
    public function _Super_TwitterSearch()
    {
        // initialize service control
        _serviceControl = new HTTPMultiService(); 
         var operations:Array = new Array();
         var operation:Operation;  
         var argsArray:Array;       
         
         operation = new Operation(null, "GetTweets");
         operation.url = "http://search.twitter.com/search.atom";
         operation.method = "GET";
         argsArray = new Array("q");
         operation.argumentNames = argsArray;         
         operation.serializationFilter = serializer0;
         operation.properties = new Object();
         operation.properties["xPath"] = "/::entry";
		 operation.resultElementType = Tweet;
         operations.push(operation);
    
         _serviceControl.operationList = operations;  

    
                      
         model_internal::initialize();
    }

	/**
	  * This method is a generated wrapper used to call the 'GetTweets' operation. It returns an AsyncToken whose 
	  * result property will be populated with the result of the operation when the server response is received. 
	  * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
	  * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
      *
      * @see mx.rpc.AsyncToken
      * @see mx.rpc.CallResponder 
      *
      * @return an AsyncToken whose result property will be populated with the result of the operation when the server response is received.
	  */          
	public function GetTweets(q:String) : AsyncToken
	{
		var _internal_operation:AbstractOperation = _serviceControl.getOperation("GetTweets");
		var _internal_token:AsyncToken = _internal_operation.send(q) ;

		return _internal_token;
	}   

}

}
