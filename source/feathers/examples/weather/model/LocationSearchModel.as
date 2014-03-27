package feathers.examples.weather.model
{
	import feathers.data.ListCollection;

	import org.robotlegs.starling.mvcs.Actor;

	public class LocationSearchModel extends Actor
	{
		public function LocationSearchModel()
		{
		}

		[Inject]
		public var favoriteLocationsModel:FavoriteLocationsModel;

		private var _resultLocations:ListCollection = new ListCollection();

		public function get resultLocations():ListCollection
		{
			return this._resultLocations;
		}

		public function replaceResultLocations(locations:Vector.<LocationItem>):void
		{
			if(this._resultLocations.data == locations)
			{
				return;
			}
			var locationCount:int = locations.length;
			for(var i:int = locationCount - 1; i >= 0; i--)
			{
				var location:LocationItem = locations[i];
				if(this.favoriteLocationsModel.hasLocation(location))
				{
					locations.splice(i, 1);
				}
			}
			this._resultLocations.data = locations;
		}
	}
}
