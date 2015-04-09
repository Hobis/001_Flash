/**
	@Name: SliderLogic
	@Author: HobisJung
	@Date: 2012-05-30
*/
import hb.utils.Adapter;

class hb.uilogics.SliderLogic
{
	public function SliderLogic(container:MovieClip, ratioType:String)
	{
		this.m_container = container;
		this.m_track = this.m_container.track_mc;
		this.m_thumb = this.m_container.thumb_mc;
		this.m_ratioType = (ratioType != undefined) ? ratioType : RATIO_TYPE_HORIZONTAL;

		this.m_areaRect = {};
		this.m_areaRect.thumbWidth = this.m_thumb._width;
		this.m_areaRect.thumbHeight = this.m_thumb._height;

		this.m_areaRect.marginWidth = this.m_thumb._x;
		this.m_areaRect.left = this.m_areaRect.marginWidth;
		this.m_areaRect.width =
			this.m_container._width - (this.m_areaRect.thumbWidth + (this.m_areaRect.marginWidth * 2));
		this.m_areaRect.right = this.m_areaRect.left + this.m_areaRect.width;

		this.m_areaRect.marginHeight = this.m_thumb._y;
		this.m_areaRect.top = this.m_areaRect.marginHeight;
		this.m_areaRect.height =
			this.m_container._height - (this.m_areaRect.thumbHeight + (this.m_areaRect.marginHeight * 2));
		this.m_areaRect.bottom = this.m_areaRect.top + this.m_areaRect.height;

		this.m_thumbDownPos = {};
		this.m_thumbDownPos.x = NaN;
		this.m_thumbDownPos.y = NaN;

		this.m_thumbPos = {};
		this.m_thumbPos.x = this.m_thumb._x;
		this.m_thumbPos.y = this.m_thumb._y;

		this.setValues(0, 1);
	}

	private function p_getRatio():Number
	{
		var t_rv:Number;

		if (this.m_ratioType == RATIO_TYPE_HORIZONTAL)
		{
			t_rv =
				(this.m_thumbPos.x - this.m_areaRect.marginWidth) /
				(this.m_areaRect.right - this.m_areaRect.marginWidth);
		}
		else if (this.m_ratioType == RATIO_TYPE_VERTICAL)
		{
			t_rv =
				(this.m_thumbPos.y - this.m_areaRect.marginHeight) /
				(this.m_areaRect.bottom - this.m_areaRect.marginHeight);
		}

		return t_rv;
	}

	private function p_positionUpdate():Void
	{
		if (this.m_ratioType == RATIO_TYPE_HORIZONTAL)
		{
			if (this.m_thumbPos.x < this.m_areaRect.left)
			{
				this.m_thumbPos.x = this.m_areaRect.left;
			}
			else if (this.m_thumbPos.x > this.m_areaRect.right)
			{
				this.m_thumbPos.x = this.m_areaRect.right;
			}

			this.m_thumb._x = this.m_thumbPos.x;
		}
		else if (this.m_ratioType == RATIO_TYPE_VERTICAL)
		{
			if (this.m_thumbPos.y < this.m_areaRect.top)
			{
				this.m_thumbPos.y = this.m_areaRect.top;
			}
			else if (this.m_thumbPos.y > this.m_areaRect.bottom)
			{
				this.m_thumbPos.y = this.m_areaRect.bottom;
			}

			this.m_thumb._y = this.m_thumbPos.y;
		}
	}

	private function p_onMouseMove_thumb():Void
	{
		if (this.m_ratioType == RATIO_TYPE_HORIZONTAL)
		{
			this.m_thumbPos.x = this.m_container._xmouse - this.m_thumbDownPos.x;
		}
		else if (this.m_ratioType == RATIO_TYPE_VERTICAL)
		{
			this.m_thumbPos.y = this.m_container._ymouse - this.m_thumbDownPos.y;
		}

		this.p_positionUpdate();

		if (this.onMouseMoveUpdate != null)
		{
			this.onMouseMoveUpdate();
		}

		updateAfterEvent();
	}

	private function p_onMouseUp_thumb():Void
	{
		this.m_thumb.onMouseUp = null;
		this.m_thumb.onMouseMove = null;

		if (this.onMouseUpUpdate != null)
		{
			this.onMouseUpUpdate();
		}

	}

	private function p_onPress_track():Void
	{
		var t_value:Number;

		var t_startValue:Number;
		var t_endValue:Number;

		var t_thumbHalf:Number;

		if (this.m_ratioType == RATIO_TYPE_HORIZONTAL)
		{
			t_value = this.m_container._xmouse;
			if
			(
				!
				(
					(t_value >= this.m_thumbPos.x) &&
					(t_value <= (this.m_thumbPos.x + this.m_areaRect.thumbWidth))
				)
			)
			{
				t_startValue = this.m_areaRect.left;
				t_endValue = this.m_areaRect.right + this.m_areaRect.thumbWidth;

				if
				(
					(t_value >= t_startValue) && (t_value <= t_endValue)
				)
				{
					t_thumbHalf = Math.round(this.m_areaRect.thumbWidth / 2);
					this.m_thumbPos.x = t_value - t_thumbHalf;

					this.p_positionUpdate();

					if (this.onMouseMoveUpdate != null)
					{
						this.onMouseMoveUpdate();
					}

					this.m_thumbDownPos.x = t_thumbHalf;

					this.m_thumb.onMouseUp = Adapter.wrap(this, this.p_onMouseUp_thumb);
					this.m_thumb.onMouseMove = Adapter.wrap(this, this.p_onMouseMove_thumb);

					if (this.onTrackClickUpdate != null)
					{
						this.onTrackClickUpdate();
					}
				}
			}
		}
		else if (this.m_ratioType == RATIO_TYPE_VERTICAL)
		{
			t_value = this.m_container._ymouse;
			if
			(
				!
				(
					(t_value >= this.m_thumbPos.y) &&
					(t_value <= (this.m_thumbPos.y + this.m_areaRect.thumbHeight))
				)
			)
			{
				t_startValue = this.m_areaRect.top;
				t_endValue = this.m_areaRect.bottom + this.m_areaRect.thumbHeight;

				if
				(
					(t_value >= t_startValue) && (t_value <= t_endValue)
				)
				{
					t_thumbHalf = Math.round(this.m_areaRect.thumbHeight / 2);
					this.m_thumbPos.y = t_value - t_thumbHalf;

					this.p_positionUpdate();

					if (this.onMouseMoveUpdate != null)
					{
						this.onMouseMoveUpdate();
					}

					this.m_thumbDownPos.y = t_thumbHalf;

					this.m_thumb.onMouseUp = Adapter.wrap(this, this.p_onMouseUp_thumb);
					this.m_thumb.onMouseMove = Adapter.wrap(this, this.p_onMouseMove_thumb);

					if (this.onTrackClickUpdate != null)
					{
						this.onTrackClickUpdate();
					}
				}
			}
		}
	}

	private function p_onPress_thumb():Void
	{
		if (this.m_ratioType == RATIO_TYPE_HORIZONTAL)
		{
			this.m_thumbDownPos.x = this.m_thumb._xmouse;
		}
		else if (this.m_ratioType == RATIO_TYPE_VERTICAL)
		{
			this.m_thumbDownPos.y = this.m_thumb._ymouse;
		}

		this.m_thumb.onMouseUp = Adapter.wrap(this, this.p_onMouseUp_thumb);
		this.m_thumb.onMouseMove = Adapter.wrap(this, this.p_onMouseMove_thumb);

		if (this.onMouseDownUpdate != null)
		{
			this.onMouseDownUpdate();
		}

	};

	private function p_eventsSetting():Void
	{
		this.m_thumb.useHandCursor = false;
		this.m_thumb.onPress = Adapter.wrap(this, this.p_onPress_thumb);
		this.m_track.useHandCursor = false;
		this.m_track.onPress = Adapter.wrap(this, this.p_onPress_track);
	}

	public function getRatio():Number
	{
		return this.p_getRatio();
	}

	public function getValue(isRound:Boolean):Number
	{
		isRound = (isRound != undefined) ? isRound : true;

		var t_p:Number =
			this.m_values.min + (this.p_getRatio() * (this.m_values.max - this.m_values.min));
		var t_rv:Number = (isRound) ? Math.round(t_p) : t_p;

		return t_rv;
	}

	public function setValue(values:Number):Void
	{
		if (values < this.m_values.min)
		{
			values = this.m_values.min;
		}
		else if (values > this.m_values.max)
		{
			values = this.m_values.max;
		}

		var t_ratio:Number =
			(values - this.m_values.min) / (this.m_values.max - this.m_values.min);

		if (this.m_ratioType == RATIO_TYPE_HORIZONTAL)
		{
			this.m_thumbPos.x = this.m_areaRect.left +
				Math.round(t_ratio * this.m_areaRect.width);
		}
		else if (this.m_ratioType == RATIO_TYPE_VERTICAL)
		{
			this.m_thumbPos.y = this.m_areaRect.top +
				Math.round(t_ratio * this.m_areaRect.height);
		}

		this.p_positionUpdate();
	}

	public function setValues(minValue:Number, maxValue:Number):Void
	{
		this.m_values =
		{
			min: (minValue == undefined) ? 0 : minValue,
			max: (maxValue == undefined) ? 1 : maxValue
		};
	}

	public function getRatioType():String
	{
		return this.m_ratioType;
	}

	public function run():Void
	{
		this.p_eventsSetting();
	}

	public function stop():Void
	{
		this.p_onMouseUp_thumb();

		this.m_thumb.onPress = Adapter.remove2(this.m_thumb.onPress);
		this.m_thumb.onMouseUp = Adapter.remove2(this.m_thumb.onMouseUp);
		this.m_thumb.onMouseMove = Adapter.remove2(this.m_thumb.onMouseMove);
		this.m_track.onPress = Adapter.remove2(this.m_track.onPress);

		this.m_thumb._x = this.m_areaRect.marginWidth;
		this.m_thumb._y = this.m_areaRect.marginHeight;

		this.m_container = null;
		this.m_thumb = null;

		this.m_areaRect = null;
		this.m_thumbDownPos = null;
		this.m_thumbPos = null;

		this.m_values = null;

		this.m_ratioType = null;

		this.onMouseDownUpdate = null;
		this.onMouseMoveUpdate = null;
		this.onMouseUpUpdate = null;
		this.onTrackClickUpdate = null;
	}


	public static var RATIO_TYPE_HORIZONTAL:String = 'horizontal';
	public static var RATIO_TYPE_VERTICAL:String = 'vertical';

	// - Container
	private var m_container:MovieClip = null;
	// - Drag Track
	private var m_track:MovieClip = null;
	// - Drag Thumbnail
	private var m_thumb:MovieClip = null;

	private var m_areaRect:Object = null;

	private var m_thumbDownPos:Object = null;
	private var m_thumbPos:Object = null;

	private var m_values:Object = null;

	private var m_ratioType:String = null;


	public var onMouseDownUpdate:Function = null;
	public var onMouseMoveUpdate:Function = null;
	public var onMouseUpUpdate:Function = null;
	public var onTrackClickUpdate:Function = null;

}
