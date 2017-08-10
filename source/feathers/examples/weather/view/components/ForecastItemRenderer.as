package feathers.examples.weather.view.components
{
	import feathers.controls.renderers.LayoutGroupListItemRenderer;
	import feathers.controls.text.TextBlockTextRenderer;
	import feathers.examples.weather.model.ForecastItem;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import flash.filters.DropShadowFilter;
	import flash.text.engine.ContentElement;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.GroupElement;
	import flash.text.engine.TextElement;

	import starling.display.Quad;
	import feathers.skins.IStyleProvider;

	public class ForecastItemRenderer extends LayoutGroupListItemRenderer
	{
		public static var globalStyleProvider:IStyleProvider;

		private static const CONDITION_CODE_UNAVAILABLE:int = 3200;

		private static const DEGREES_SYMBOL:String = "°";

		public function ForecastItemRenderer()
		{
		}

		override protected function get defaultStyleProvider():IStyleProvider
		{
			return ForecastItemRenderer.globalStyleProvider;
		}

		private var _background:Quad;
		private var _iconTextElement:TextElement;
		private var _tempTextElement:TextElement;
		private var _groupElement:GroupElement;
		private var _titleTextRenderer:TextBlockTextRenderer;
		private var _detail1TextRenderer:TextBlockTextRenderer;
		private var _iconAndTempTextRenderer:TextBlockTextRenderer;
		private var _detail2TextRenderer:TextBlockTextRenderer;

		private var _iconElementFormat:ElementFormat;

		public function get iconElementFormat():ElementFormat
		{
			return this._iconElementFormat;
		}

		public function set iconElementFormat(value:ElementFormat):void
		{
			if(this._iconElementFormat == value)
			{
				return;
			}
			this._iconElementFormat = value;
			this.invalidate(INVALIDATION_FLAG_STYLES);
		}

		private var _temperatureElementFormat:ElementFormat;

		public function get temperatureElementFormat():ElementFormat
		{
			return this._temperatureElementFormat;
		}

		public function set temperatureElementFormat(value:ElementFormat):void
		{
			if(this._temperatureElementFormat == value)
			{
				return;
			}
			this._temperatureElementFormat = value;
			this.invalidate(INVALIDATION_FLAG_STYLES);
		}

		private var _titleElementFormat:ElementFormat;

		public function get titleElementFormat():ElementFormat
		{
			return this._titleElementFormat;
		}

		public function set titleElementFormat(value:ElementFormat):void
		{
			if(this._titleElementFormat == value)
			{
				return;
			}
			this._titleElementFormat = value;
			this.invalidate(INVALIDATION_FLAG_STYLES);
		}

		private var _detailElementFormatFactory:Function;

		public function get detailElementFormatFactory():Function
		{
			return this._detailElementFormatFactory;
		}

		public function set detailElementFormatFactory(value:Function):void
		{
			if(this._detailElementFormatFactory == value)
			{
				return;
			}
			this._detailElementFormatFactory = value;
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

		private var _filter:DropShadowFilter;
		private var _filters:Array;

		override protected function initialize():void
		{
			this.layout = new AnchorLayout();

			this._filter = new DropShadowFilter(3, 45, 0, 1, 0, 0);
			this._filters = [this._filter];

			this._background = new Quad(10, 10);
			this.addChild(this._background);

			this._titleTextRenderer = new TextBlockTextRenderer();
			this._titleTextRenderer.layoutData = new AnchorLayoutData();
			this.addChild(this._titleTextRenderer);

			this._detail1TextRenderer = new TextBlockTextRenderer();
			this._detail1TextRenderer.layoutData = new AnchorLayoutData();
			this.addChild(this._detail1TextRenderer);

			this._iconAndTempTextRenderer = new TextBlockTextRenderer();
			this._iconAndTempTextRenderer.layoutData = new AnchorLayoutData();
			this.addChild(this._iconAndTempTextRenderer);

			this._detail2TextRenderer = new TextBlockTextRenderer();
			this._detail2TextRenderer.layoutData = new AnchorLayoutData();
			this.addChild(this._detail2TextRenderer);

			this._iconTextElement = new TextElement();
			this._tempTextElement = new TextElement();
			this._groupElement = new GroupElement(new <ContentElement>[this._iconTextElement, this._tempTextElement]);
		}

		override protected function draw():void
		{
			var stylesInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_STYLES);
			if(stylesInvalid)
			{
				this._titleTextRenderer.elementFormat = this._titleElementFormat;
				this._iconTextElement.elementFormat = this._iconElementFormat;
				this._tempTextElement.elementFormat = this._temperatureElementFormat;
				this._filter.distance = this._temperatureElementFormat.fontSize / 33;
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
				var accentElementFormat:ElementFormat;
				if(code != CONDITION_CODE_UNAVAILABLE && this._conditionCodeToIcon.hasOwnProperty(codeAsString))
				{
					this._iconTextElement.text = this._conditionCodeToIcon[code];
					this._background.color = this._conditionCodeToColor[code];
					this._filter.color = this._conditionCodeToAccentColor[code];
					accentElementFormat = this._detailElementFormatFactory(this._conditionCodeToAccentColor[code]);
				}
				else
				{
					this._iconTextElement.text = this._unavailableConditionCodeIcon;
					this._background.color = this._unavailableConditionCodeColor;
					this._filter.color = this._unavailableConditionCodeAccentColor;
					accentElementFormat = this._detailElementFormatFactory(this._unavailableConditionCodeAccentColor);
				}
				this._titleTextRenderer.nativeFilters = null;
				this._titleTextRenderer.nativeFilters = this._filters;
				this._iconAndTempTextRenderer.nativeFilters = null;
				this._iconAndTempTextRenderer.nativeFilters = this._filters;
				this._detail1TextRenderer.elementFormat = accentElementFormat;
				this._detail2TextRenderer.elementFormat = accentElementFormat;
				if(data.day)
				{
					this._titleTextRenderer.text = data.day;
					this._detail2TextRenderer.text = data.low + DEGREES_SYMBOL;
					this._tempTextElement.text = data.high + DEGREES_SYMBOL;
				}
				else
				{
					this._titleTextRenderer.text = "Now";
					this._detail2TextRenderer.text = null;
					this._tempTextElement.text = data.temp + DEGREES_SYMBOL;
				}
				this._iconAndTempTextRenderer.content = this._groupElement;
				this._detail1TextRenderer.text = data.text;
			}
			else
			{
				this._titleTextRenderer.text = null;
				this._detail1TextRenderer.text = null;
				this._iconAndTempTextRenderer.content = null;
				this._detail2TextRenderer.text = null;
			}
		}

		override protected function preLayout():void
		{
			//we don't want this measured by the AnchorLayout, and it may not
			//support ILayoutData.
			this._background.width = 0;
			this._background.height = 0;

			var layoutData:AnchorLayoutData = AnchorLayoutData(this._titleTextRenderer.layoutData);
			layoutData.top = this._padding;
			layoutData.right = this._padding;
			layoutData.left = this._padding;

			layoutData = AnchorLayoutData(this._detail1TextRenderer.layoutData);
			layoutData.topAnchorDisplayObject = this._titleTextRenderer
			layoutData.top = this._gap;
			layoutData.right = this._padding;
			layoutData.left = this._padding;

			layoutData = AnchorLayoutData(this._detail2TextRenderer.layoutData);
			layoutData.bottom = this._padding;
			layoutData.right = this._padding;

			this._iconAndTempTextRenderer.validate();
			layoutData = AnchorLayoutData(this._iconAndTempTextRenderer.layoutData);
			layoutData.horizontalCenter = 0;
			layoutData.verticalCenter = this._iconAndTempTextRenderer.height / 4;
		}

		override protected function postLayout():void
		{
			this._background.width = this.actualWidth;
			this._background.height = this.actualHeight;
		}
	}
}
