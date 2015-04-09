/**
	@Name: HB_Proxy
	@Author: HobisJung
	@Date: 2013-02-18
	@Comments:
	{
	}
*/
package
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import hb.utils.ArrayUtil;
	import hb.utils.DebugUtil;
	import hb.utils.DisplayObjectUtil;
	import hb.utils.DisplayObjectContainerUtil;
	import hb.utils.MovieClipUtil;
	import hb.utils.NumberUtil;
	import hb.utils.ObjectUtil;
	import hb.utils.StringUtil;

	public final class HB_Proxy
	{
		public function HB_Proxy() {}

		///////////////////////////////////////////////////////////////////////////////////////////////////
		// # Global 영역으로 사용됨
		///////////////////////////////////////////////////////////////////////////////////////////////////
		// - Global 영역으로 사용됨
		public static const global:Object = {};
		public static function global_trace():void
		{
			for (var t_p:String in global)
			{
				DebugUtil.test(t_p + ': ' + global[t_p]);
			}
		}
		public static function global_clear():void
		{
			for (var t_p:String in global)
			{
				delete global[t_p];
			}
		}
		///////////////////////////////////////////////////////////////////////////////////////////////////


		///////////////////////////////////////////////////////////////////////////////////////////////////
		// # Array Utils
		///////////////////////////////////////////////////////////////////////////////////////////////////
		// :: [Array]배열 요소 개수만큼 콜백실행
		public static function hb_arr_forEach(
											target:Array,
											loopFunc:Function,
											loopFuncParams:Array = null):void
		{
			ArrayUtil.forEach(target, loopFunc, loopFuncParams);
		}

		// :: [Array]배열 요소 섞기
		public static function hb_arr_shuffle(target:Array):void
		{
			ArrayUtil.shuffle(target);
		}
		///////////////////////////////////////////////////////////////////////////////////////////////////


		///////////////////////////////////////////////////////////////////////////////////////////////////
		// # DisplayObject Utils
		///////////////////////////////////////////////////////////////////////////////////////////////////
		// :: [DisplayObject]채도 죽이기, 살리기
		public static function hb_do_setDesat(target:DisplayObject, isDesat:Boolean = true):void
		{
			DisplayObjectUtil.setDesat(target, isDesat);
		}

		// :: [DisplayObject]컬러변경
		public static function hb_do_setColor(target:DisplayObject, color:uint):void
		{
			DisplayObjectUtil.setColor(target, color);
		}

		// :: [DisplayObject]컬러변경 취소
		public static function hb_do_noColor(target:DisplayObject):void
		{
			DisplayObjectUtil.noColor(target);
		}

		// :: [DisplayObject]컨텐츠가 로딩되어도 절대경로 기본위치 찾아줌
		public static function hb_do_getTargetBaseUrl(target:DisplayObject):String
		{
			return DisplayObjectUtil.getTargetBaseUrl(target);
		}
		///////////////////////////////////////////////////////////////////////////////////////////////////


		///////////////////////////////////////////////////////////////////////////////////////////////////
		// # DisplayObjectContainer Utils
		///////////////////////////////////////////////////////////////////////////////////////////////////
		// :: [DisplayObjectContainer]자식객체 반복 검출
		public static function hb_doc_contLoop(
											cont:DisplayObjectContainer,
											searchStr:String,
											loopFunc:Function,
											loopFuncParams:Array = null):void
		{
			DisplayObjectContainerUtil.contLoop(cont, searchStr, loopFunc, loopFuncParams);
		}

		// :: [DisplayObjectContainer]자식객체 반복 검출 boolean (조건에 따라 반복 멈춤)
		public static function hb_doc_contLoop_b(
											cont:DisplayObjectContainer,
											searchStr:String,
											loopFunc:Function,
											loopFuncParams:Array = null):void
		{
			DisplayObjectContainerUtil.contLoop_b(cont, searchStr, loopFunc, loopFuncParams);
		}

		// :: [DisplayObjectContainer]자식객체 반복 검출 boolean all (조건에 따라 반복 멈춤)
		public static function hb_doc_contLoop_ba(
											cont:DisplayObjectContainer,
											loopFunc:Function,
											loopFuncParams:Array = null):void
		{
			DisplayObjectContainerUtil.contLoop_ba(cont, loopFunc, loopFuncParams);
		}
		///////////////////////////////////////////////////////////////////////////////////////////////////


		///////////////////////////////////////////////////////////////////////////////////////////////////
		// # Frame Utils
		///////////////////////////////////////////////////////////////////////////////////////////////////
		// :: [Frame]프래임에서 라벨이름 검색해서 개수 반환
		public static function hb_frame_getLabelCount(target:MovieClip, keyword:String):uint
		{
			return MovieClipUtil.getLabelCount(target, keyword);
		}

		// :: [Frame]프래임라벨로 프래임번호 알아내기
		public static function hb_frame_getLabelToFrame(target:MovieClip, name:String):int
		{
			return MovieClipUtil.getLabelToFrame(target, name);
		}

		// :: [Frame]특정 프래임이후에 함수 호출 정지
		public static function hb_frame_delayExcute_stop(target:MovieClip):void
		{
			MovieClipUtil.delayExcute_stop(target);
		}

		// :: [Frame]특정 프래임이후에 함수 호출
		public static function hb_frame_delayExcute(target:MovieClip, ac:Function, acps:Array = null, countLen:uint = 1):void
		{
			MovieClipUtil.delayExcute(target, ac, acps, countLen);
		}
		///////////////////////////////////////////////////////////////////////////////////////////////////


		///////////////////////////////////////////////////////////////////////////////////////////////////
		// # MovieClip Utils
		///////////////////////////////////////////////////////////////////////////////////////////////////
		// :: [MovieClip]무비클립 기본 롤오버아웃 등록해제
		public static function hb_mc_removeRoo(target:MovieClip):void
		{
			MovieClipUtil.removeRoo(target);
		}

		// :: [MovieClip]무비클립 기본 롤오버아웃 등록하기
		public static function hb_mc_addRoo(target:MovieClip):void
		{
			MovieClipUtil.addRoo(target);
		}

		// :: [MovieClip]무비클립 콜백 호출
		public static function hb_mc_dispatchCallBack(target:MovieClip, eventObj:Object):void
		{
			MovieClipUtil.dispatchCallBack(target, eventObj);
		}

		// :: [MovieClip]무비클립 클릭 핸들러 제거
		public static function hb_mc_removeClickHandler(target:MovieClip,
													isButtonMode:Boolean = true):void
		{
			MovieClipUtil.remove_clickHandler(target, isButtonMode);
		}

		// :: [MovieClip]무비클립 클릭 핸들러 등록
		public static function hb_mc_addClickHandler(target:MovieClip, clickHandler:Function,
													isButtonMode:Boolean = true):void
		{
			MovieClipUtil.add_clickHandler(target, clickHandler, isButtonMode);
		}

		//
		//
		//
		//
		// :: [MovieClip]무비클립 클릭 핸들러 제거 roo
		public static function hb_mc_removeClickHandler_roo(target:MovieClip):void
		{
			MovieClipUtil.remove_clickHandler_roo(target);
		}

		// :: [MovieClip]무비클립 클릭 핸들러 등록 roo
		public static function hb_mc_addClickHandler_roo(target:MovieClip, clickHandler:Function):void
		{
			MovieClipUtil.add_clickHandler_roo(target, clickHandler);
		}
		///////////////////////////////////////////////////////////////////////////////////////////////////


		///////////////////////////////////////////////////////////////////////////////////////////////////
		// # Number Utils
		///////////////////////////////////////////////////////////////////////////////////////////////////
		// :: [Number]특정 값 사이에 랜덤값 구하기
		public static function hb_num_randRange(min:Number, max:Number):Number
		{
			return NumberUtil.randRange(min, max);
		}
		///////////////////////////////////////////////////////////////////////////////////////////////////


		///////////////////////////////////////////////////////////////////////////////////////////////////
		// # Object Utils
		///////////////////////////////////////////////////////////////////////////////////////////////////
		// :: [Object]무비클립 콜백 호출
		public static function hb_obj_dispatchCallBack(target:Object, eventObj:Object):void
		{
			ObjectUtil.dispatchCallBack(target, eventObj);
		}

		// :: [Object]오브젝트에서 동적 메서드 호출
		public static function hb_obj_methodCall(target:Object, name:String, args:Array = null):void
		{
			ObjectUtil.methodCall(target, name, args);
		}

		// :: [Object]오브젝트에서 동적 속성항목 전부 출력하기
		public static function hb_obj_get_toString(target:Object):String
		{
			return ObjectUtil.get_toString(target);
		}
		///////////////////////////////////////////////////////////////////////////////////////////////////


		///////////////////////////////////////////////////////////////////////////////////////////////////
		// # String Utils
		///////////////////////////////////////////////////////////////////////////////////////////////////
		// :: [String]에서 라스트 인덱트 찾기
		public static function hb_str_getLastIndex(name:String, token:String = '_'):int
		{
			return StringUtil.getLastIndex(name);
		}

		// :: [String]에서 라스트 인덱트 찾기 2
		public static function hb_str_getLastIndex2(name:String, step:uint = 0, token:String = '_'):int
		{
			return StringUtil.getLastIndex2(name, step, token);
		}

		// :: [String]현재 파일 이름만 반환
		public static function hb_str_getThisName(url:String, extStr:String = 'swf'):String
		{
			return StringUtil.getThisName(url, extStr);
		}

		// :: [String]절대 경로 반환하기
		public static function hb_str_getBaseUrl(url:String):String
		{
			return StringUtil.getBaseUrl(url);
		}

		// :: [String]토큰문자 개수만큼 추가하기
		public static function hb_str_addToken(target:String, count:int, token:String = '0'):String
		{
			return StringUtil.addToken(target, count, token);
		}
		///////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
