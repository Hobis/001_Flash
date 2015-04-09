/**
	@name : XMLToArray
	@author : jungheebum(jhb0b@naver.com)
	@blog : http://blog.naver.com/jhb0b
	@date : 2009-04-02
*/
class hb.dataLogic.XMLToArray
{
    public function XMLToArray()
	{
	}

    public static function nodeToArray(node):Object
	{

        var nodeTypeNum:Number = node.nodeType;

        if (nodeTypeNum == 3)
        	return node.nodeValue;

        //
        var tempObj:Object = {};
        var tempAttributes:Object = node.attributes;

	    for (var e:String in tempAttributes)
	    	tempObj[e] = tempAttributes[e];

        var temp_cn:Object = node.childNodes;
        var temp_cnLen:Number = temp_cn.length;

		for (var i:Number = 0; i < temp_cnLen; i++)
		{
            var node_a:Object = temp_cn[i];
            var node_b:Object = arguments.callee(node_a);
            var node_s:String;

            if (typeof node_b == "string") node_s = "value";
            else node_s = node_a.nodeName;

            if (tempObj[node_s])
			{
            	tempObj[node_s].push(node_b);
                continue;
            }

            for (var a:Number = (i + 1); a < temp_cnLen; a++)
			{
                var node_temp:Object = temp_cn[a];

                if (node_s == node_temp.nodeName)
				{
                    tempObj[node_s] = [];
                    tempObj[node_s].push(node_b);
                    break;
                }
            }

            if (!tempObj[node_s])
            	tempObj[node_s] = node_b;
        }

        return tempObj;

    }//end function nodeToArray

}//end class