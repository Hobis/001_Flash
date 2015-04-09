/**
	@Name: DisplayObjectContainerUtil
	@Author: HobisJung
	@Blog: http://blog.naver.com/jhb0b
	@Date: 2013-02-18
*/
package hb.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public final class DisplayObjectContainerUtil
	{
		public function DisplayObjectContainerUtil()
		{
		}


		/**
			@Using:
			{

// :: Click Handler
function p_cis_click(event:MouseEvent):void
{
	var t_mc:MovieClip = MovieClip(event.currentTarget);

	trace(t_mc.name);
}

var owner:MovieClip = this;
DisplayObjectContainerUtil.contLoop(this, 'ci_',
	function(doc:DisplayObject, index:int):void
	{
		var t_mc:MovieClip = doc as MovieClip;
		t_mc.mouseChildren = false;
		t_mc.buttonMode = true;
		t_mc.addEventListener(MouseEvent.CLICK, owner.p_cis_click);
	}
);

			}
		*/
		// :: [DisplayObjectContainer]자식객체 반복 검출
		public static function contLoop(
										cont:DisplayObjectContainer,
										frontStr:String,
										loopFunc:Function,
										loopFuncParams:Array = null):void
		{
			var t_cdo:DisplayObject = null;
			var t_la:int = cont.numChildren, i:int;
			for (i = 0; i < t_la; i ++)
			{
				t_cdo = cont.getChildAt(i);
				if (t_cdo.name.indexOf(frontStr, 0) == 0)
				{
					if (loopFuncParams != null)
						loopFunc.apply(null, [t_cdo, i].concat(loopFuncParams));
					else
						loopFunc(t_cdo, i);
				}
			}
		}


		/**
			@Using:
			{

// ::
function p_ais_contLoop(doc:DisplayObject, index:int):Boolean
{
	var t_mc:MovieClip = doc as MovieClip;
	t_mc.mouseChildren = false;
	t_mc.buttonMode = true;

	var t_num:int = HB_Proxy.hb_str_getLastIndex(t_mc.name);
	if (t_num >= 7)
		return true;
	else
		return false;
}
DisplayObjectContainerUtil.contLoop_b(this, 'ai_', this.p_ais_contLoop);

			}
		*/
		// :: [DisplayObjectContainer]자식객체 반복 검출 boolean (조건에 따라 반복 멈춤)
		public static function contLoop_b(
										cont:DisplayObjectContainer,
										frontStr:String,
										loopFunc:Function,
										loopFuncParams:Array = null):void
		{
			var t_cdo:DisplayObject = null;
			var t_la:int = cont.numChildren, i:int;
			for (i = 0; i < t_la; i ++)
			{
				t_cdo = cont.getChildAt(i);
				if (t_cdo.name.indexOf(frontStr, 0) == 0)
				{
					if (loopFuncParams != null)
					{
						if (loopFunc.apply(null, [t_cdo, i].concat(loopFuncParams)))
						{
							break;
						}
					}
					else
					{
						if (loopFunc(t_cdo, i))
						{
							break;
						}
					}
				}
			}
		}



		// :: [DisplayObjectContainer]자식객체 반복 검출 boolean all (조건에 따라 반복 멈춤)
/*
		//
		HB_Proxy.hb_doc_contLoop_ba(owner.mpc_1,
			function(cdo:DisplayObject, index:int):void
			{
				var t_mp:MovieClip = cdo as MovieClip;
				if (t_mp != null)
				{
					var t_frontName:String = t_mp.name.split('_')[0];
					switch (t_frontName)
					{
						case 'mp':
						{
							trace('레드풀');

							break;
						}
					}
				}
			}
		);*/
		public static function contLoop_ba(
										cont:DisplayObjectContainer,
										loopFunc:Function,
										loopFuncParams:Array = null):void
		{
			var t_cdo:DisplayObject = null;
			var t_la:int = cont.numChildren, i:int;
			for (i = 0; i < t_la; i ++)
			{
				t_cdo = cont.getChildAt(i);
				if (loopFuncParams != null)
				{
					if (loopFunc.apply(null, [t_cdo, i].concat(loopFuncParams)))
					{
						break;
					}
				}
				else
				{
					if (loopFunc(t_cdo, i))
					{
						break;
					}
				}
			}
		}
	}
}