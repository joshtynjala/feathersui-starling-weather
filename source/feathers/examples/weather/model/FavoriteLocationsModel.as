package feathers.examples.weather.model
{
	import feathers.data.ListCollection;

	import org.robotlegs.starling.mvcs.Actor;

	public class FavoriteLocationsModel extends Actor
	{
		public function FavoriteLocationsModel()
		{
		}

		private var _favoriteLocations:ListCollection = new ListCollection();

		public function get favoriteLocations():ListCollection
		{
			return this._favoriteLocations;
		}

		public function addFavoriteLocation(location:LocationItem):void
		{
			this._favoriteLocations.addItem(location);
		}

		public function removeFavoriteLocation(location:LocationItem):void
		{
			this._favoriteLocations.removeItem(location);
		}

		public function hasLocation(location:LocationItem):Boolean
		{
			var woeid:String = location.woeid;
			var locationCount:int = this._favoriteLocations.length;
			for(var i:int = 0; i < locationCount; i++)
			{
				var otherLocation:LocationItem = LocationItem(this._favoriteLocations.getItemAt(i));
				if(otherLocation.woeid == woeid)
				{
					return true;
				}
			}
			return false;
		}

		public function replaceFavoriteLocations(locations:Vector.<LocationItem>):void
		{
			this._favoriteLocations.data = locations;
		}
	}
}
