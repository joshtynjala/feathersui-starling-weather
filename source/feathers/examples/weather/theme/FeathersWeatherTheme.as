package feathers.examples.weather.theme
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.Panel;
	import feathers.controls.TextInput;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.text.StageTextTextEditor;
	import feathers.controls.text.TextBlockTextRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.ITextEditor;
	import feathers.examples.weather.view.components.FavoriteLocationItemRenderer;
	import feathers.examples.weather.view.components.ForecastItemRenderer;
	import feathers.examples.weather.view.components.ForecastView;
	import feathers.examples.weather.view.components.LocationView;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.TiledRowsLayout;
	import feathers.system.DeviceCapabilities;

	import flash.filters.DropShadowFilter;
	import flash.text.engine.CFFHinting;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.FontLookup;
	import flash.text.engine.FontPosture;
	import flash.text.engine.FontWeight;
	import flash.text.engine.RenderingMode;

	import starling.core.Starling;
	import starling.display.Quad;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import feathers.layout.RelativePosition;
	import feathers.controls.ScrollPolicy;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.VerticalAlign;
	import feathers.controls.ButtonState;
	import feathers.themes.StyleNameFunctionTheme;
	import feathers.skins.ImageSkin;
	import feathers.controls.ItemRendererLayoutOrder;

	public class FeathersWeatherTheme extends StyleNameFunctionTheme
	{
		[Embed(source="/../assets/images/atlas.png")]
		private static const ATLAS_IMAGE:Class;

		[Embed(source="/../assets/images/atlas.xml",mimeType="application/octet-stream")]
		private static const ATLAS_XML:Class;

		[Embed(source="/../assets/fonts/MuseoSans_500.otf",fontFamily="MuseoSans",fontWeight="normal",fontStyle="normal",embedAsCFF="true")]
		private static const MUSEO_SANS_500:Class;

		[Embed(source="/../assets/fonts/MuseoSans_500_Italic.otf",fontFamily="MuseoSans",fontWeight="normal",fontStyle="italic",embedAsCFF="true")]
		private static const MUSEO_SANS_500_ITALIC:Class;

		[Embed(source="/../assets/fonts/typicons.ttf",fontFamily="Typicons",fontWeight="normal",fontStyle="normal",embedAsCFF="true")]
		private static const TYPICONS:Class;

		private static const THEME_STYLE_NAME_LOCATION_VIEW_HEADER:String = "FeathersWeatherTheme-LocationView-Header";
		private static const THEME_STYLE_NAME_LOCATION_LIST_ITEM_RENDERER:String = "FeathersWeatherTheme-LocationList-ItemRenderer";

		private static const TEXT_FONT_NAME:String = "MuseoSans";
		private static const ICON_FONT_NAME:String = "Typicons";

		private static const BACKGROUND_COLOR:uint = 0x4d545e;
		private static const DRAWER_BACKGROUND_COLOR:uint = 0x656d78;
		private static const INSET_BACKGROUND_COLOR:uint = 0x434a54;
		private static const SELECTION_COLOR:uint = 0x37bc9b;

		private static const STORM_COLOR:uint = 0xfc6e51;
		private static const NIGHT_COLOR:uint = 0xac92ec;
		private static const DAY_COLOR:uint = 0xffce54;
		private static const PRECIPITATION_COLOR:uint = 0x5d9cec;
		private static const CLOUD_COLOR:uint = 0xa0d468;

		private static const CONDITION_CODE_TO_COLOR:Vector.<uint> = new <uint>
		[
			STORM_COLOR,
			STORM_COLOR,
			STORM_COLOR,
			STORM_COLOR,
			STORM_COLOR,
			PRECIPITATION_COLOR,
			PRECIPITATION_COLOR,
			PRECIPITATION_COLOR,
			PRECIPITATION_COLOR,
			PRECIPITATION_COLOR,
			PRECIPITATION_COLOR,
			PRECIPITATION_COLOR,
			PRECIPITATION_COLOR,
			PRECIPITATION_COLOR,
			PRECIPITATION_COLOR,
			PRECIPITATION_COLOR,
			PRECIPITATION_COLOR,
			STORM_COLOR,
			PRECIPITATION_COLOR,
			CLOUD_COLOR,
			PRECIPITATION_COLOR,
			CLOUD_COLOR,
			STORM_COLOR,
			CLOUD_COLOR,
			CLOUD_COLOR,
			STORM_COLOR,
			CLOUD_COLOR,
			NIGHT_COLOR,
			CLOUD_COLOR,
			NIGHT_COLOR,
			CLOUD_COLOR,
			NIGHT_COLOR,
			DAY_COLOR,
			NIGHT_COLOR,
			DAY_COLOR,
			PRECIPITATION_COLOR,
			STORM_COLOR,
			STORM_COLOR,
			STORM_COLOR,
			STORM_COLOR,
			PRECIPITATION_COLOR,
			PRECIPITATION_COLOR,
			PRECIPITATION_COLOR,
			PRECIPITATION_COLOR,
			CLOUD_COLOR,
			STORM_COLOR,
			PRECIPITATION_COLOR,
			STORM_COLOR
		];

		private static const STORM_ACCENT_COLOR:uint = 0xb5331f;
		private static const NIGHT_ACCENT_COLOR:uint = 0x6c54a8;
		private static const DAY_ACCENT_COLOR:uint = 0xa87f2d;
		private static const PRECIPITATION_ACCENT_COLOR:uint = 0x345075;
		private static const CLOUD_ACCENT_COLOR:uint = 0x4f7526;

		private static const CONDITION_CODE_TO_ACCENT_COLOR:Vector.<uint> = new <uint>
		[
			STORM_ACCENT_COLOR,
			STORM_ACCENT_COLOR,
			STORM_ACCENT_COLOR,
			STORM_ACCENT_COLOR,
			STORM_ACCENT_COLOR,
			PRECIPITATION_ACCENT_COLOR,
			PRECIPITATION_ACCENT_COLOR,
			PRECIPITATION_ACCENT_COLOR,
			PRECIPITATION_ACCENT_COLOR,
			PRECIPITATION_ACCENT_COLOR,
			PRECIPITATION_ACCENT_COLOR,
			PRECIPITATION_ACCENT_COLOR,
			PRECIPITATION_ACCENT_COLOR,
			PRECIPITATION_ACCENT_COLOR,
			PRECIPITATION_ACCENT_COLOR,
			PRECIPITATION_ACCENT_COLOR,
			PRECIPITATION_ACCENT_COLOR,
			STORM_ACCENT_COLOR,
			PRECIPITATION_ACCENT_COLOR,
			CLOUD_ACCENT_COLOR,
			PRECIPITATION_ACCENT_COLOR,
			CLOUD_ACCENT_COLOR,
			STORM_ACCENT_COLOR,
			CLOUD_ACCENT_COLOR,
			CLOUD_ACCENT_COLOR,
			STORM_ACCENT_COLOR,
			CLOUD_ACCENT_COLOR,
			NIGHT_ACCENT_COLOR,
			CLOUD_ACCENT_COLOR,
			NIGHT_ACCENT_COLOR,
			CLOUD_ACCENT_COLOR,
			NIGHT_ACCENT_COLOR,
			DAY_ACCENT_COLOR,
			NIGHT_ACCENT_COLOR,
			DAY_ACCENT_COLOR,
			PRECIPITATION_ACCENT_COLOR,
			STORM_ACCENT_COLOR,
			STORM_ACCENT_COLOR,
			STORM_ACCENT_COLOR,
			STORM_ACCENT_COLOR,
			PRECIPITATION_ACCENT_COLOR,
			PRECIPITATION_ACCENT_COLOR,
			PRECIPITATION_ACCENT_COLOR,
			PRECIPITATION_ACCENT_COLOR,
			CLOUD_ACCENT_COLOR,
			STORM_ACCENT_COLOR,
			PRECIPITATION_ACCENT_COLOR,
			STORM_ACCENT_COLOR
		];

		private static const UNAVAILABLE_ICON:String = String.fromCharCode(0xe11a);

		private static const SUNNY_ICON:String = String.fromCharCode(0xe126);
		private static const CLEAR_NIGHT_ICON:String = String.fromCharCode(0xe121);
		private static const CLOUDY_ICON:String = String.fromCharCode(0xe11f);
		private static const PARTLY_CLOUDY_ICON:String = String.fromCharCode(0xe122);
		private static const HAZE_FOG_SMOKE_ICON:String = String.fromCharCode(0xe11e);
		private static const WINDY_ICON:String = String.fromCharCode(0xe128);
		private static const RAINY_ICON:String = String.fromCharCode(0xe120);
		private static const SHOWER_ICON:String = String.fromCharCode(0xe123);
		private static const STORM_ICON:String = String.fromCharCode(0xe125);
		private static const EXTREME_TEMP_ICON:String = String.fromCharCode(0xe101);
		private static const SNOW_ICON:String = String.fromCharCode(0xe124);

		private static const CONDITION_CODE_TO_ICON:Vector.<String> = new <String>
		[
			STORM_ICON,
			STORM_ICON,
			STORM_ICON,
			STORM_ICON,
			STORM_ICON,
			RAINY_ICON,
			RAINY_ICON,
			RAINY_ICON,
			SNOW_ICON,
			SHOWER_ICON,
			RAINY_ICON,
			SHOWER_ICON,
			SHOWER_ICON,
			SNOW_ICON,
			SNOW_ICON,
			SNOW_ICON,
			SNOW_ICON,
			STORM_ICON,
			SNOW_ICON,
			HAZE_FOG_SMOKE_ICON,
			HAZE_FOG_SMOKE_ICON,
			HAZE_FOG_SMOKE_ICON,
			HAZE_FOG_SMOKE_ICON,
			WINDY_ICON,
			WINDY_ICON,
			EXTREME_TEMP_ICON,
			CLOUDY_ICON,
			PARTLY_CLOUDY_ICON,
			PARTLY_CLOUDY_ICON,
			PARTLY_CLOUDY_ICON,
			PARTLY_CLOUDY_ICON,
			CLEAR_NIGHT_ICON,
			SUNNY_ICON,
			CLEAR_NIGHT_ICON,
			SUNNY_ICON,
			RAINY_ICON,
			EXTREME_TEMP_ICON,
			STORM_ICON,
			STORM_ICON,
			STORM_ICON,
			SHOWER_ICON,
			SNOW_ICON,
			SNOW_ICON,
			SNOW_ICON,
			PARTLY_CLOUDY_ICON,
			STORM_ICON,
			SNOW_ICON,
			STORM_ICON
		];

		public function FeathersWeatherTheme()
		{
			super();
			this.initialize();
		}

		private var _gridSize:Number = 48;
		private var _threeQuarterGridSize:Number = 36;
		private var _halfGridSize:Number = 24;
		private var _quarterGridSize:Number = 12;
		private var _eighthGridSize:Number = 6;
		private var _sixteenthGridSize:Number = 3;
		private var _oneAndAHalfGridSize:Number = 72;

		private var _tempuratureFontSize:Number = 50;
		private var _headerFontSize:Number = 18;
		private var _normalFontSize:Number = 15;
		private var _detailFontSize:Number = 12;

		private var defaultElementFormat:ElementFormat;
		private var headerElementFormat:ElementFormat;
		private var tempuratureElementFormat:ElementFormat;
		private var detailElementFormat:ElementFormat;
		private var textItalicFontDescription:FontDescription;
		private var largeIconElementFormat:ElementFormat;

		private var _iconsAtlas:TextureAtlas;

		private var deleteIconTexture:Texture;
		private var favoriteIconTexture:Texture;
		private var searchIconTexture:Texture;
		private var menuIconTexture:Texture;

		private function initialize():void
		{
			this.initializeFonts();
			this.initializeTextures();
			this.initializeGlobals();
			this.initializeStyleProviders();
		}

		private function initializeFonts():void
		{
			var textFontDescription:FontDescription = new FontDescription(TEXT_FONT_NAME, FontWeight.NORMAL, FontPosture.NORMAL, FontLookup.EMBEDDED_CFF, RenderingMode.CFF, CFFHinting.NONE);
			this.textItalicFontDescription = new FontDescription(TEXT_FONT_NAME, FontWeight.NORMAL, FontPosture.ITALIC, FontLookup.EMBEDDED_CFF, RenderingMode.CFF, CFFHinting.NONE);
			var iconFontDescription:FontDescription = new FontDescription(ICON_FONT_NAME, FontWeight.NORMAL, FontPosture.NORMAL, FontLookup.EMBEDDED_CFF, RenderingMode.CFF, CFFHinting.NONE);
			this.defaultElementFormat = new ElementFormat(textFontDescription, this._normalFontSize, 0xffffff);
			this.headerElementFormat = new ElementFormat(textFontDescription, this._headerFontSize, 0xffffff);
			this.detailElementFormat = new ElementFormat(this.textItalicFontDescription, this._detailFontSize, 0xe8e8e8);
			this.tempuratureElementFormat = new ElementFormat(textFontDescription, this._tempuratureFontSize, 0xffffff);
			this.largeIconElementFormat = new ElementFormat(iconFontDescription, this._tempuratureFontSize, 0xffffff, 1);
			this.largeIconElementFormat.trackingRight = this._sixteenthGridSize;
		}

		private function initializeTextures():void
		{
			var atlasTexture:Texture = Texture.fromEmbeddedAsset(ATLAS_IMAGE, false, false, 2);
			this._iconsAtlas = new TextureAtlas(atlasTexture, XML(new ATLAS_XML()));

			this.deleteIconTexture = this._iconsAtlas.getTexture("trash");
			this.favoriteIconTexture = this._iconsAtlas.getTexture("plus");
			this.searchIconTexture = this._iconsAtlas.getTexture("search");
			this.menuIconTexture = this._iconsAtlas.getTexture("menu");
		}

		private function initializeGlobals():void
		{
			FeathersControl.defaultTextRendererFactory = this.defaultTextRendererFactory;
			FeathersControl.defaultTextEditorFactory = this.textEditorFactory;
		}

		private function initializeStyleProviders():void
		{
			//panel
			this.getStyleProviderForClass(Header).setFunctionForStyleName(Panel.DEFAULT_CHILD_STYLE_NAME_HEADER, panelHeaderInitializer);

			//text input
			this.getStyleProviderForClass(TextInput).setFunctionForStyleName(TextInput.ALTERNATE_STYLE_NAME_SEARCH_TEXT_INPUT, searchInputInitializer);

			//label
			this.getStyleProviderForClass(Label).setFunctionForStyleName(Label.ALTERNATE_STYLE_NAME_DETAIL, detailLabelInitializer);

			//location view
			this.getStyleProviderForClass(LocationView).defaultStyleFunction = locationViewInitializer;
			this.getStyleProviderForClass(Header).setFunctionForStyleName(THEME_STYLE_NAME_LOCATION_VIEW_HEADER, locationViewHeaderInitializer);
			this.getStyleProviderForClass(List).setFunctionForStyleName(LocationView.CHILD_STYLE_NAME_LIST, locationViewListInitializer);
			this.getStyleProviderForClass(Label).setFunctionForStyleName(LocationView.CHILD_STYLE_NAME_STATUS_LABEL, locationViewStatusLabelInitializer);
			this.getStyleProviderForClass(FavoriteLocationItemRenderer).defaultStyleFunction = favoriteLocationItemRendererInitializer;
			this.getStyleProviderForClass(Button).setFunctionForStyleName(FavoriteLocationItemRenderer.CHILD_STYLE_NAME_DELETE_BUTTON, deleteButtonInitializer);
			this.getStyleProviderForClass(DefaultListItemRenderer).setFunctionForStyleName(THEME_STYLE_NAME_LOCATION_LIST_ITEM_RENDERER, searchResultLocationItemRendererInitializer);

			//forecast view
			this.getStyleProviderForClass(ForecastView).defaultStyleFunction = forecastViewInitializer;
			this.getStyleProviderForClass(Header).setFunctionForStyleName(ForecastView.CHILD_STYLE_NAME_HEADER, forecastViewHeaderInitializer);
			this.getStyleProviderForClass(List).setFunctionForStyleName(ForecastView.CHILD_STYLE_NAME_LIST, forecastViewListInitializer);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(ForecastView.CHILD_STYLE_NAME_LOCATION_BUTTON, forecastViewLocationButtonInitializer);
			this.getStyleProviderForClass(Label).setFunctionForStyleName(ForecastView.CHILD_STYLE_NAME_STATUS_LABEL, forecastViewStatusLabelInitializer);
			this.getStyleProviderForClass(ForecastItemRenderer).defaultStyleFunction = forecastItemRendererInitializer;
		}

		private function imageLoaderFactory():ImageLoader
		{
			var loader:ImageLoader = new ImageLoader();
			loader.pixelSnapping = true;
			return loader;
		}

		private function textEditorFactory():ITextEditor
		{
			var textEditor:StageTextTextEditor = new StageTextTextEditor();
			textEditor.fontFamily = "_sans";
			textEditor.color = 0xffffff;
			textEditor.fontSize = this._normalFontSize;
			return textEditor;
		}

		private function defaultTextRendererFactory():TextBlockTextRenderer
		{
			var textRenderer:TextBlockTextRenderer = new TextBlockTextRenderer();
			textRenderer.elementFormat = this.defaultElementFormat;
			return textRenderer;
		}

		private function wrappedTextRendererFactory():TextBlockTextRenderer
		{
			var textRenderer:TextBlockTextRenderer = new TextBlockTextRenderer();
			textRenderer.elementFormat = this.defaultElementFormat;
			textRenderer.leading = this._eighthGridSize;
			return textRenderer;
		}

		private function detailTextRendererFactory():TextBlockTextRenderer
		{
			var textRenderer:TextBlockTextRenderer = new TextBlockTextRenderer();
			textRenderer.elementFormat = this.detailElementFormat;
			return textRenderer;
		}

		private function headerTextRendererFactory():TextBlockTextRenderer
		{
			var textRenderer:TextBlockTextRenderer = new TextBlockTextRenderer();
			textRenderer.elementFormat = this.headerElementFormat;
			return textRenderer;
		}

		private function forecastHeaderTextRendererFactory():TextBlockTextRenderer
		{
			var textRenderer:TextBlockTextRenderer = new TextBlockTextRenderer();
			textRenderer.elementFormat = this.headerElementFormat;
			textRenderer.nativeFilters = [new DropShadowFilter(3, 45, 0, 1, 0, 0)];
			return textRenderer;
		}

		private function forecastDetailTextRendererFactory():TextBlockTextRenderer
		{
			return new TextBlockTextRenderer();
		}

		private function forecastTemperatureTextRendererFactory():TextBlockTextRenderer
		{
			var textRenderer:TextBlockTextRenderer = new TextBlockTextRenderer();
			textRenderer.elementFormat = this.tempuratureElementFormat;
			textRenderer.nativeFilters = [new DropShadowFilter(3, 45, 0, 1, 0, 0)];
			return textRenderer;
		}

		private function forecastDetailElementFormatFactory(color:uint):ElementFormat
		{
			return new ElementFormat(this.textItalicFontDescription, this._detailFontSize, color);
		}

		private function locationViewInitializer(view:LocationView):void
		{
			view.minWidth = this._gridSize;
			view.backgroundSkin = new Quad(10, 10, DRAWER_BACKGROUND_COLOR);
			view.layout = new AnchorLayout();
			view.customHeaderStyleName = THEME_STYLE_NAME_LOCATION_VIEW_HEADER;
		}

		private function locationViewHeaderInitializer(header:Header):void
		{
			header.padding = this._eighthGridSize;
		}

		private function locationViewListInitializer(list:List):void
		{
			var layoutData:AnchorLayoutData = new AnchorLayoutData();
			layoutData.top = 0;
			layoutData.right = 0;
			layoutData.bottom = 0;
			layoutData.left = 0;
			list.layoutData = layoutData;
			list.customItemRendererStyleName = THEME_STYLE_NAME_LOCATION_LIST_ITEM_RENDERER;
		}

		private function locationViewStatusLabelInitializer(label:Label):void
		{
			label.textRendererFactory = this.wrappedTextRendererFactory;
			var layoutData:AnchorLayoutData = new AnchorLayoutData();
			layoutData.top = this._quarterGridSize;
			layoutData.right = this._quarterGridSize;
			layoutData.left = this._quarterGridSize;
			layoutData.bottom = this._quarterGridSize;
			label.layoutData = layoutData;
		}

		private function searchInputInitializer(input:TextInput):void
		{
			var defaultIcon:ImageLoader = new ImageLoader();
			defaultIcon.pixelSnapping = true;
			defaultIcon.source = this.searchIconTexture;
			input.defaultIcon = defaultIcon;
			input.prompt = "Find New Location";
			input.backgroundSkin = new Quad(this._threeQuarterGridSize, this._threeQuarterGridSize, INSET_BACKGROUND_COLOR);
			input.backgroundSkin.alpha = 0.5;
			input.minWidth = this._gridSize * 4;
			input.minHeight = this._threeQuarterGridSize;
			input.padding = this._eighthGridSize;
			input.gap = this._eighthGridSize;
		}

		private function detailLabelInitializer(label:Label):void
		{
			label.textRendererFactory = this.detailTextRendererFactory;
		}

		private function forecastViewInitializer(view:ForecastView):void
		{
			view.layout = new AnchorLayout();
		}

		private function forecastViewHeaderInitializer(header:Header):void
		{
			header.padding = 0;
			header.paddingRight = this._eighthGridSize;
		}

		private function forecastViewLocationButtonInitializer(button:Button):void
		{
			var defaultSkin:ImageSkin = new ImageSkin();
			defaultSkin.defaultColor = BACKGROUND_COLOR;
			defaultSkin.setColorForState(ButtonState.DOWN, SELECTION_COLOR);
			defaultSkin.width = this._gridSize;
			defaultSkin.height = this._gridSize;
			defaultSkin.minWidth = this._halfGridSize;
			defaultSkin.minHeight = this._halfGridSize;
			button.defaultSkin = defaultSkin;

			button.paddingTop = this._eighthGridSize;
			button.paddingRight = this._eighthGridSize;
			button.gap = this._eighthGridSize;
			button.iconPosition = RelativePosition.LEFT;
			button.iconOffsetY = -2;

			var defaultIcon:ImageLoader = new ImageLoader();
			defaultIcon.source = this.menuIconTexture;
			defaultIcon.pixelSnapping = true;
			button.defaultIcon = defaultIcon;

			button.defaultLabelProperties.elementFormat = this.headerElementFormat;
		}

		private function forecastViewListInitializer(list:List):void
		{
			var layoutData:AnchorLayoutData = new AnchorLayoutData();
			layoutData.top = 0;
			layoutData.right = 0;
			layoutData.bottom = 0;
			layoutData.left = 0;
			list.layoutData = layoutData;

			var layout:TiledRowsLayout = new TiledRowsLayout();
			layout.gap = this._eighthGridSize;
			layout.padding = this._eighthGridSize;
			layout.useSquareTiles = true;
			layout.horizontalAlign = HorizontalAlign.CENTER;
			layout.verticalAlign = VerticalAlign.TOP;
			layout.tileHorizontalAlign = HorizontalAlign.JUSTIFY;
			layout.tileVerticalAlign = VerticalAlign.JUSTIFY;
			list.layout = layout;

			list.verticalScrollPolicy = ScrollPolicy.ON;
		}

		private function forecastViewStatusLabelInitializer(label:Label):void
		{
			label.textRendererFactory = this.wrappedTextRendererFactory;
			label.wordWrap = true;
			var layoutData:AnchorLayoutData = new AnchorLayoutData();
			layoutData.top = this._quarterGridSize;
			layoutData.right = this._quarterGridSize;
			layoutData.left = this._quarterGridSize;
			layoutData.bottom = this._quarterGridSize;
			label.layoutData = layoutData;
		}

		private function panelHeaderInitializer(header:Header):void
		{
			header.titleAlign = HorizontalAlign.LEFT;
			header.padding = this._quarterGridSize;
			header.titleFactory = headerTextRendererFactory;
		}

		private function favoriteLocationItemRendererInitializer(itemRenderer:DefaultListItemRenderer):void
		{
			itemRenderer.iconLabelFactory = this.detailTextRendererFactory;
			itemRenderer.iconPosition = RelativePosition.BOTTOM;
			itemRenderer.gap = this._eighthGridSize;

			itemRenderer.accessoryPosition = RelativePosition.RIGHT;
			itemRenderer.accessoryGap = Number.POSITIVE_INFINITY;

			itemRenderer.horizontalAlign = HorizontalAlign.LEFT;
			itemRenderer.paddingLeft = this._eighthGridSize;

			var defaultSkin:ImageSkin = new ImageSkin();
			defaultSkin.defaultColor = DRAWER_BACKGROUND_COLOR;
			defaultSkin.selectedColor = SELECTION_COLOR;
			defaultSkin.setColorForState(ButtonState.DOWN, SELECTION_COLOR)
			defaultSkin.width = this._gridSize;
			defaultSkin.height = this._gridSize;
			itemRenderer.defaultSkin = defaultSkin;
		}

		private function deleteButtonInitializer(button:Button):void
		{
			var defaultIcon:ImageLoader = new ImageLoader();
			defaultIcon.pixelSnapping = true;
			defaultIcon.source = this.deleteIconTexture;
			button.defaultIcon = defaultIcon;
			var defaultSkin:Quad = new Quad(this._gridSize, this._gridSize, DRAWER_BACKGROUND_COLOR);
			defaultSkin.alpha = 0;
			button.defaultSkin = defaultSkin;
			button.downSkin = new Quad(this._gridSize, this._gridSize, INSET_BACKGROUND_COLOR);
		}

		private function searchResultLocationItemRendererInitializer(itemRenderer:DefaultListItemRenderer):void
		{
			itemRenderer.accessoryLabelFactory = this.detailTextRendererFactory;
			itemRenderer.accessoryPosition = RelativePosition.BOTTOM;
			itemRenderer.accessoryGap = this._eighthGridSize;

			itemRenderer.iconPosition = RelativePosition.RIGHT;
			itemRenderer.gap = Number.POSITIVE_INFINITY;
			var defaultIcon:ImageLoader = new ImageLoader();
			defaultIcon.pixelSnapping = true;
			defaultIcon.source = this.favoriteIconTexture;
			itemRenderer.defaultIcon = defaultIcon;

			itemRenderer.horizontalAlign = HorizontalAlign.LEFT;
			itemRenderer.verticalAlign = VerticalAlign.MIDDLE;
			itemRenderer.layoutOrder = ItemRendererLayoutOrder.LABEL_ACCESSORY_ICON;
			itemRenderer.paddingLeft = this._eighthGridSize;
			itemRenderer.paddingRight = this._quarterGridSize;

			var defaultSkin:ImageSkin = new ImageSkin();
			defaultSkin.defaultColor = DRAWER_BACKGROUND_COLOR;
			defaultSkin.selectedColor = SELECTION_COLOR;
			defaultSkin.setColorForState(ButtonState.DOWN, SELECTION_COLOR)
			defaultSkin.width = this._gridSize;
			defaultSkin.height = this._gridSize;
			itemRenderer.defaultSkin = defaultSkin;
		}

		private function forecastItemRendererInitializer(itemRenderer:ForecastItemRenderer):void
		{
			itemRenderer.width = this._gridSize * 3;
			itemRenderer.height = this._gridSize * 3;
			itemRenderer.padding = this._eighthGridSize;
			itemRenderer.gap = this._sixteenthGridSize;

			itemRenderer.titleElementFormat = this.headerElementFormat;
			itemRenderer.iconElementFormat = this.largeIconElementFormat;
			itemRenderer.temperatureElementFormat = this.tempuratureElementFormat;
			itemRenderer.detailElementFormatFactory = this.forecastDetailElementFormatFactory;

			itemRenderer.conditionCodeToIcon = CONDITION_CODE_TO_ICON;
			itemRenderer.unavailableConditionCodeIcon = UNAVAILABLE_ICON;
			itemRenderer.conditionCodeToColor = CONDITION_CODE_TO_COLOR;
			itemRenderer.unavailableConditionCodeColor = DAY_COLOR;
			itemRenderer.conditionCodeToAccentColor = CONDITION_CODE_TO_ACCENT_COLOR;
			itemRenderer.unavailableConditionCodeAccentColor = DAY_ACCENT_COLOR;
		}

	}
}
