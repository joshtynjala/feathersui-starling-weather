package feathers.examples.weather.services
{
	import feathers.examples.weather.events.ForecastEventType;
	import feathers.examples.weather.model.ForecastModel;

	import org.robotlegs.starling.mvcs.Actor;

	import starling.core.Starling;

	/**
	 * This class is used for testing purposes. It uses mock data to avoid
	 * calling the real service.
	 *
	 * @see ProductionWeatherService
	 */
	public class DebugWeatherServiceError extends Actor implements IWeatherService
	{
		[Inject]
		public var forecastModel:ForecastModel;

		public function loadForecastForLocation(woeid:String):void
		{
			Starling.current.juggler.delayCall(forecastLoaded, 0.5);
		}

		private function forecastLoaded():void
		{
			this.dispatchWith(ForecastEventType.FORECAST_ERROR, false, new Error("This is a mock error used for testing."));
		}
	}
}
