/**
 * This is a generated class and is not intended for modfication.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - Link.as.
 */

package services.twittersearch
{
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
public class _Super_Link extends EventDispatcher implements IValueObject
{
	model_internal var _internal_model : _LinkEntityMetadata;

	/**
	 * properties
	 */
	private var _internal_type : String;		
	private var _internal_rel : String;		
	private var _internal_href : String;		

    private static var emptyArray:Array = new Array();

    /**
     * derived property cache initialization
     */  
    model_internal var _cacheInitialized_isValid:Boolean = false;   
    
	model_internal var _changeWatcherArray:Array = new Array();   

	public function _Super_Link() 
	{	
		_model = new _LinkEntityMetadata(this);
	
		// Bind to own data properties for cache invalidation triggering  
       
	}

    /**
     * data property getters
     */
	[Bindable(event="propertyChange")] 
    public function get type() : String    
    {
            return _internal_type;
    }    
	[Bindable(event="propertyChange")] 
    public function get rel() : String    
    {
            return _internal_rel;
    }    
	[Bindable(event="propertyChange")] 
    public function get href() : String    
    {
            return _internal_href;
    }    

    /**
     * data property setters
     */      
    public function set type(value:String) : void 
    {    	
    	var recalcValid:Boolean = false;
    	if (value == null || _internal_type == null)
    	{
    		recalcValid = true;
    	}	
    	
    	var oldValue:String = _internal_type;               
        if (oldValue !== value)
        {
        	_internal_type = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "type", oldValue, _internal_type));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set rel(value:String) : void 
    {    	
    	var recalcValid:Boolean = false;
    	if (value == null || _internal_rel == null)
    	{
    		recalcValid = true;
    	}	
    	
    	var oldValue:String = _internal_rel;               
        if (oldValue !== value)
        {
        	_internal_rel = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "rel", oldValue, _internal_rel));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set href(value:String) : void 
    {    	
    	var recalcValid:Boolean = false;
    	if (value == null || _internal_href == null)
    	{
    		recalcValid = true;
    	}	
    	
    	var oldValue:String = _internal_href;               
        if (oldValue !== value)
        {
        	_internal_href = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "href", oldValue, _internal_href));
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

		if (_model.isTypeAvailable && _internal_type == null)
		{
			violatedConsts.push("typeIsRequired");
		}
		if (_model.isRelAvailable && _internal_rel == null)
		{
			violatedConsts.push("relIsRequired");
		}
		if (_model.isHrefAvailable && _internal_href == null)
		{
			violatedConsts.push("hrefIsRequired");
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
    public function get _model() : _LinkEntityMetadata
    {
		return model_internal::_internal_model;              
    }	
    
    public function set _model(value : _LinkEntityMetadata) : void       
    {
    	var oldValue : _LinkEntityMetadata = model_internal::_internal_model;               
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
