package feathers.examples.weather.view.mediators
{
	import feathers.examples.weather.events.ForecastEventType;
	import feathers.examples.weather.model.ForecastModel;
	import feathers.examples.weather.model.LocationItem;
	import feathers.examples.weather.services.IWeatherService;
	import feathers.examples.weather.view.components.ForecastView;

	import org.robotlegs.starling.mvcs.Mediator;

	import starling.events.Event;

	public class ForecastViewMediator extends Mediator
	{
		[Inject]
		public var forecastModel:ForecastModel;

		[Inject]
		public var weatherService:IWeatherService;

		[Inject]
		public var forecastView:ForecastView;

		override public function onRegister():void
		{
			this.updateLocation();

			this.addContextListener(ForecastEventType.SELECTED_LOCATION_CHANGE, context_selectedLocationChangeHandler);
			this.addContextListener(ForecastEventType.FORECAST_COMPLETE, context_forecastCompleteHandler);
			this.addContextListener(ForecastEventType.FORECAST_ERROR, context_forecastErrorHandler);
		}

		private function updateLocation():void
		{
			var selectedLocation:LocationItem = this.forecastModel.selectedLocation;
			this.forecastView.location = selectedLocation;
			this.forecastView.forecasts = null;
			if(!selectedLocation)
			{
				return;
			}
			this.weatherService.loadForecastForLocation(selectedLocation.woeid);
		}

		private function context_selectedLocationChangeHandler(event:Event):void
		{
			this.updateLocation();
		}

		private function context_forecastCompleteHandler(event:Event):void
		{
			this.forecastView.forecasts = this.forecastModel.forecasts;
		}

		private function context_forecastErrorHandler(event:Event, error:Error):void
		{
			this.forecastView.forecastError = "Forecast failed to load. Please try again later.";
		}
	}
}
