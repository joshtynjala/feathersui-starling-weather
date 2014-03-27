package feathers.examples.weather.services
{
	import feathers.examples.weather.events.LocationSearchEventType;
	import feathers.examples.weather.model.LocationItem;
	import feathers.examples.weather.model.LocationSearchModel;

	import flash.errors.IllegalOperationError;

	import org.robotlegs.starling.mvcs.Actor;

	import starling.animation.DelayedCall;
	import starling.core.Starling;

	/**
	 * This class is used for testing purposes. It uses mock data to avoid
	 * calling the real service.
	 *
	 * @see ProductionLocationSearchService
	 */
	public class DebugLocationSearchServiceNoResults extends Actor implements ILocationSearchService
	{
		[Inject]
		public var locationSearchModel:LocationSearchModel;

		private var _savedDelayedCall:DelayedCall;

		public function get isSearching():Boolean
		{
			return this._savedDelayedCall;
		}

		public function cancelSearch():void
		{
			if(this._savedDelayedCall)
			{
				Starling.current.juggler.remove(this._savedDelayedCall);
				this._savedDelayedCall = null;
			}
		}

		public function search(query:String):void
		{
			if(this.isSearching)
			{
				throw new IllegalOperationError("Cannot search when a search is already active.")
			}
			this._savedDelayedCall = Starling.current.juggler.delayCall(locationsLoaded, 0.5);
		}

		private function locationsLoaded():void
		{
			this._savedDelayedCall = null;
			try
			{
				this.locationSearchModel.replaceResultLocations(new <LocationItem>[]);
				this.dispatchWith(LocationSearchEventType.LOCATION_SEARCH_COMPLETE);
			}
			catch(error:Error)
			{
				this.dispatchWith(LocationSearchEventType.LOCATION_SEARCH_ERROR);
			}
		}
	}
}
