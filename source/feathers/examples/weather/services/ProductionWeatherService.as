package feathers.examples.weather.services
{
	import feathers.examples.weather.events.ForecastEventType;
	import feathers.examples.weather.model.ForecastItem;
	import feathers.examples.weather.model.ForecastModel;

	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;

	import org.robotlegs.starling.mvcs.Actor;

	public class ProductionWeatherService extends Actor implements IWeatherService
	{
		private static const BASE_URL:String = "http://weather.yahooapis.com/forecastrss?w=";

		private var _loader:URLLoader;

		[Inject]
		public var forecastModel:ForecastModel;

		public function loadForecastForLocation(woeid:String):void
		{
			if(this._loader)
			{
				this._loader.removeEventListener(Event.COMPLETE, loader_completeHandler);
				this._loader.removeEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
				this._loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_errorHandler);
				this._loader.close();
			}
			this._loader = new URLLoader();
			this._loader.dataFormat = URLLoaderDataFormat.TEXT;
			this._loader.addEventListener(Event.COMPLETE, loader_completeHandler);
			this._loader.addEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
			this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_errorHandler);
			this._loader.load(new URLRequest(BASE_URL + encodeURIComponent(woeid)));
		}

		private function loader_completeHandler(event:Event):void
		{
			var resultText:String = this._loader.data as String;
			this._loader.removeEventListener(Event.COMPLETE, loader_completeHandler);
			this._loader.removeEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
			this._loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_errorHandler);
			this._loader = null;
			try
			{
				var xml:XML = new XML(resultText);
				var forecasts:Vector.<ForecastItem> = ForecastItem.fromYahooWeatherRSS(xml);
				this.forecastModel.replaceForecasts(forecasts);
				this.dispatchWith(ForecastEventType.FORECAST_COMPLETE);
			}
			catch(error:Error)
			{
				trace(error);
				this.dispatchWith(ForecastEventType.FORECAST_ERROR, false, error);
			}
		}

		private function loader_errorHandler(event:ErrorEvent):void
		{
			this._loader.removeEventListener(Event.COMPLETE, loader_completeHandler);
			this._loader.removeEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
			this._loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_errorHandler);
			this._loader = null;
			var error:Error = new Error(event.text, event.errorID);
			trace(error);
			this.dispatchWith(ForecastEventType.FORECAST_ERROR, false, error);
		}
	}
}
