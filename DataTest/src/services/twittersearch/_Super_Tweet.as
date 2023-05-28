/**
 * This is a generated class and is not intended for modfication.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - Tweet.as.
 */

package services.twittersearch
{
import mx.collections.ArrayCollection;
import services.twittersearch.Author;
import services.twittersearch.Content;
import services.twittersearch.Link;
import flash.events.EventDispatcher;
import fr.core.model_internal;
import fr.vo.IPropertyIterator;
import fr.vo.IValueObject;
import fr.vo.AvailablePropertyIterator;
import fr.services.IFiberManagingService;
import mx.binding.utils.ChangeWatcher;
import mx.rpc.AbstractService;


import flash.events.Event;
import mx.events.CollectionEvent;
import mx.events.PropertyChangeEvent;


use namespace model_internal;

[ExcludeClass]
public class _Super_Tweet extends EventDispatcher implements IValueObject
{
	model_internal var _internal_model : _TweetEntityMetadata;

	/**
	 * properties
	 */
	private var _internal_id : String;		
	private var _internal_published : String;		
	private var _internal_link : ArrayCollection;		
	model_internal var _internal_link_leaf:Link;
	private var _internal_title : String;		
	private var _internal_content : Content;		
	private var _internal_updated : String;		
	private var _internal_twitter_source : String;		
	private var _internal_twitter_lang : String;		
	private var _internal_author : Author;		

    private static var emptyArray:Array = new Array();

    /**
     * derived property cache initialization
     */  
    model_internal var _cacheInitialized_isValid:Boolean = false;   
    
	model_internal var _changeWatcherArray:Array = new Array();   

	public function _Super_Tweet() 
	{	
		_model = new _TweetEntityMetadata(this);
	
		// Bind to own data properties for cache invalidation triggering  
       
	}

    /**
     * data property getters
     */
	[Bindable(event="propertyChange")] 
    public function get id() : String    
    {
            return _internal_id;
    }    
	[Bindable(event="propertyChange")] 
    public function get published() : String    
    {
            return _internal_published;
    }    
	[Bindable(event="propertyChange")] 
    public function get link() : ArrayCollection    
    {
            return _internal_link;
    }    
	[Bindable(event="propertyChange")] 
    public function get title() : String    
    {
            return _internal_title;
    }    
	[Bindable(event="propertyChange")] 
    public function get content() : Content    
    {
            return _internal_content;
    }    
	[Bindable(event="propertyChange")] 
    public function get updated() : String    
    {
            return _internal_updated;
    }    
	[Bindable(event="propertyChange")] 
    public function get twitter_source() : String    
    {
            return _internal_twitter_source;
    }    
	[Bindable(event="propertyChange")] 
    public function get twitter_lang() : String    
    {
            return _internal_twitter_lang;
    }    
	[Bindable(event="propertyChange")] 
    public function get author() : Author    
    {
            return _internal_author;
    }    

    /**
     * data property setters
     */      
    public function set id(value:String) : void 
    {    	
    	var recalcValid:Boolean = false;
    	if (value == null || _internal_id == null)
    	{
    		recalcValid = true;
    	}	
    	
    	var oldValue:String = _internal_id;               
        if (oldValue !== value)
        {
        	_internal_id = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "id", oldValue, _internal_id));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set published(value:String) : void 
    {    	
    	var recalcValid:Boolean = false;
    	if (value == null || _internal_published == null)
    	{
    		recalcValid = true;
    	}	
    	
    	var oldValue:String = _internal_published;               
        if (oldValue !== value)
        {
        	_internal_published = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "published", oldValue, _internal_published));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set link(value:ArrayCollection) : void 
    {    	
    	var recalcValid:Boolean = false;
    	if (value == null || _internal_link == null)
    	{
    		recalcValid = true;
    	}	
    	
    	var oldValue:ArrayCollection = _internal_link;               
        if (oldValue !== value)
        {
        	_internal_link = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "link", oldValue, _internal_link));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set title(value:String) : void 
    {    	
    	var recalcValid:Boolean = false;
    	if (value == null || _internal_title == null)
    	{
    		recalcValid = true;
    	}	
    	
    	var oldValue:String = _internal_title;               
        if (oldValue !== value)
        {
        	_internal_title = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "title", oldValue, _internal_title));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set content(value:Content) : void 
    {    	
    	var recalcValid:Boolean = false;
    	if (value == null || _internal_content == null)
    	{
    		recalcValid = true;
    	}	
    	
    	var oldValue:Content = _internal_content;               
        if (oldValue !== value)
        {
        	_internal_content = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "content", oldValue, _internal_content));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set updated(value:String) : void 
    {    	
    	var recalcValid:Boolean = false;
    	if (value == null || _internal_updated == null)
    	{
    		recalcValid = true;
    	}	
    	
    	var oldValue:String = _internal_updated;               
        if (oldValue !== value)
        {
        	_internal_updated = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "updated", oldValue, _internal_updated));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set twitter_source(value:String) : void 
    {    	
    	var recalcValid:Boolean = false;
    	if (value == null || _internal_twitter_source == null)
    	{
    		recalcValid = true;
    	}	
    	
    	var oldValue:String = _internal_twitter_source;               
        if (oldValue !== value)
        {
        	_internal_twitter_source = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "twitter_source", oldValue, _internal_twitter_source));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set twitter_lang(value:String) : void 
    {    	
    	var recalcValid:Boolean = false;
    	if (value == null || _internal_twitter_lang == null)
    	{
    		recalcValid = true;
    	}	
    	
    	var oldValue:String = _internal_twitter_lang;               
        if (oldValue !== value)
        {
        	_internal_twitter_lang = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "twitter_lang", oldValue, _internal_twitter_lang));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set author(value:Author) : void 
    {    	
    	var recalcValid:Boolean = false;
    	if (value == null || _internal_author == null)
    	{
    		recalcValid = true;
    	}	
    	
    	var oldValue:Author = _internal_author;               
        if (oldValue !== value)
        {
        	_internal_author = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "author", oldValue, _internal_author));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    

    /**
     * data property setter listeners
     */   

   model_internal function setterListenerAnyConstraint(value:Event):void
   {
        if (model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }        
   }   

    /**
     * valid related derived properties
     */
    model_internal var _isValid : Boolean;
    model_internal var _invalidConstraints:Array = new Array();
    model_internal var _validationFailureMessages:Array = new Array();

    /**
     * derived property calculators
     */

    /**
     * isValid calculator
     */
    model_internal function calculateIsValid():Boolean
    {
        var violatedConsts:Array = new Array();    
        var validationFailureMessages:Array = new Array();    

		if (_model.isIdAvailable && _internal_id == null)
		{
			violatedConsts.push("idIsRequired");
		}
		if (_model.isPublishedAvailable && _internal_published == null)
		{
			violatedConsts.push("publishedIsRequired");
		}
		if (_model.isLinkAvailable && _internal_link == null)
		{
			violatedConsts.push("linkIsRequired");
		}
		if (_model.isTitleAvailable && _internal_title == null)
		{
			violatedConsts.push("titleIsRequired");
		}
		if (_model.isContentAvailable && _internal_content == null)
		{
			violatedConsts.push("contentIsRequired");
		}
		if (_model.isUpdatedAvailable && _internal_updated == null)
		{
			violatedConsts.push("updatedIsRequired");
		}
		if (_model.isTwitter_sourceAvailable && _internal_twitter_source == null)
		{
			violatedConsts.push("twitter_sourceIsRequired");
		}
		if (_model.isTwitter_langAvailable && _internal_twitter_lang == null)
		{
			violatedConsts.push("twitter_langIsRequired");
		}
		if (_model.isAuthorAvailable && _internal_author == null)
		{
			violatedConsts.push("authorIsRequired");
		}

		var styleValidity:Boolean = true;
    
        model_internal::_cacheInitialized_isValid = true;
        model_internal::invalidConstraints_der = violatedConsts;
        model_internal::validationFailureMessages_der = validationFailureMessages;
        return violatedConsts.length == 0 && styleValidity;
    }  

    /**
     * derived property setters
     */

    model_internal function set isValid_der(value:Boolean) : void
    {
       	var oldValue:Boolean = model_internal::_isValid;               
        if (oldValue !== value)
        {
        	model_internal::_isValid = value;
        	_model.model_internal::fireChangeEvent("isValid", oldValue, model_internal::_isValid);
        }        
    }

    /**
     * derived property getters
     */

    [Transient] 
	[Bindable(event="propertyChange")] 
    public function get _model() : _TweetEntityMetadata
    {
		return model_internal::_internal_model;              
    }	
    
    public function set _model(value : _TweetEntityMetadata) : void       
    {
    	var oldValue : _TweetEntityMetadata = model_internal::_internal_model;               
        if (oldValue !== value)
        {
        	model_internal::_internal_model = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_model", oldValue, model_internal::_internal_model));
        }     
    }      

    /**
     * methods
     */  


    /**
     *  services
     */                  
     private var _managingService:IFiberManagingService;
    
     public function set managingService(managingService:IFiberManagingService):void
     {
         _managingService = managingService;
     }                      
     
    model_internal function set invalidConstraints_der(value:Array) : void
    {  
     	var oldValue:Array = model_internal::_invalidConstraints;
     	// avoid firing the event when old and new value are different empty arrays
        if (oldValue !== value && (oldValue.length > 0 || value.length > 0))
        {
            model_internal::_invalidConstraints = value;   
			_model.model_internal::fireChangeEvent("invalidConstraints", oldValue, model_internal::_invalidConstraints);   
        }     	             
    }             
    
     model_internal function set validationFailureMessages_der(value:Array) : void
    {  
     	var oldValue:Array = model_internal::_validationFailureMessages;
     	// avoid firing the event when old and new value are different empty arrays
        if (oldValue !== value && (oldValue.length > 0 || value.length > 0))
        {
            model_internal::_validationFailureMessages = value;   
			_model.model_internal::fireChangeEvent("validationFailureMessages", oldValue, model_internal::_validationFailureMessages);   
        }     	             
    }        
     
     // Individual isAvailable functions     
	// fields, getters, and setters for primitive representations of complex id properties

}

}
