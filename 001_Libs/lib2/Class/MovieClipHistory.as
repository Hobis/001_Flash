/**
 * @class MovieClipHistory
 * @interface none
 * @author senocular
 * @version 1.1
 * @description Provides a way to record and replay many methods
 * used in dynamically defining a movie clip's visual appearance. 
 * Methods recorded can be replayed on the original movie clip
 * or another movie clip which is to "inherit" the original
 * movie clip's dynamic appearance. Supported methods include:
 * <ul>
 * <li>attachMovie</li>
 * <li>duplicateMovieClip</li>
 * <li>createEmptyMovieClip</li>
 * <li>loadMovie</li>
 * <li>swapDepths</li>
 * <li>removeMovieClip</li>
 * <li>lineStyle</li>
 * <li>beginFill</li>
 * <li>beginGradientFill</li>
 * <li>endFill</li>
 * <li>moveTo</li>
 * <li>lineTo</li>
 * <li>curveTo</li>
 * <li>clear</li>
 * </ul>
 * These methods are overridden for the movie clip so that new, history
 * recording methods can be used in their place.  The new methods record
 * the method call and call for the movie clip the original method.
 * <p>
 * When using <tt>MovieClipHistory</tt>, you don't don't create instances of the
 * class but, rather, use the class to initialize a pre-existing MovieClip 
 * instance so that that movie clip may be set up to record history for itself.
 * An instance of <tt>MovieClipHistory</tt> is then automatically assigned to that
 * movie clip as the property <code>history</code>. This <code>history</code> is an array
 * of generic history objects that contain the properties:
 * <ul>
 * <li>methodName - <code>(String)</code> The name of the method recorded.</li>
 * <li>arguments - <code>(Array)</code> Arguments used in the method.</li>
 * <li>target - <code>(String)</code> Path from the movie clip recording the method ("epoch") to the movie clip using it.</li>
 * </ul>
 * </p>
 * @usage <pre><b>MovieClipHistory.initialize(movieClipToReceiveHistory [, epoch]);</b></pre>
 */
class MovieClipHistory extends Array {
	
	/*
	* container for method names for supported/overridden methods
	*/
	private static var  _methodNames:Object;
	/*
	* container for method functions for supported/overridden methods
	*/
	private static var  _methods:Object;
	
	/*
	* Defines methods to record history for. These methods
	* are only defined after the initialize has been called
	* for the first time. Methods with values of true represent
	* methods which create movie clips which too would need
	* to be initialized with MovieClipHistory in order for
	* their history to be recorded as well.
	*/
	private static function init():Void{
		_methods = Object(); // Object without new to assure no inheritance
		_methodNames = Object();
		// use most visual properties (those that create in and draw in movie clips)
		_methodNames.attachMovie = true;
		_methodNames.duplicateMovieClip = true;
		_methodNames.createEmptyMovieClip = true;
		_methodNames.loadMovie = false;
		_methodNames.swapDepths = false;
		_methodNames.removeMovieClip = false;
		_methodNames.lineStyle = false;
		_methodNames.beginFill = false;
		_methodNames.beginGradientFill = false;
		_methodNames.endFill = false;
		_methodNames.moveTo = false;
		_methodNames.lineTo = false;
		_methodNames.curveTo = false;
		_methodNames.clear = false;
	}
	
	/**
	* @method MovieClipHistory.initialize
	* @description <code>(Static)</code> Initializes a movie clip in order for it's methods to be recorded.
	* When initialized, movie clips recieve an instance of <tt>MovieClipHistory</tt>
	* as a <code>history</code> property. Set epoch to true if you want child clips to store
	* history in the movie clip being initialized
	* @param mc	<code>(MovieClip)</code> Movie clip to be set up to record history
	* @param useEpoch	<code>(Boolean, MovieClip)</code> <tt>Optional,</tt> Specifies whether the mc movie clip used should be the epoch for all child clips created after initilization. If false or null, mc is its own epoch and all child movie clips created through historic events record methods independantly to their own history instances (using themselves as their epoch).  If true, the mc is used and all child movie clips created through historic events after initialization use mc as their epoch recording their history into its history instance. This value can also be a target movie clip in which you wish the mc's history to be recorded. <tt>Default:</tt> null.
	* @usage <pre><b>MovieClipHistory.initialize(movieClipToReceiveHistory [, useEpoch]);</b></pre>
	*/
	public static function initialize(mc:MovieClip, epoch/*:Boolean, MovieClip*/):Void{
		if (!_methods || !_methodNames) init(); // define _methodNames and _methods if not already
		
		// for all methods in _methodNames array
		for (var methodName in _methodNames){
			
			// if the method doesn't yet exist as a function in _methods, create it
			if (!_methods[methodName]){ 
				
				// this function will be what overrides the mc movie clip's own methods
				// it adds the method to the history list and calls the movie clip's
				// original through its __proto__ reference
				_methods[methodName] = function(){
					// determine the history object to save in based on what the epoch is
					var epochHistory = (this.history.epoch) ? this.history.epoch.history : this.history;
					// if history is enabled, add properties of the method call to the array of history events 
					if (epochHistory.enabled) epochHistory.push({methodName:arguments.callee.methodName, arguments:arguments, target:this.history.target});
					// call the original method for the MovieClip object ('this' is the movie clip since this method is copied to it)
					var result = this.__proto__[arguments.callee.methodName].apply(this, arguments);
					// if the method creates a MovieClip instance (e.g. attachMovie, duplicateMovieClip, createEmptyMovieClip ...) initialize that new movie clip
					if (epochHistory.enabled && arguments.callee.creates) MovieClipHistory.initialize(result, epochHistory.epoch);
					// return whatever result came from the original method call
					return result;
				}
				// assign to this method its name and whether or not it creates movie clips so that
				// it can refernce these properties via arguments.callee
				_methods[methodName].methodName = methodName;
				_methods[methodName].creates = _methodNames[methodName];
			}
			
			// assign the current method to the movie clip overriding it's default.
			// Note: overridden methods need to be inherited such as those inherited from movie clip (all defaults)
			mc[methodName] = _methods[methodName];
		}
		
		// assign a history object to the movie clip which is a
		// MovieClipHistory with the movie clip as its owner and
		// epoch based on that which was passed to initialze
		mc.history = new MovieClipHistory(mc, epoch);
	}
	
	private var __parent:MovieClip; // parent clip containing this history object.
	private var __epoch:MovieClip; // epoch movie clip recording this __parent's history.
	private var __target:String; // target from epoch to this __parent.
	/**
     * @property enabled <code>(Boolean)</code>, if <code>true</code> history is recorded as normal.  When set to <code>false</code> historic methods are not recorded in history. <tt>Default:</tt> <code>true</code>.
     */
	public var enabled:Boolean = true;
	
	/**
     * Constructor (for invocation by initialize, typically implicit).
	* param owner <code>(MovieClip)</code> The movieclip to enable history recording
	* param epoch <code>(MovieClip, Boolean)</code> <tt>Optional,</tt> Specifies which movie clip will record historic
	* 			events. If null, the owner records only it's own events.
	* 			If another movie clip, owner will record all it's historic
	* 			events in epoch. <tt>Default:</tt> null.
     */
	function MovieClipHistory(owner:MovieClip, epoch/*:Boolean, MovieClip*/){
		__parent = owner; // __parent is used to reference the movie clip this history property belongs to
		if (epoch == true) __epoch = __parent; // epoch is passed as true if all child history events are to remain in this history object
		else __epoch = epoch; // otherwise use what was passed (another movie clip or undefined)
		// develop a __target based on __epoch and __parent values. If an epoch is used, as child clips are created, 
		// the path extends itself to correctly reference each child in respect to the epoch 
		__target = (!__epoch || __parent == __epoch) ? "epoch" : __parent._parent.history.target + "." + __parent._name;
	}
	
	/**
     * @property _parent <code>(MovieClip)</code> <tt>Read-only,</tt> The movie clip owning the MovieClipHistory instance.
     */
	public function get _parent():MovieClip{
		return __parent;
	}
	
	/**
     * @property epoch <code>(MovieClip, Null)</code> <tt>Read-only,</tt> The epoch movie clip or the movie clip recording historic events for this history object if _parent is not recording it's own history. If _parent is recording it's own history, this value is null.
     */
	public function get epoch():MovieClip{
		return __epoch;
	}
	
	/**
     * @property target <code>(String)</code> <tt>Read-only,</tt> A string path to _parent from the epoch where the epoch is represented as "epoch". If there is no epoch, this string will simply be "epoch".
     */
	public function get target():String{
		return __target;
	}
	
	/**
	* @method recall
     * @description Recalls one, a range of, or all historic events calling them on the passed epoch.
	* @param anyMovieClip <code>(MovieClip)</code> <tt>Optional,</tt> specifies which movie clip will recieve calls of historic events from this history instance. If null, the history owner recieves the events. <tt>Default:</tt> null.
	* @param start <code>(Number)</code> <tt>Optional,</tt> The position in history to start playback. <tt>Default:</tt> 0 (first event).
	* @param end <code>(Number)</code> <tt>Optional,</tt> The position in history to stop playback. If start is specified but end is not, only the history event at start is called. <tt>Default:</tt> length-1 (last event).
	* @usage <pre><b>initializedMovieClip.history.recall(anyMovieClip [, start [,end]]);</b></pre>
     */
	public function recall(epoch:MovieClip, start:Number, end:Number):Void{
		// epoch here represents the movie clip to /receive/ historic events
		// if no epoch/movie clip is passed, use this history's _parent
		if (!epoch) epoch = __parent;
		var target, result, len = this.length;
		if (end == undefined){
			if (start == undefined){
				// if no end or start is specified, use the whole history array
				start = 0;
				end = len;
			}else end = start + 1; // if just start, use only start (loops once)
		}else end++; // assume user wants end value to be inclusive
		// if the epoch movie clip passed has not been initialized, do so now
		// using whatever epoch was used for this history
		if (!(epoch.history instanceof MovieClipHistory)) initialize(epoch, (__epoch) ? epoch : null);
		var e = enabled; // save current enabled setting
		enabled = false; // disable history recording when recalling history
		// loop through this history based on start and end values
		for (var i=start; i<end; i++){
			target = eval(this[i].target); // develop a target in which to call the method
			result = target[this[i].methodName].apply(target, this[i].arguments); // call the method
			// if no epoch was used and each movie clip records its own history independantly
			// and the method called results in a new movie clip, recall history in that movie clip
			// to properly render it given the history it inherits
			if (epoch[this[i].methodName].creates && !__epoch) __parent[result._name].history.recall(result);
		}
		enabled = e; // restore original enabled setting
	}
	
}