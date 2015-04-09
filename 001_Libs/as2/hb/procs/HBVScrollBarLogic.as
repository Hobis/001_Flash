/**
	@name : HB Vertical ScollBar
	@author : jungheebum(jhb0b@naver.com)
	@blog : http://blog.naver.com/jhb0b
	@date : 2009-04-02
*/
import hb.utils.Adapter;
import hb.effects.HBTween;
import hb.effects.easing.*;

class hb.procs.HBVScrollBarLogic
{
	//---------------------------------------------------------------------------------------------------------
	//
	//	Construct
	//
	//---------------------------------------------------------------------------------------------------------
	public function HBVScrollBarLogic(targetContainer:MovieClip, size:Number, controlTarget:Object, id:String)
	{
		if (arguments.length >= 3)
		{
			this.p_init(targetContainer, size, controlTarget, id);
		}
	}
	//---------------------------------------------------------------------------------------------------------

	//---------------------------------------------------------------------------------------------------------
	//
	//	Private method's
	//
	//---------------------------------------------------------------------------------------------------------
	private function p_init(targetContainer:MovieClip, size:Number, controlTarget:Object, id:String):Void
	{
		this.setTarget(targetContainer);
		this.p_setSize(size);
		this.setControlTarget(controlTarget);

		if (id != undefined)
		{
			this.setId(id);
		}

		if (this.__tweenPos == null)
		{
			this.__tweenPos = new HBTween(this, '__controlTargetPos');
			this.__tweenPos.onTweenUpdate = Adapter.wrap(this, this.p_tweenUpdate);
		}
	}

	private function p_setSize(v:Number):Void
	{
		if (v < this.__totalMinSize)
		{
			v = this.__totalMinSize;
		}

		this.__totalSize = v;
		this.__trackClip[this.__sizeProp] = this.__totalSize;
		this.__maskClip[this.__sizeProp] = this.__totalSize;
	}

	private function p_setThumbSize(v:Number):Void
	{
		if (v < this.__thumbMinSize)
		{
			v = this.__thumbMinSize;
		}

		this.__thumbSize = v;
		this.__thumbClip[this.__sizeProp] = this.__thumbSize;
	}

	private function p_update():Void
	{
		this.__controlTargetSize = this.__controlTarget[this.__sizeProp];

		var t_width:Number = this.__controlTarget[this.__targetMaskSizeProp];
		this.__maskClip[this.__targetMaskSizeProp] = t_width;
		this.__maskClip[this.__targetMaskPosProp] = -t_width;

		var pn:Number;
		if (this.__totalSize >= this.__controlTargetSize)
		{
			pn = 1;
			this.__thumbClip._visible = false;
		}
		else
		{
			pn = this.__totalSize / this.__controlTargetSize;
			this.__thumbClip._visible = true;
		}

		this.p_setThumbSize(Math.round(this.__totalSize * pn));

		this.__controlTargetMoveArea.size = this.__controlTargetSize - this.__totalSize;
		this.__controlTargetMoveArea.begin = this.__controlTargetMoveArea.end - this.__controlTargetMoveArea.size;

		this.__thumbMoveArea.size = this.__totalSize - this.__thumbSize;
		this.__thumbMoveArea.end = this.__thumbMoveArea.begin + this.__thumbMoveArea.size;

		this.p_thumbUpdate(this.__thumbPos);
		this.p_controlTargetPositionUpdate();

		trace('p_update');
	}

	private function p_thumbMouseDown():Void
	{
		if (!this.p_getScrollCheck())
		{
			return;
		}

		this.p_thumbAddHandler();
		this.p_thumbMouseMove();
	}

	private function p_getScrollCheck():Boolean
	{
		return (this.__totalSize < this.__controlTargetSize);
	}

	private function p_thumbAddHandler():Void
	{
		this.__thumbMouseDownPos = this.__targetContainer[this.__mouseProp] - this.__thumbPos;
		this.__thumbClip.onMouseMove = Adapter.wrap(this, this.p_thumbMouseMove);
		this.__thumbClip.onMouseUp = Adapter.wrap(this, this.p_thumbMouseUp);
	}

	private function p_trackMouseDown():Void
	{
		var pn:Number = Math.round(this.__targetContainer[this.__mouseProp] - (this.__thumbSize / 2));
		this.p_thumbUpdate(pn);
		this.p_controlTargetPositionUpdate();
		this.p_thumbAddHandler();
	}

	private function p_thumbMouseMove():Void
	{
		this.p_thumbUpdate(Math.round(this.__targetContainer[this.__mouseProp] - this.__thumbMouseDownPos));
		this.p_controlTargetPositionUpdate();
		updateAfterEvent();
	}

	private function p_thumbUpdate(v:Number):Void
	{
		this.__thumbPos = v;

		if (this.__thumbPos < this.__thumbMoveArea.begin)
		{
			this.__thumbPos = this.__thumbMoveArea.begin;
		}
		else if (this.__thumbPos > this.__thumbMoveArea.size)
		{
			this.__thumbPos = this.__thumbMoveArea.size;
		}

		this.__thumbClip[this.__posProp] = this.__thumbPos;
	}

	private function p_tweenUpdate(o:Object, v:Number):Void
	{
		this.__controlTarget[this.__posProp] = this.__controlTargetPos;
	}

	private function p_controlTargetPositionUpdate():Void
	{
		var pn:Number = this.__thumbPos / this.__thumbMoveArea.size;

		if (isNaN(pn))
		{
			pn = 0;
		}

		var t_value:Number = this.__controlTargetMoveArea.end - (this.__controlTargetMoveArea.size * pn);

		if (this.__isMotion)
		{
			this.__tweenPos.to(t_value);
		}
		else
		{
			this.__controlTargetPos = t_value;
			this.__controlTarget[this.__posProp] = this.__controlTargetPos;
		}

		if (this.onScrollUpdate != null)
		{
			this.onScrollUpdate(pn);
		}
	}

	private function p_thumbMouseUp():Void
	{
		this.__thumbClip.onMouseMove = null;
		this.__thumbClip.onMouseUp = null;
	}

	private function p_thumbMouseWheel(delta:Number):Void
	{
		if (!this.p_getScrollCheck())
		{
			return;
		}

		var t_pn:Number = this.__controlTargetPos + (this.__wheelGap * (delta / 3));

		if (t_pn < this.__controlTargetMoveArea.begin)
		{
			t_pn = this.__controlTargetMoveArea.begin;
		}
		else if (t_pn > this.__controlTargetMoveArea.end)
		{
			t_pn = this.__controlTargetMoveArea.end;
		}

		this.p_setControlTargetPosition(t_pn);
	}

	private function p_setControlTargetPosition(v:Number):Void
	{

		if (this.__isMotion)
		{
			this.__tweenPos.to(v);
		}
		else
		{
			this.__controlTargetPos = v;
			this.__controlTarget[this.__posProp] = this.__controlTargetPos;
		}

		var pn:Number = (this.__controlTargetMoveArea.size - (v - this.__controlTargetMoveArea.begin)) / this.__controlTargetMoveArea.size;

		this.p_thumbUpdate(pn * this.__thumbMoveArea.end);
	}
	//---------------------------------------------------------------------------------------------------------

	//---------------------------------------------------------------------------------------------------------
	//
	//	Public method's
	//
	//---------------------------------------------------------------------------------------------------------
	/** 세팅 값 업데이트 */
	public function update():Void
	{
		this.p_update();
	}

	/** 타겟 참조 리턴 */
	public function getTarget():MovieClip
	{
		return this.__targetContainer;
	}

	/** 타겟 참조 설정 */
	public function setTarget(targetContainer:MovieClip, id:String):Void
	{
		this.__targetContainer = targetContainer;

		this.__thumbClip = this.__targetContainer['scrollBarThumb_do'];
		this.__maskClip = this.__targetContainer['maskwave_do'];
		this.__trackClip = this.__targetContainer['scrollTrack_do'];

		this.__thumbClip.useHandCursor = false;
		this.__trackClip.useHandCursor = false;
		this.__thumbClip._visible = false;
		this.__maskClip._visible = false;

		this.__thumbSize = this.__trackClip[this.__sizeProp];
		this.__controlTargetMoveArea.end = this.__targetContainer[this.__posProp];
		this.__thumbPos = this.__thumbClip[this.__posProp];

		if (id != undefined)
		{
			this.setId(id);
		}
	}

	/** 스크롤 바의 높이 값 반환 */
	public function getSize():Number
	{
		return this.__totalSize;
	}

	/** 스크롤 바의 높이 값 설정 */
	public function setSize(v:Number):Void
	{
		this.p_setSize(v);
		this.p_update();
	}

	/** 현재 id값 반환 */
	public function getId():String
	{
		return this.__id;
	}

	/** 현재 id값 설정 */
	public function setId(v:String):Void
	{
		this.__id = v;
	}

	/** 스크롤의 타겟이 되는 오브젝트 반환 */
	public function getControlTarget():Object
	{
		return this.__controlTarget;
	}

	/** 스크롤의 타겟이 되는 오브젝트 설정 */
	public function setControlTarget(o:Object):Void
	{
		this.__controlTarget = o;
		this.__controlTarget.setMask(this.__maskClip);
		this.__controlTargetSize = this.__controlTarget[this.__sizeProp];
		this.__controlTargetPos = this.__controlTarget[this.__posProp];
	}

	/** 스크롤 시작 */
	public function run():Void
	{
		if (this.__isRun)
		{
			return;
		}

		this.p_update();

		this.__thumbClip.onPress = Adapter.wrap(this, this.p_thumbMouseDown);
		this.__trackClip.onPress = Adapter.wrap(this, this.p_trackMouseDown);
		this.__controlTarget.onMouseWheel = Adapter.wrap(this, this.p_thumbMouseWheel);
		Mouse.addListener(this.__controlTarget);

		this.__isRun = true;
	}

	/** 스크롤 멈춤 */
	public function stop():Void
	{
		if (!this.__isRun)
		{
			return;
		}

		this.__thumbClip.onPress = null;
		this.__thumbClip.onMouseMove = null;
		this.__thumbClip.onMouseUp = null;
		Mouse.removeListener(this.__controlTarget);
		this.__controlTarget.onMouseWheel = null;
		this.__trackClip.onPress = null;

		this.__isRun = false;
	}

	public function getThumbMoveArea():Object
	{
		return this.__thumbMoveArea;
	}

	public function setThumbMoveArea(o:Object):Void
	{
		this.__thumbMoveArea = o;
	}

	public function getControlTargetMoveArea():Object
	{
		return this.__controlTargetMoveArea;
	}

	public function setControlTargetMoveArea(o:Object):Void
	{
		this.__controlTargetMoveArea = o;
	}

	public function getWheelGap():Number
	{
		return this.__wheelGap;
	}

	public function setWheelGap(v:Number):Void
	{
		this.__wheelGap = v;
	}

	public function getThumbMinHeight():Number
	{
		return this.__thumbMinSize;
	}

	public function setThumbMinHeight(v:Number):Void
	{
		this.__thumbMinSize = v;
	}

	public function getIsMotion():Boolean
	{
		return this.__isMotion;
	}

	public function setIsMotion(b:Boolean):Void
	{
		this.__isMotion = b;
	}

	public function getTweenPos():HBTween
	{
		return this.__tweenPos;
	}

	public function setTweenPos(o:HBTween):Void
	{
		this.__tweenPos;
	}

	public function getDuration():HBTween
	{
		return this.__tweenPos;
	}

	public function setDuration(v:Number):Void
	{
		if (this.__tweenPos != null)
		{
			this.__tweenPos.duration = v;
		}
	}

	public function getEasing():Function
	{
		return this.__tweenPos.func;
	}

	public function setEasing(f:Function):Void
	{
		if (this.__tweenPos != null)
		{
			this.__tweenPos.func = f;
		}
	}

	public function getTotalMinSize():Number
	{
		return this.__totalMinSize;
	}

	public function setTotalMinSize(v:Number):Void
	{
		this.__totalMinSize = v;
	}

	public function getDirectionType():String
	{
		return this.__directionType;
	}

	public function setDirectionType(v:String):Void
	{
		this.__directionType = v;

		if (this.__directionType == __DIR_VIRTICAL)
		{
			this.__sizeProp = '_height';
			this.__posProp = '_y';
			this.__mouseProp = '_ymouse';
		}
		else if (this.__directionType == __DIR_HORIZONTAL)
		{
			this.__sizeProp = '_width';
			this.__posProp = '_x';
			this.__mouseProp = '_xmouse';
		}


	}
	//---------------------------------------------------------------------------------------------------------

	//---------------------------------------------------------------------------------------------------------
	//
	//	Property's
	//
	//---------------------------------------------------------------------------------------------------------
	/** 무비클립 들 */
	private var __targetContainer:MovieClip = null;
	private var __thumbClip:MovieClip = null;
	private var __maskClip:MovieClip = null;
	private var __trackClip:MovieClip = null;

	/** 컨트롤 타겟 */
	private var __controlTarget:Object = null;
	/** controlTarget의 현재 높이 값 */
	private var __controlTargetSize:Number;
	/** controlTarget의 현재 포지션 값 */
	private var __controlTargetPos:Number;

	/** 스크롤 바의 총 높이 */
	private var __totalSize:Number;
	/** 스크롤 바의 최소 높이 */
	private var __totalMinSize:Number = 60;

	/** thumbClip의 높이 값 */
	private var __thumbSize:Number;
	/** thumbClip의 최소 높이 값 */
	private var __thumbMinSize:Number = 12;
	/** thumbClip을 마우스 다운한 좌표(x, y 둘다 만족) */
	private var __thumbMouseDownPos:Number;
	/** thumbClip의 현재 포지션 값 */
	private var __thumbPos:Number;

	/** 한번에 타겟이 이동 하는 간격 */
	private var __wheelGap:Number = 10;


	/** thumbClip이 움직임 영역 */
	private var __thumbMoveArea:Object =
	{
		begin: 0,
		end: 0,
		size: 0
	};
	/** thumbClip이 움직이는 영역 */
	private var __controlTargetMoveArea:Object =
	{
		begin: 0,
		end: 0,
		size: 0
	};

	private var __id:String = null;
	private var __isRun:Boolean = false;

	public var onScrollUpdate:Function = null;

	/** 트윈을 사용할 것인가 여부 */
	private var __isMotion:Boolean = false;

	/** 트윈 객체 */
	private var __tweenPos:HBTween = null;

	private static var __DIR_VIRTICAL:String = 'vertical';
	private static var __DIR_HORIZONTAL:String = 'horizontal';

	/** */
	private var __directionType:String = __DIR_VIRTICAL;

	private var __sizeProp:String = '_height';
	private var __posProp:String = '_y';
	private var __mouseProp:String = '_ymouse';

	private var __targetMaskSizeProp:String = '_width';
	private var __targetMaskPosProp:String = '_x';
	//---------------------------------------------------------------------------------------------------------
}
