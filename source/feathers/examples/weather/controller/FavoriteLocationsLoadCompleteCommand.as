package feathers.examples.weather.controller
{
	import feathers.data.ListCollection;
	import feathers.examples.weather.model.FavoriteLocationsModel;
	import feathers.examples.weather.model.ForecastModel;
	import feathers.examples.weather.model.LocationItem;

	import org.robotlegs.starling.mvcs.Command;

	public class FavoriteLocationsLoadCompleteCommand extends Command
	{
		private static const DEFAULT_LOCATION_ITEM:LocationItem = new LocationItem("Sunnyvale", "2502265", "California, United States");

		[Inject]
		public var forecastModel:ForecastModel;

		[Inject]
		public var favoriteLocationsModel:FavoriteLocationsModel;

		override public function execute():void
		{
			var favoriteLocations:ListCollection = this.favoriteLocationsModel.favoriteLocations;
			if(favoriteLocations.length > 0)
			{
				var firstLocation:LocationItem = LocationItem(favoriteLocations.getItemAt(0));
				this.forecastModel.selectLocation(firstLocation);
			}
			else
			{
				//this will happen if the file was corrupt or doesn't exist yet
				this.favoriteLocationsModel.addFavoriteLocation(DEFAULT_LOCATION_ITEM);
				this.forecastModel.selectLocation(DEFAULT_LOCATION_ITEM);
			}
		}
	}
}
