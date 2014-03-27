package feathers.examples.weather.services
{
	import feathers.examples.weather.events.FavoriteLocationsEventType;
	import feathers.examples.weather.model.FavoriteLocationsModel;
	import feathers.examples.weather.model.LocationItem;

	import flash.errors.IllegalOperationError;

	import org.robotlegs.starling.mvcs.Actor;

	import starling.animation.DelayedCall;
	import starling.core.Starling;

	/**
	 * This class is used for testing purposes. It uses mock data to avoid
	 * calling the real service.
	 *
	 * @see ProductionFavoriteLocationsService
	 */
	public class DebugFavoriteLocationsServiceNoResults extends Actor implements IFavoriteLocationsService
	{
		public function DebugFavoriteLocationsServiceNoResults()
		{
		}

		[Inject]
		public var favoriteLocationsModel:FavoriteLocationsModel;

		private var _savedDelayedCall:DelayedCall;

		private var _isActive:Boolean = false;

		public function get isActive():Boolean
		{
			return this._isActive;
		}

		public function loadFavoriteLocations():void
		{
			if(this._isActive)
			{
				throw new IllegalOperationError("Cannot load when the service is already active.");
			}
			this._isActive = true;
			this._savedDelayedCall = Starling.current.juggler.delayCall(locationsLoaded, 0.5);
		}

		public function saveFavoriteLocations():void
		{
			if(this._isActive)
			{
				throw new IllegalOperationError("Cannot save when the service is already active.");
			}
			this._isActive = true;
			this._savedDelayedCall = Starling.current.juggler.delayCall(locationsSaved, 0.5);
		}

		private function locationsLoaded():void
		{
			this._isActive = false;
			this._savedDelayedCall = null;
			this.favoriteLocationsModel.replaceFavoriteLocations(new <LocationItem>[]);
			this.dispatchWith(FavoriteLocationsEventType.FAVORITE_LOCATIONS_LOAD_COMPLETE);
		}

		private function locationsSaved():void
		{
			this._isActive = false;
			this._savedDelayedCall = null;
			this.dispatchWith(FavoriteLocationsEventType.FAVORITE_LOCATIONS_SAVE_COMPLETE);
		}
	}
}
