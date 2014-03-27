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
	import feathers.core.DisplayListWatcher;
	import feathers.core.FeathersControl;
	import feathers.core.ITextEditor;
	import feathers.examples.weather.view.components.FavoriteLocationItemRenderer;
	import feathers.examples.weather.view.components.ForecastItemRenderer;
	import feathers.examples.weather.view.components.ForecastView;
	import feathers.examples.weather.view.components.LocationView;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.TiledRowsLayout;
	import feathers.skins.SmartDisplayObjectStateValueSelector;
	import feathers.system.DeviceCapabilities;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
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

	public class FeathersWeatherTheme extends DisplayListWatcher
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

		private static const THEME_NAME_LOCATION_VIEW_HEADER:String = "FeathersWeatherTheme-LocationView-Header";
		private static const THEME_NAME_LOCATION_LIST_ITEM_RENDERER:String = "FeathersWeatherTheme-LocationList-ItemRenderer";

		private static const TEXT_FONT_NAME:String = "MuseoSans";
		private static const ICON_FONT_NAME:String = "Typicons";

		private static const ORIGINAL_DPI_IPHONE_RETINA:int = 326;
		private static const ORIGINAL_DPI_IPAD_RETINA:int = 264;

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
			super(Starling.current.stage);
			this.initialize();
		}

		private var _originalDPI:int;
		private var _scale:Number;

		private var _gridSize:Number;
		private var _threeQuarterGridSize:Number;
		private var _halfGridSize:Number;
		private var _quarterGridSize:Number;
		private var _eighthGridSize:Number;
		private var _sixteenthGridSize:Number;
		private var _oneAndAHalfGridSize:Number;

		private var _tempuratureFontSize:Number;
		private var _headerFontSize:Number;
		private var _normalFontSize:Number;
		private var _detailFontSize:Number;

		private var defaultElementFormat:ElementFormat;
		private var headerElementFormat:ElementFormat;
		private var tempuratureElementFormat:ElementFormat;
		private var detailElementFormat:ElementFormat;
		private var textItalicFontDescription:FontDescription;
		private var largeIconElementFormat:ElementFormat;

		private var itemRendererSkinSelector:SmartDisplayObjectStateValueSelector;
		private var quietButtonSkinSelector:SmartDisplayObjectStateValueSelector;

		private var _iconsAtlas:TextureAtlas;

		private var deleteIconTexture:Texture;
		private var favoriteIconTexture:Texture;
		private var searchIconTexture:Texture;
		private var menuIconTexture:Texture;

		private function initialize():void
		{
			this.initializeScale();
			this.initializeFonts();
			this.initializeTextures();
			this.initializeSkinSelectors();
			this.initializeGlobals();
			this.setInitializers();
		}

		private function initializeScale():void
		{
			var scaledDPI:int = DeviceCapabilities.dpi / Starling.contentScaleFactor;
			if(DeviceCapabilities.isTablet(Starling.current.nativeStage))
			{
				this._originalDPI = ORIGINAL_DPI_IPAD_RETINA;
			}
			else
			{
				this._originalDPI = ORIGINAL_DPI_IPHONE_RETINA;
			}
			this._scale = scaledDPI / this._originalDPI;

			this._gridSize = 96 * this._scale;
			this._threeQuarterGridSize = 72 * this._scale;
			this._halfGridSize = 48 * this._scale;
			this._quarterGridSize = 24 * this._scale;
			this._eighthGridSize = 12 * this._scale;
			this._sixteenthGridSize = 6 * this._scale;
			this._oneAndAHalfGridSize = 144 * this._scale;
		}

		private function initializeFonts():void
		{
			this._normalFontSize = 30 * this._scale;
			this._headerFontSize = 36 * this._scale;
			this._detailFontSize = 24 * this._scale;
			this._tempuratureFontSize = 100 * this._scale;
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
			var bitmap:Bitmap = Bitmap(new ATLAS_IMAGE());
			var bitmapData:BitmapData = bitmap.bitmapData;
			var atlasTexture:Texture = Texture.fromBitmapData(bitmapData, false);
			bitmapData.dispose();
			atlasTexture.root.onRestore = atlas_onRestore;
			this._iconsAtlas = new TextureAtlas(atlasTexture, XML(new ATLAS_XML()));

			this.deleteIconTexture = this._iconsAtlas.getTexture("trash");
			this.favoriteIconTexture = this._iconsAtlas.getTexture("plus");
			this.searchIconTexture = this._iconsAtlas.getTexture("search");
			this.menuIconTexture = this._iconsAtlas.getTexture("menu");
		}

		private function initializeSkinSelectors():void
		{
			this.itemRendererSkinSelector = new SmartDisplayObjectStateValueSelector();
			this.itemRendererSkinSelector.defaultValue = DRAWER_BACKGROUND_COLOR;
			this.itemRendererSkinSelector.defaultSelectedValue = SELECTION_COLOR;
			this.itemRendererSkinSelector.setValueForState(SELECTION_COLOR, Button.STATE_DOWN, false);
			this.itemRendererSkinSelector.displayObjectProperties =
			{
				width: this._gridSize,
				height: this._gridSize
			};

			this.quietButtonSkinSelector = new SmartDisplayObjectStateValueSelector();
			this.quietButtonSkinSelector.defaultValue = BACKGROUND_COLOR;
			this.quietButtonSkinSelector.setValueForState(SELECTION_COLOR, Button.STATE_DOWN, false);
			this.quietButtonSkinSelector.displayObjectProperties =
			{
				width: this._gridSize,
				height: this._gridSize
			};
		}

		private function initializeGlobals():void
		{
			FeathersControl.defaultTextRendererFactory = this.defaultTextRendererFactory;
			FeathersControl.defaultTextEditorFactory = this.textEditorFactory;
		}

		private function setInitializers():void
		{
			//panel
			this.setInitializerForClass(Header, panelHeaderInitializer, Panel.DEFAULT_CHILD_NAME_HEADER);

			//text input
			this.setInitializerForClass(TextInput, searchInputInitializer, TextInput.ALTERNATE_NAME_SEARCH_TEXT_INPUT);

			//label
			this.setInitializerForClass(Label, detailLabelInitializer, Label.ALTERNATE_NAME_DETAIL);

			//location view
			this.setInitializerForClass(LocationView, locationViewInitializer);
			this.setInitializerForClass(Header, locationViewHeaderInitializer, THEME_NAME_LOCATION_VIEW_HEADER);
			this.setInitializerForClass(List, locationViewListInitializer, LocationView.CHILD_NAME_LIST);
			this.setInitializerForClass(Label, locationViewStatusLabelInitializer, LocationView.CHILD_NAME_STATUS_LABEL);
			this.setInitializerForClass(FavoriteLocationItemRenderer, favoriteLocationItemRendererInitializer);
			this.setInitializerForClass(Button, deleteButtonInitializer, FavoriteLocationItemRenderer.CHILD_NAME_DELETE_BUTTON);
			this.setInitializerForClass(DefaultListItemRenderer, searchResultLocationItemRendererInitializer, THEME_NAME_LOCATION_LIST_ITEM_RENDERER);

			//forecast view
			this.setInitializerForClass(ForecastView, forecastViewInitializer);
			this.setInitializerForClass(Header, forecastViewHeaderInitializer, ForecastView.CHILD_NAME_HEADER);
			this.setInitializerForClass(List, forecastViewListInitializer, ForecastView.CHILD_NAME_LIST);
			this.setInitializerForClass(Button, forecastViewLocationButtonInitializer, ForecastView.CHILD_NAME_LOCATION_BUTTON);
			this.setInitializerForClass(Label, forecastViewStatusLabelInitializer, ForecastView.CHILD_NAME_STATUS_LABEL);
			this.setInitializerForClass(ForecastItemRenderer, forecastItemRendererInitializer);
		}

		private function atlas_onRestore():void
		{
			var bitmap:Bitmap = Bitmap(new ATLAS_IMAGE());
			var bitmapData:BitmapData = bitmap.bitmapData;
			this._iconsAtlas.texture.root.uploadBitmapData(bitmapData);
			bitmapData.dispose();
		}

		private function imageLoaderFactory():ImageLoader
		{
			var loader:ImageLoader = new ImageLoader();
			loader.snapToPixels = true;
			loader.textureScale = this._scale;
			return loader;
		}

		private function textEditorFactory():ITextEditor
		{
			var renderer:StageTextTextEditor = new StageTextTextEditor();
			renderer.fontFamily = "_sans";
			renderer.color = 0xffffff;
			renderer.fontSize = this._normalFontSize;
			return renderer;
		}

		private function defaultTextRendererFactory():TextBlockTextRenderer
		{
			var renderer:TextBlockTextRenderer = new TextBlockTextRenderer();
			renderer.elementFormat = this.defaultElementFormat;
			return renderer;
		}

		private function wrappedTextRendererFactory():TextBlockTextRenderer
		{
			var renderer:TextBlockTextRenderer = new TextBlockTextRenderer();
			renderer.elementFormat = this.defaultElementFormat;
			renderer.wordWrap = true;
			renderer.leading = this._eighthGridSize;
			return renderer;
		}

		private function detailTextRendererFactory():TextBlockTextRenderer
		{
			var renderer:TextBlockTextRenderer = new TextBlockTextRenderer();
			renderer.elementFormat = this.detailElementFormat;
			return renderer;
		}

		private function headerTextRendererFactory():TextBlockTextRenderer
		{
			var renderer:TextBlockTextRenderer = new TextBlockTextRenderer();
			renderer.elementFormat = this.headerElementFormat;
			return renderer;
		}

		private function forecastHeaderTextRendererFactory():TextBlockTextRenderer
		{
			var renderer:TextBlockTextRenderer = new TextBlockTextRenderer();
			renderer.elementFormat = this.headerElementFormat;
			renderer.nativeFilters = [new DropShadowFilter(3 * this._scale, 45, 0, 1, 0, 0)];
			return renderer;
		}

		private function forecastDetailTextRendererFactory():TextBlockTextRenderer
		{
			return new TextBlockTextRenderer();
		}

		private function forecastTemperatureTextRendererFactory():TextBlockTextRenderer
		{
			var renderer:TextBlockTextRenderer = new TextBlockTextRenderer();
			renderer.elementFormat = this.tempuratureElementFormat;
			renderer.nativeFilters = [new DropShadowFilter(3 * this._scale, 45, 0, 1, 0, 0)];
			return renderer;
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
			view.customHeaderName = THEME_NAME_LOCATION_VIEW_HEADER;
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
			list.itemRendererName = THEME_NAME_LOCATION_LIST_ITEM_RENDERER;
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
			defaultIcon.snapToPixels = true;
			defaultIcon.source = this.searchIconTexture;
			defaultIcon.textureScale = this._scale;
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
			button.stateToSkinFunction = this.quietButtonSkinSelector.updateValue;
			button.minWidth = this._halfGridSize;
			button.minHeight = this._halfGridSize;
			button.paddingTop = this._eighthGridSize;
			button.paddingRight = this._eighthGridSize;
			button.gap = this._eighthGridSize;
			button.iconPosition = Button.ICON_POSITION_LEFT;
			button.iconOffsetY = -4 * this._scale;
			var defaultIcon:ImageLoader = new ImageLoader();
			defaultIcon.source = this.menuIconTexture;
			defaultIcon.snapToPixels = true;
			defaultIcon.textureScale = this._scale;
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
			layout.horizontalAlign = TiledRowsLayout.HORIZONTAL_ALIGN_CENTER;
			layout.verticalAlign = TiledRowsLayout.VERTICAL_ALIGN_TOP;
			layout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_JUSTIFY;
			layout.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_JUSTIFY;
			list.layout = layout;

			list.verticalScrollPolicy = List.SCROLL_POLICY_ON;
		}

		private function forecastViewStatusLabelInitializer(label:Label):void
		{
			label.textRendererFactory = this.wrappedTextRendererFactory;
			var layoutData:AnchorLayoutData = new AnchorLayoutData();
			layoutData.top = this._quarterGridSize;
			layoutData.right = this._quarterGridSize;
			layoutData.left = this._quarterGridSize;
			layoutData.bottom = this._quarterGridSize;
			label.layoutData = layoutData;
		}

		private function panelHeaderInitializer(header:Header):void
		{
			header.titleAlign = Header.TITLE_ALIGN_PREFER_LEFT;
			header.padding = this._quarterGridSize;
			header.titleFactory = headerTextRendererFactory;
		}

		private function favoriteLocationItemRendererInitializer(renderer:DefaultListItemRenderer):void
		{
			renderer.iconLabelFactory = this.detailTextRendererFactory;
			renderer.iconPosition = DefaultListItemRenderer.ICON_POSITION_BOTTOM;
			renderer.gap = this._eighthGridSize;

			renderer.accessoryPosition = DefaultListItemRenderer.ACCESSORY_POSITION_RIGHT;
			renderer.accessoryGap = Number.POSITIVE_INFINITY;

			renderer.horizontalAlign = DefaultListItemRenderer.HORIZONTAL_ALIGN_LEFT;
			renderer.paddingLeft = this._eighthGridSize;

			renderer.stateToSkinFunction = this.itemRendererSkinSelector.updateValue;
		}

		private function deleteButtonInitializer(button:Button):void
		{
			var defaultIcon:ImageLoader = new ImageLoader();
			defaultIcon.snapToPixels = true;
			defaultIcon.source = this.deleteIconTexture;
			defaultIcon.textureScale = this._scale;
			button.defaultIcon = defaultIcon;
			var defaultSkin:Quad = new Quad(this._gridSize, this._gridSize, DRAWER_BACKGROUND_COLOR);
			defaultSkin.alpha = 0;
			button.defaultSkin = defaultSkin;
			button.downSkin = new Quad(this._gridSize, this._gridSize, INSET_BACKGROUND_COLOR);
		}

		private function searchResultLocationItemRendererInitializer(renderer:DefaultListItemRenderer):void
		{
			renderer.accessoryLabelFactory = this.detailTextRendererFactory;
			renderer.accessoryPosition = DefaultListItemRenderer.ACCESSORY_POSITION_BOTTOM;
			renderer.accessoryGap = this._eighthGridSize;

			renderer.iconPosition = DefaultListItemRenderer.ICON_POSITION_RIGHT;
			renderer.gap = Number.POSITIVE_INFINITY;
			var defaultIcon:ImageLoader = new ImageLoader();
			defaultIcon.snapToPixels = true;
			defaultIcon.source = this.favoriteIconTexture;
			defaultIcon.textureScale = this._scale;
			renderer.defaultIcon = defaultIcon;

			renderer.horizontalAlign = DefaultListItemRenderer.HORIZONTAL_ALIGN_LEFT;
			renderer.verticalAlign = DefaultListItemRenderer.VERTICAL_ALIGN_MIDDLE;
			renderer.layoutOrder = DefaultListItemRenderer.LAYOUT_ORDER_LABEL_ACCESSORY_ICON;
			renderer.paddingLeft = this._eighthGridSize;
			renderer.paddingRight = this._quarterGridSize;

			renderer.stateToSkinFunction = this.itemRendererSkinSelector.updateValue;
		}

		private function forecastItemRendererInitializer(renderer:ForecastItemRenderer):void
		{
			renderer.width = this._gridSize * 3;
			renderer.height = this._gridSize * 3;
			renderer.padding = this._eighthGridSize;
			renderer.gap = this._sixteenthGridSize;

			renderer.titleElementFormat = this.headerElementFormat;
			renderer.iconElementFormat = this.largeIconElementFormat;
			renderer.temperatureElementFormat = this.tempuratureElementFormat;
			renderer.detailElementFormatFactory = this.forecastDetailElementFormatFactory;

			renderer.conditionCodeToIcon = CONDITION_CODE_TO_ICON;
			renderer.unavailableConditionCodeIcon = UNAVAILABLE_ICON;
			renderer.conditionCodeToColor = CONDITION_CODE_TO_COLOR;
			renderer.unavailableConditionCodeColor = DAY_COLOR;
			renderer.conditionCodeToAccentColor = CONDITION_CODE_TO_ACCENT_COLOR;
			renderer.unavailableConditionCodeAccentColor = DAY_ACCENT_COLOR;
		}

	}
}
