class ColorFader extends Color {
	private var _id:Number; // id for setInterval call
	private var _interval:Number = 33; // default interval for fading
	private var _colorFrom:Object; // information about starting color
	private var _colorTo:Object; // information about the color fading to
	private var _remains:Number; // number of updates remaining for a fade
	private var _total:Number; // total number of updates being used for a fade
	
	// constructor
	function ColorFader(mc){
		super(mc); // based off the Color Object
	}
		
	/**
	 * hexTo: hex to fade to
	 * duration: length of time to spend fading to hexTo
	 * opt_interval: (optional) the rate at which the fade updates. Default: 33 milliseconds
	 */
	public function fadeTo(hexTo, duration, opt_interval):Void {
		// stop any existing fade
		clearInterval(_id);
		// assign color objects
		var rgb = getRGB();
		_colorFrom = {r:rgb>>16, g:(rgb >> 8)&0xff, b:rgb&0xff, hex:rgb};
		_colorTo = {r:hexTo>>16, g:(hexTo >> 8)&0xff, b:hexTo&0xff, hex:hexTo};
		// determine interval
		var interval = (opt_interval != undefined) ? opt_interval : _interval;
		// calc updates needed in fade
		_remains = _total = Math.ceil(duration/interval);
		// call doFade to update fading every interval milliseconds
		_id = setInterval(this, "doFade", interval);
	}
	private function doFade():Void {
		// if remaining updates exist
		if(_remains) {
			_remains--;
			// process fade between colors
			var t = 1 - _remains/_total;
			setRGB((_colorFrom.r+(_colorTo.r-_colorFrom.r)*t) << 16 | (_colorFrom.g+(_colorTo.g-_colorFrom.g)*t) << 8 | (_colorFrom.b+(_colorTo.b-_colorFrom.b)*t));
			// if no more remains
		} else {
			// set to hex of color fading to
			setRGB(_colorTo.hex);
			// clear/stop interval
			clearInterval(_id);
		}
		updateAfterEvent();		
	}
}