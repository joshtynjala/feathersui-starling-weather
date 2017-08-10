package feathers.examples.weather
{
	import feathers.examples.weather.controller.FavoriteLocationsLoadCompleteCommand;
	import feathers.examples.weather.controller.StartupCommand;
	import feathers.examples.weather.events.FavoriteLocationsEventType;
	import feathers.examples.weather.model.FavoriteLocationsModel;
	import feathers.examples.weather.model.ForecastModel;
	import feathers.examples.weather.model.LocationSearchModel;
	import feathers.examples.weather.services.DebugFavoriteLocationsServiceWithResults;
	import feathers.examples.weather.services.DebugLocationSearchServiceWithResults;
	import feathers.examples.weather.services.DebugWeatherServiceValid;
	import feathers.examples.weather.services.IFavoriteLocationsService;
	import feathers.examples.weather.services.ILocationSearchService;
	import feathers.examples.weather.services.IWeatherService;
	import feathers.examples.weather.services.ProductionFavoriteLocationsService;
	import feathers.examples.weather.services.ProductionLocationSearchService;
	import feathers.examples.weather.services.ProductionWeatherService;
	import feathers.examples.weather.view.components.ForecastView;
	import feathers.examples.weather.view.components.LocationView;
	import feathers.examples.weather.view.mediators.ForecastViewMediator;
	import feathers.examples.weather.view.mediators.LocationViewMediator;
	import feathers.examples.weather.view.mediators.MainMediator;

	import org.robotlegs.starling.base.ContextEventType;
	import org.robotlegs.starling.core.IInjector;
	import org.robotlegs.starling.mvcs.Context;

	import starling.display.DisplayObjectContainer;

	public class FeathersWeatherContext extends Context
	{
		public function FeathersWeatherContext(contextView:DisplayObjectContainer)
		{
			super(contextView);
		}
		
		override protected function get injector():IInjector
		{
			return super.injector;
		}
		
		override protected function set injector(value:IInjector):void
		{
			super.injector = value;
		}

		override public function startup():void
		{
			this.commandMap.mapEvent(ContextEventType.STARTUP, StartupCommand);
			this.commandMap.mapEvent(FavoriteLocationsEventType.FAVORITE_LOCATIONS_LOAD_COMPLETE, FavoriteLocationsLoadCompleteCommand);
			this.commandMap.mapEvent(FavoriteLocationsEventType.FAVORITE_LOCATIONS_LOAD_ERROR, FavoriteLocationsLoadCompleteCommand);

			this.injector.mapSingleton(FavoriteLocationsModel);
			this.injector.mapSingleton(ForecastModel);
			this.injector.mapSingleton(LocationSearchModel);
			if(CONFIG::API_KEY == "mock")
			{
				this.injector.mapSingletonOf(IWeatherService, DebugWeatherServiceValid);
				this.injector.mapSingletonOf(ILocationSearchService, DebugLocationSearchServiceWithResults);
				this.injector.mapSingletonOf(IFavoriteLocationsService, DebugFavoriteLocationsServiceWithResults);
			}
			else //production
			{
				this.injector.mapSingletonOf(IWeatherService, ProductionWeatherService);
				this.injector.mapSingletonOf(ILocationSearchService, ProductionLocationSearchService);
				this.injector.mapSingletonOf(IFavoriteLocationsService, ProductionFavoriteLocationsService);
			}

			this.mediatorMap.mapView(ForecastView, ForecastViewMediator);
			this.mediatorMap.mapView(LocationView, LocationViewMediator);
			this.mediatorMap.mapView(Main, MainMediator);

			this.dispatchEventWith(ContextEventType.STARTUP);

			super.startup();
		}
	}
}
