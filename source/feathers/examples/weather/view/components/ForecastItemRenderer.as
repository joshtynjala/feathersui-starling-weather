package feathers.examples.weather.view.components
{
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.renderers.LayoutGroupListItemRenderer;
	import feathers.controls.text.TextBlockTextRenderer;
	import feathers.examples.weather.model.ForecastItem;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalAlign;
	import feathers.skins.IStyleProvider;

	import starling.display.Quad;
	import starling.text.TextFormat;

	public class ForecastItemRenderer extends LayoutGroupListItemRenderer
	{
		public static var globalStyleProvider:IStyleProvider;

		private static const CONDITION_CODE_UNAVAILABLE:int = 3200;

		private static const DEGREES_SYMBOL:String = "°";

		public function ForecastItemRenderer()
		{
			super();
		}

		override protected function get defaultStyleProvider():IStyleProvider
		{
			return ForecastItemRenderer.globalStyleProvider;
		}

		private var _background:Quad;
		private var _iconAndTempGroup:LayoutGroup;
		private var _iconLabel:Label;
		private var _tempLabel:Label;
		private var _titleLabel:Label;
		private var _detail1Label:Label;
		private var _detail2Label:Label;

		private var _iconFontStyles:TextFormat;

		public function get iconFontStyles():TextFormat
		{
			return this._iconFontStyles;
		}

		public function set iconFontStyles(value:TextFormat):void
		{
			if(this._iconFontStyles == value)
			{
				return;
			}
			this._iconFontStyles = value;
			this.invalidate(INVALIDATION_FLAG_STYLES);
		}

		private var _temperatureFontStyles:TextFormat;

		public function get temperatureFontStyles():TextFormat
		{
			return this._temperatureFontStyles;
		}

		public function set temperatureFontStyles(value:TextFormat):void
		{
			if(this._temperatureFontStyles == value)
			{
				return;
			}
			this._temperatureFontStyles = value;
			this.invalidate(INVALIDATION_FLAG_STYLES);
		}

		private var _titleFontStyles:TextFormat;

		public function get titleFontStyles():TextFormat
		{
			return this._titleFontStyles;
		}

		public function set titleFontStyles(value:TextFormat):void
		{
			if(this._titleFontStyles == value)
			{
				return;
			}
			this._titleFontStyles = value;
			this.invalidate(INVALIDATION_FLAG_STYLES);
		}

		private var _detailFontStylesFactory:Function;

		public function get detailFontStylesFactory():Function
		{
			return this._detailFontStylesFactory;
		}

		public function set detailFontStylesFactory(value:Function):void
		{
			if(this._detailFontStylesFactory == value)
			{
				return;
			}
			this._detailFontStylesFactory = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		private var _conditionCodeToIcon:Vector.<String>;

		public function get conditionCodeToIcon():Vector.<String>
		{
			return this._conditionCodeToIcon;
		}

		public function set conditionCodeToIcon(value:Vector.<String>):void
		{
			if(this._conditionCodeToIcon == value)
			{
				return;
			}
			this._conditionCodeToIcon = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		private var _unavailableConditionCodeIcon:String;

		public function get unavailableConditionCodeIcon():String
		{
			return this._unavailableConditionCodeIcon;
		}

		public function set unavailableConditionCodeIcon(value:String):void
		{
			if(this._unavailableConditionCodeIcon == value)
			{
				return;
			}
			this._unavailableConditionCodeIcon = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		private var _conditionCodeToColor:Vector.<uint>;

		public function get conditionCodeToColor():Vector.<uint>
		{
			return this._conditionCodeToColor;
		}

		public function set conditionCodeToColor(value:Vector.<uint>):void
		{
			if(this._conditionCodeToColor == value)
			{
				return;
			}
			this._conditionCodeToColor = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		private var _conditionCodeToAccentColor:Vector.<uint>;

		public function get conditionCodeToAccentColor():Vector.<uint>
		{
			return this._conditionCodeToAccentColor;
		}

		public function set conditionCodeToAccentColor(value:Vector.<uint>):void
		{
			if(this._conditionCodeToAccentColor == value)
			{
				return;
			}
			this._conditionCodeToAccentColor = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		private var _unavailableConditionCodeColor:uint;

		public function get unavailableConditionCodeColor():uint
		{
			return this._unavailableConditionCodeColor;
		}

		public function set unavailableConditionCodeColor(value:uint):void
		{
			if(this._unavailableConditionCodeColor == value)
			{
				return;
			}
			this._unavailableConditionCodeColor = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		private var _unavailableConditionCodeAccentColor:uint;

		public function get unavailableConditionCodeAccentColor():uint
		{
			return this._unavailableConditionCodeAccentColor;
		}

		public function set unavailableConditionCodeAccentColor(value:uint):void
		{
			if(this._unavailableConditionCodeAccentColor == value)
			{
				return;
			}
			this._unavailableConditionCodeAccentColor = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		private var _padding:Number = 0;

		public function get padding():Number
		{
			return this._padding;
		}

		public function set padding(value:Number):void
		{
			if(this._padding == value)
			{
				return;
			}
			this._padding = value;
			this.invalidate(INVALIDATION_FLAG_STYLES);
		}

		private var _gap:Number = 0;

		public function get gap():Number
		{
			return this._gap;
		}

		public function set gap(value:Number):void
		{
			if(this._gap == value)
			{
				return;
			}
			this._gap = value;
			this.invalidate(INVALIDATION_FLAG_STYLES);
		}

		override protected function initialize():void
		{
			this.layout = new AnchorLayout();

			this._background = new Quad(10, 10);
			this.addChild(this._background);

			this._titleLabel = new Label();
			this._titleLabel.layoutData = new AnchorLayoutData();
			this.addChild(this._titleLabel);

			this._detail1Label = new Label();
			this._detail1Label.layoutData = new AnchorLayoutData();
			this.addChild(this._detail1Label);

			this._iconAndTempGroup = new LayoutGroup();
			var iconAndTempLayout:HorizontalLayout = new HorizontalLayout();
			iconAndTempLayout.gap = 4;
			this._iconAndTempGroup.layout = iconAndTempLayout;
			this._iconAndTempGroup.layoutData = new AnchorLayoutData();
			this.addChild(this._iconAndTempGroup);

			this._iconLabel = new Label();
			this._iconAndTempGroup.addChild(this._iconLabel);

			this._tempLabel = new Label();
			this._iconAndTempGroup.addChild(this._tempLabel);

			this._detail2Label = new Label();
			this._detail2Label.layoutData = new AnchorLayoutData();
			this.addChild(this._detail2Label);
		}

		override protected function draw():void
		{
			var stylesInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_STYLES);
			if(stylesInvalid)
			{
				this._titleLabel.fontStyles = this._titleFontStyles;
				this._iconLabel.fontStyles = this._iconFontStyles;
				this._tempLabel.fontStyles = this._temperatureFontStyles;
			}
			super.draw();
		}

		override protected function commitData():void
		{
			if(this._data)
			{
				var data:ForecastItem = ForecastItem(this._data);
				var codeAsString:String = data.code;
				var code:int = parseInt(codeAsString, 10);
				var accentFontStyles:TextFormat;
				if(code != CONDITION_CODE_UNAVAILABLE && this._conditionCodeToIcon.hasOwnProperty(codeAsString))
				{
					this._iconLabel.text = this._conditionCodeToIcon[code];
					this._background.color = this._conditionCodeToColor[code];
					accentFontStyles = this._detailFontStylesFactory(this._conditionCodeToAccentColor[code]);
				}
				else
				{
					this._iconLabel.text = this._unavailableConditionCodeIcon;
					this._background.color = this._unavailableConditionCodeColor;
					accentFontStyles = this._detailFontStylesFactory(this._unavailableConditionCodeAccentColor);
				}
				this._detail1Label.fontStyles = accentFontStyles;
				this._detail2Label.fontStyles = accentFontStyles;
				if(data.day)
				{
					this._titleLabel.text = data.day;
					this._detail2Label.text = data.low + DEGREES_SYMBOL;
					this._tempLabel.text = data.high + DEGREES_SYMBOL;
				}
				else
				{
					this._titleLabel.text = "Now";
					this._detail2Label.text = null;
					this._tempLabel.text = data.temp + DEGREES_SYMBOL;
				}
				this._detail1Label.text = data.text;
			}
			else
			{
				this._titleLabel.text = null;
				this._detail1Label.text = null;
				this._iconLabel.text = null;
				this._tempLabel.text = null;
				this._detail2Label.text = null;
			}
		}

		override protected function preLayout():void
		{
			//we don't want this measured by the AnchorLayout, and it may not
			//support ILayoutData.
			this._background.width = 0;
			this._background.height = 0;

			var layoutData:AnchorLayoutData = AnchorLayoutData(this._titleLabel.layoutData);
			layoutData.top = this._padding;
			layoutData.right = this._padding;
			layoutData.left = this._padding;

			layoutData = AnchorLayoutData(this._detail1Label.layoutData);
			layoutData.topAnchorDisplayObject = this._titleLabel
			layoutData.top = this._gap;
			layoutData.right = this._padding;
			layoutData.left = this._padding;

			layoutData = AnchorLayoutData(this._detail2Label.layoutData);
			layoutData.bottom = this._padding;
			layoutData.right = this._padding;

			this._iconAndTempGroup.validate();
			layoutData = AnchorLayoutData(this._iconAndTempGroup.layoutData);
			layoutData.horizontalCenter = 0;
			layoutData.verticalCenter = this._iconAndTempGroup.height / 4;
		}

		override protected function postLayout():void
		{
			this._background.width = this.actualWidth;
			this._background.height = this.actualHeight;
		}
	}
}
