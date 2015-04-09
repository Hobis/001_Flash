/**
	@name : EventCaller
	@author : jungheebum(jhb0b@naver.com)
	@blog : http://blog.naver.com/jhb0b
	@date : 2009-04-02
*/
class hb.events.EventCaller
{
	public function EventCaller()
	{
	}

	public static function initialize(target:Object):Void
	{
		if (target.addHandler == undefined)
		{
			target.addHandler = EventCaller.prototype.addHandler;
			target.removeHandler = EventCaller.prototype.removeHandler;
			target.callEvent = EventCaller.prototype.callEvent;
			target.__eventCallerHandlers = [];
		}
	}

	public static function terminate(target:Object):Void
	{
		if (target.addHandler != undefined)
		{
			target.addHandler = undefined;
			target.removeHandler = undefined;
			target.callEvent = undefined;
			target.__eventCallerHandlers = undefined;
		}
	}

	public function addHandler(type:String, handler:Function):Void
	{
		var t_listener:Object = {type: type, handler: handler};
		this.__eventCallerHandlers.push(t_listener);
	}

	public function removeHandler(handler:Function):Boolean
	{
		var rv:Boolean = false;
		var t_len:Number = this.__eventCallerHandlers.length;
		var i:Number = 0;

		while (i < t_len)
		{
			if (handler == this.__eventCallerHandlers[i].handler)
			{
				this.__eventCallerHandlers.splice(i, 1);
				rv = true;
				break;
			}

			i++;
		}

		return rv;
	}

	public function callEvent(type:String, scope:Object):Void
	{
		if (scope == undefined)
		{
			scope = this;
		}

		var t_len:Number = this.__eventCallerHandlers.length;
		var i:Number = 0;
		var t_listener:Object = null;

		while (i < t_len)
		{
			t_listener = this.__eventCallerHandlers[i];

			if (type == t_listener.type)
			{
				t_listener.handler.apply(scope, arguments);
			}

			i++;
		}
	}


	private var __eventCallerHandlers:Array = null;

}

