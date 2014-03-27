package feathers.examples.weather.services
{
	import feathers.data.ListCollection;
	import feathers.examples.weather.events.FavoriteLocationsEventType;
	import feathers.examples.weather.model.FavoriteLocationsModel;
	import feathers.examples.weather.model.LocationItem;

	import flash.errors.IllegalOperationError;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	import org.robotlegs.starling.mvcs.Actor;

	public class ProductionFavoriteLocationsService extends Actor implements IFavoriteLocationsService
	{
		private static const FILE_NAME:String = "feathers-weather-favorites.json";

		public function ProductionFavoriteLocationsService()
		{
		}

		[Inject]
		public var favoriteLocationsModel:FavoriteLocationsModel;

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
			var file:File = File.applicationStorageDirectory.resolvePath(FILE_NAME);
			if(!file.exists)
			{
				//another part of the app will select a default location when
				//the favorites file doesn't exist yet.
				this.favoriteLocationsModel.replaceFavoriteLocations(new <LocationItem>[]);
				this._isActive = false;
				this.dispatchWith(FavoriteLocationsEventType.FAVORITE_LOCATIONS_LOAD_COMPLETE);
				return;
			}
			try
			{
				var stream:FileStream = new FileStream();
				stream.open(file, FileMode.READ);
				var result:Object = JSON.parse(stream.readUTFBytes(stream.bytesAvailable));
				var locations:Vector.<LocationItem> = LocationItem.fromFavoriteLocationsJSON(result);
				this.favoriteLocationsModel.replaceFavoriteLocations(locations);
				this._isActive = false;
				this.dispatchWith(FavoriteLocationsEventType.FAVORITE_LOCATIONS_LOAD_COMPLETE);
			}
			catch(error:Error)
			{
				//there's not much we can do about a corrupt file
				this.favoriteLocationsModel.replaceFavoriteLocations(new <LocationItem>[]);
				this._isActive = false;
				this.dispatchWith(FavoriteLocationsEventType.FAVORITE_LOCATIONS_LOAD_ERROR);
			}
		}

		public function saveFavoriteLocations():void
		{
			if(this._isActive)
			{
				throw new IllegalOperationError("Cannot save when the service is already active.");
			}
			this._isActive = true;
			var file:File = File.applicationStorageDirectory.resolvePath(FILE_NAME);
			var locations:ListCollection = this.favoriteLocationsModel.favoriteLocations;
			var locationsAsArray:Array = [];
			var locationCount:int = locations.length;
			for(var i:int = 0; i < locationCount; i++)
			{
				var location:LocationItem = LocationItem(locations.getItemAt(i));
				locationsAsArray.push(location);
			}
			var jsonString:String = JSON.stringify({favorites: locationsAsArray});
			try
			{
				var stream:FileStream = new FileStream();
				stream.open(file, FileMode.WRITE);
				stream.writeUTFBytes(jsonString);
				this._isActive = false;
				this.dispatchWith(FavoriteLocationsEventType.FAVORITE_LOCATIONS_SAVE_COMPLETE);
			}
			catch(error:Error)
			{
				this._isActive = false;
				this.dispatchWith(FavoriteLocationsEventType.FAVORITE_LOCATIONS_SAVE_ERROR);
			}
		}
	}
}
