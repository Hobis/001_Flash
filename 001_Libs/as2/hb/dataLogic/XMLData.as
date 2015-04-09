/**
	@name : XML Object Parsing
	@author : jungheebum(jhb0b@naver.com)
	@blog : http://blog.naver.com/jhb0b
	@date : 2009-04-02
*/
class hb.dataLogic.XMLData
{
	public function XMLData()
	{
	}

	public static function toObj(target:XML):Object
	{
		var t_a:String = null, t_c:String = null;
		var t_nName:Object = null, t_nType:Object = null, t_nValue:Object = null;
		var t_obj:Object = {};

		for (t_a in target.attributes)
		{
			t_obj[t_a] = target.attributes[t_a];
		}

		for (t_c in target.childNodes)
		{
			t_nName = target.childNodes[t_c].nodeName;
			t_nType = target.childNodes[t_c].nodeType;
			t_nValue = target.childNodes[t_c].nodeValue;

			if (t_nType == 3)
			{
				t_obj._value = t_nValue;
				t_obj._type = "text";
			}

			if (t_nType == 1 && t_nName != null)
			{
				if (t_obj[t_nName] == null)
				{
					t_obj[t_nName] = arguments.callee(target.childNodes[t_c], {});
				}
				else if (t_obj[t_nName]._type != "array")
				{
					t_obj[t_nName] = [t_obj[t_nName]];
					t_obj[t_nName]._type = "array";
				}

				if (t_obj[t_nName]._type == "array")
				{
					t_obj[t_nName].unshift(arguments.callee(target.childNodes[t_c], {}));
				}
			}

		}

		return t_obj;
	}

}
