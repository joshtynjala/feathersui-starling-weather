package feathers.examples.weather.view.components
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.Panel;
	import feathers.data.ListCollection;
	import feathers.examples.weather.model.LocationItem;
	import feathers.skins.IStyleProvider;
	import feathers.utils.touch.TapToTrigger;

	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	import starling.display.DisplayObject;
	import starling.events.Event;

	public class ForecastView extends Panel
	{
		public static var globalStyleProvider:IStyleProvider;

		public static const EVENT_OPEN_MENU:String = "openMenu";

		public static const CHILD_STYLE_NAME_LIST:String = "FeathersWeather-ForecastView-List";
		public static const CHILD_STYLE_NAME_HEADER:String = "FeathersWeather-ForecastView-Header";
		public static const CHILD_STYLE_NAME_LOCATION_BUTTON:String = "FeathersWeather-ForecastView-LocationButton";
		public static const CHILD_STYLE_NAME_STATUS_LABEL:String = "FeathersWeather-ForecastView-StatusLabel";

		private static const LOADING_TITLE:String = "Forecasts";
		private static const LOADING_MESSAGE:String = "Loading...";
		private static const NO_FORECASTS_MESSAGE:String = "No forecasts available at this time. Please try again later.";

		public function ForecastView()
		{
			super();
			this.headerFactory = customHeaderFactory;
			this.customHeaderStyleName = CHILD_STYLE_NAME_HEADER;
		}

		override protected function get defaultStyleProvider():IStyleProvider
		{
			return ForecastView.globalStyleProvider;
		}

		private var _locationButton:Button;
		private var _forecastList:List;
		private var _statusLabel:Label;
		private var _yahooLogo:ImageLoader;

		private var _location:LocationItem;

		public function get location():LocationItem
		{
			return this._location;
		}

		public function set location(value:LocationItem):void
		{
			if(this._location == value)
			{
				return;
			}
			this._location = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		private var _forecasts:ListCollection;

		public function get forecasts():ListCollection
		{
			return this._forecasts;
		}

		public function set forecasts(value:ListCollection):void
		{
			if(this._forecasts == value)
			{
				return;
			}
			this._forecasts = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		private var _forecastError:String;

		public function get forecastError():String
		{
			return this._forecastError;
		}

		public function set forecastError(value:String):void
		{
			if(this._forecastError == value)
			{
				return;
			}
			this._forecastError = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		override protected function initialize():void
		{
			super.initialize();

			this._forecastList = new List();
			this._forecastList.itemRendererType = ForecastItemRenderer;
			this._forecastList.styleNameList.add(CHILD_STYLE_NAME_LIST);
			this._forecastList.isSelectable = false;
			this.addChild(this._forecastList);

			this._statusLabel = new Label();
			this._statusLabel.styleNameList.add(CHILD_STYLE_NAME_STATUS_LABEL);
			this._statusLabel.visible = false;
			this.addChild(this._statusLabel);

			//this will be added as a child of the header later
			this._locationButton = new Button();
			this._locationButton.styleNameList.add(CHILD_STYLE_NAME_LOCATION_BUTTON);
			this._locationButton.addEventListener(Event.TRIGGERED, locationButton_triggeredHandler);

			//this will be added as a child of the header later
			this._yahooLogo = new ImageLoader();
			this._yahooLogo.source = "https://poweredby.yahoo.com/white_retina.png";
			this._yahooLogo.scaleFactor = 2;
			new TapToTrigger(this._yahooLogo);
			this._yahooLogo.addEventListener(Event.TRIGGERED, yahooLogo_triggeredHandler);
		}

		override protected function draw():void
		{
			var dataInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_DATA);
			if(dataInvalid)
			{
				if(this._forecastError)
				{
					this._forecastList.dataProvider = null;
					this._forecastList.visible = false;
					this._statusLabel.visible = true;
					this._statusLabel.text = this._forecastError;
				}
				else if(!this._forecasts)
				{
					this._forecastList.dataProvider = null;
					this._forecastList.visible = false;
					this._statusLabel.visible = true;
					this._statusLabel.text = LOADING_MESSAGE;
				}
				else if(this._forecasts.length == 0)
				{
					this._forecastList.dataProvider = null;
					this._forecastList.visible = false;
					this._statusLabel.visible = true;
					this._statusLabel.text = NO_FORECASTS_MESSAGE;
				}
				else
				{
					this._forecastList.dataProvider = this._forecasts;
					this._forecastList.visible = true;
					this._statusLabel.visible = false;
				}
			}
			if(this._location)
			{
				this._locationButton.label = this._location.name;
			}
			else
			{
				this._locationButton.label = LOADING_TITLE;
			}

			super.draw();
		}

		private function customHeaderFactory():Header
		{
			var header:Header = new Header();
			header.leftItems = new <DisplayObject>
			[
				this._locationButton
			];
			header.rightItems = new <DisplayObject>
			[
				this._yahooLogo
			];
			return header;
		}

		private function locationButton_triggeredHandler(event:Event):void
		{
			this.dispatchEventWith(EVENT_OPEN_MENU);
		}

		private function yahooLogo_triggeredHandler(event:Event):void
		{
			navigateToURL(new URLRequest("https://www.yahoo.com/?ilc=401"), "_blank");
		}

	}
}
