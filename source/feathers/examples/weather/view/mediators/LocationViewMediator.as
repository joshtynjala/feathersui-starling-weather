package feathers.examples.weather.view.mediators
{
	import feathers.examples.weather.events.LocationSearchEventType;
	import feathers.examples.weather.model.FavoriteLocationsModel;
	import feathers.examples.weather.model.ForecastModel;
	import feathers.examples.weather.model.LocationItem;
	import feathers.examples.weather.model.LocationSearchModel;
	import feathers.examples.weather.services.IFavoriteLocationsService;
	import feathers.examples.weather.services.ILocationSearchService;
	import feathers.examples.weather.view.components.LocationView;

	import org.robotlegs.starling.mvcs.Mediator;

	import starling.events.Event;

	public class LocationViewMediator extends Mediator
	{
		[Inject]
		public var favoriteLocationsModel:FavoriteLocationsModel;

		[Inject]
		public var locationSearchModel:LocationSearchModel;

		[Inject]
		public var forecastModel:ForecastModel;

		[Inject]
		public var locationSearchService:ILocationSearchService;

		[Inject]
		public var favoriteLocationsService:IFavoriteLocationsService;

		[Inject]
		public var locationView:LocationView;

		override public function onRegister():void
		{
			this.locationView.favoriteLocations = this.favoriteLocationsModel.favoriteLocations;
			this.locationView.searchResultLocations = null;
			this.locationView.selectedFavoriteLocation = this.forecastModel.selectedLocation;

			this.addViewListener(Event.CHANGE, view_changeHandler);
			this.addViewListener(LocationView.EVENT_SEARCH, view_searchHandler);
			this.addViewListener(LocationView.EVENT_DELETE_FAVORITE_LOCATION, view_deleteFavoriteLocationHandler);
			this.addViewListener(LocationView.EVENT_SAVE_FAVORITE_LOCATION, view_saveFavoriteLocationHandler);
			this.addContextListener(LocationSearchEventType.LOCATION_SEARCH_COMPLETE, context_locationSearchCompleteHandler);
			this.addContextListener(LocationSearchEventType.LOCATION_SEARCH_ERROR, context_locationSearchErrorHandler);
		}

		private function view_changeHandler(event:Event):void
		{
			this.forecastModel.selectLocation(this.locationView.selectedFavoriteLocation);
		}

		private function view_searchHandler(event:Event):void
		{
			this.locationView.searchError = null;
			if(this.locationSearchService.isSearching)
			{
				this.locationSearchService.cancelSearch();
			}
			if(this.locationView.searchQuery)
			{
				this.locationSearchService.search(this.locationView.searchQuery);
			}
		}

		private function view_deleteFavoriteLocationHandler(event:Event, location:LocationItem):void
		{
			this.favoriteLocationsModel.removeFavoriteLocation(location);
			this.favoriteLocationsService.saveFavoriteLocations();
		}

		private function view_saveFavoriteLocationHandler(event:Event, location:LocationItem):void
		{
			this.favoriteLocationsModel.addFavoriteLocation(location);
			this.locationView.searchQuery = null;
			this.locationView.searchResultLocations = null;
			this.locationView.selectedFavoriteLocation = location;
			this.favoriteLocationsService.saveFavoriteLocations();
		}

		private function context_locationSearchCompleteHandler(event:Event):void
		{
			this.locationView.searchResultLocations = this.locationSearchModel.resultLocations;
		}

		private function context_locationSearchErrorHandler(event:Event, error:Error):void
		{
			this.locationView.searchError = "Search failed. Please try again later.";
		}
	}
}
