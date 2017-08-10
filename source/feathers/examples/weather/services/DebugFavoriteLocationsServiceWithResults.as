package feathers.examples.weather.services
{
	import feathers.examples.weather.events.FavoriteLocationsEventType;
	import feathers.examples.weather.model.FavoriteLocationsModel;
	import feathers.examples.weather.model.LocationItem;

	import flash.errors.IllegalOperationError;

	import org.robotlegs.starling.mvcs.Actor;

	import starling.core.Starling;

	/**
	 * This class is used for testing purposes. It uses mock data to avoid
	 * calling the real service.
	 *
	 * @see ProductionFavoriteLocationsService
	 */
	public class DebugFavoriteLocationsServiceWithResults extends Actor implements IFavoriteLocationsService
	{
		[Embed(source="favorite-locations.json",mimeType="application/octet-stream")]
		private static const FAVORITE_LOCATIONS_JSON:Class;

		public function DebugFavoriteLocationsServiceWithResults()
		{
		}

		[Inject]
		public var favoriteLocationsModel:FavoriteLocationsModel;

		private var _isLoading:Boolean = false;

		public function get isLoading():Boolean
		{
			return this._isLoading;
		}

		private var _isSaving:Boolean = false;

		public function get isSaving():Boolean
		{
			return this._isSaving;
		}

		public function get isActive():Boolean
		{
			return this.isLoading || this.isSaving;
		}

		public function loadFavoriteLocations():void
		{
			if(this.isLoading)
			{
				throw new IllegalOperationError("Cannot load when the service is already loading.");
			}
			if(this.isSaving)
			{
				throw new IllegalOperationError("Cannot load when the service is saving.");
			}
			Starling.juggler.delayCall(locationsLoaded, 0.5);
		}

		public function saveFavoriteLocations():void
		{
			if(this.isLoading)
			{
				throw new IllegalOperationError("Cannot load when the service is already loading.");
			}
			if(this.isSaving)
			{
				throw new IllegalOperationError("Cannot load when the service is saving.");
			}
			Starling.juggler.delayCall(locationsSaved, 0.5);
		}

		private function locationsLoaded():void
		{
			try
			{
				var result:Object = JSON.parse(new FAVORITE_LOCATIONS_JSON());
				var locations:Vector.<LocationItem> = LocationItem.fromFavoriteLocationsJSON(result);
				this.favoriteLocationsModel.replaceFavoriteLocations(locations);
				this.dispatchWith(FavoriteLocationsEventType.FAVORITE_LOCATIONS_LOAD_COMPLETE);
			}
			catch(error:Error)
			{
				this.dispatchWith(FavoriteLocationsEventType.FAVORITE_LOCATIONS_LOAD_ERROR);
			}
		}

		private function locationsSaved():void
		{
			this.dispatchWith(FavoriteLocationsEventType.FAVORITE_LOCATIONS_SAVE_COMPLETE);
		}
	}
}
