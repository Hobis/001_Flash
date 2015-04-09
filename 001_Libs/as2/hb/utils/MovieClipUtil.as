/**
	@name: MovieClip Util
	@author: Hobis Jung
	@blog: http://blog.naver.com/jhb0b
	@date: 2011-01-03
*/
class hb.utils.MovieClipUtil
{
	public function MovieClipUtil()
	{
	}

	public static function freeze(target:MovieClip, isSub:Boolean):Void
	{
		if (isSub == undefined) isSub = true;

		var t_mc:MovieClip = null;
		var t_p:String = null;

		for (t_p in target)
		{
			if (typeof target[t_p] != 'movieclip')
				continue;

			t_mc = target[t_p];

			if (t_mc._totalframes > 1)
				t_mc.stop();

			if (t_mc.onEnterFrame)
				delete t_mc.onEnterFrame;

			if (isSub)
				freeze(t_mc, isNotSub);
		}
	}
}
