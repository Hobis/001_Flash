/**
	@name : EventRegister Ver 1.02
	@author : jungheebum(jhb0b@naver.com)
	@blog : http://blog.naver.com/jhb0b
	@date : 2009-06-23
	@using :
	{

		import hb.events.EventRegister;

		function p_onMouseDown(event:Object):Void
		{
			trace('scope : ' + this);
			trace('event : ' + event);
			trace('event.target : ' + event.target);
			trace('event.type : ' + event.type);
			trace('event.args : ' + event.args);
		}

		EventRegister.addEvent(this, 'onMouseDown', this, this.p_onMouseDown);

	}
*/
class hb.events.EventRegister
{
	public function EventRegister()
	{
	}

	public static function addEvent(target:Object, type:String, scope:Object, handler:Function):Void
	{
		var f:Function = function():Object
		{
			var callee:Function = arguments.callee;
			var scope:Object = callee.scope;
			var handler:Function = callee.handler;
			var args:Array = (arguments.length > 0) ? arguments : null;
			var eventObj:Object =
			{
				target: callee.target,
				type: callee.type,
				args: args
			};
			eventObj.toString = function():String
			{
				var t_rv:String =
					'target: ' + this.target + ', ' +
					'type: ' + this.type + ', ' +
					'args: ' + this.args;
				return t_rv;
			};

			return handler.call(scope, eventObj);
		};

		f.target = target;
		f.type = type;
		f.scope = scope;
		f.handler = handler;
		target[type] = f;
	}

	public static function removeEvent(target:Object, type:String):Void
	{
		var f:Function = target[type];
		f.target = null;
		f.type = null;
		f.scope = null;
		f.handler = null;
		target[type] = null;
	}

	// : Dynamic adding use event types
	public static var eventTypes:Object = null;
}