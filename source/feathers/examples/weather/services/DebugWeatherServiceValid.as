package feathers.examples.weather.services
{
	import feathers.examples.weather.events.ForecastEventType;
	import feathers.examples.weather.model.ForecastItem;
	import feathers.examples.weather.model.ForecastModel;

	import org.robotlegs.starling.mvcs.Actor;

	import starling.core.Starling;

	/**
	 * This class is used for testing purposes. It uses mock data to avoid
	 * calling the real service.
	 *
	 * @see ProductionWeatherService
	 */
	public class DebugWeatherServiceValid extends Actor implements IWeatherService
	{
		[Embed(source="sample-weather-result.xml",mimeType="application/octet-stream")]
		private static const WEATHER_XML:Class;

		[Inject]
		public var forecastModel:ForecastModel;

		public function loadForecastForLocation(woeid:String):void
		{
			Starling.current.juggler.delayCall(forecastLoaded, 0.5);
		}

		private function forecastLoaded():void
		{
			var xml:XML = XML(new WEATHER_XML());
			try
			{
				var forecasts:Vector.<ForecastItem> = ForecastItem.fromYahooWeatherYQLXML(xml);
				this.forecastModel.replaceForecasts(forecasts);
				this.dispatchWith(ForecastEventType.FORECAST_COMPLETE);
			}
			catch(error:Error)
			{
				trace(error);
				this.dispatchWith(ForecastEventType.FORECAST_ERROR, false, error);
			}
		}
	}
}
