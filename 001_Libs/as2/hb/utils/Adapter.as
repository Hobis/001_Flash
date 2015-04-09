/**
	@name: Handler Adapter
	@author: Hobis Jung
	@blog: http://hobis.egloos.com
	@date: 2011-01-03
*/

class hb.utils.Adapter
{
	public function Adapter()
	{
	}

	public static function wrap(target:Object, routine:Function):Function
	{
		var f:Function = function():Object
		{
			var target:Object = arguments.callee.target;
			var routine:Function = arguments.callee.routine;
			var param:Array =  arguments.concat(__p_getParam(arguments.callee.param, 0));

			return routine.apply(target, param);
		};

		f.target = target;
		f.routine = routine;
		f.param = __p_getParam(arguments, 2);

		return f;
	}

	private static function __p_getParam(array:Array, count:Number):Array
	{
		var t_rv:Array = [];

		if (array.length < count + 1)
			return t_rv;

		var t_len:Number = array.length;

		for (var i:Number = count; i < t_len; i++)
		{
			t_rv.push(array[i]);
		}

		return t_rv;
	}

	public static function remove(target:Object, type:String):Void
	{
		var t_func:Function = (target[type] instanceof Function) ? target[type] : null;

		if (t_func != null)
		{
			target[type].target = null;
			target[type].routine = null;
			target[type].param = null;
			target[type] = null;
		}
	}

	public static function remove2(func:Function):Function
	{
		var t_rv:Function = (func instanceof Function) ? func : null;

		if (t_rv != null)
		{
			t_rv.target = null;
			t_rv.routine = null;
			t_rv.param = null;
			t_rv = null;
		}

		return t_rv;
	}

}