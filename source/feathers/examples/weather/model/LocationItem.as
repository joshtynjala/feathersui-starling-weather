package feathers.examples.weather.model
{
	public class LocationItem
	{
		private static const ERROR_ID:String = "error";
		private static const DESCRIPTION_ID:String = "description";
		private static const STATUS_ID:String = "status";

		private static const NAME_ID:String = "name";
		private static const STATE_ID:String = "admin1";
		private static const COUNTRY_ID:String = "country";
		private static const WOEID_ID:String = "woeid";
		private static const REGION_ID:String = "region";

		public static function fromFavoriteLocationsJSON(json:Object, result:Vector.<LocationItem> = null):Vector.<LocationItem>
		{
			if(result)
			{
				result.length = 0;
			}
			else
			{
				result = new <LocationItem>[];
			}

			var favoritesJSON:Array = json.favorites;
			var count:int = favoritesJSON.length;
			for(var i:int = 0; i < count; i++)
			{
				var favoriteJSON:Object = favoritesJSON[i];
				var name:String = favoriteJSON[NAME_ID];
				var region:String = favoriteJSON[REGION_ID];
				var woeid:String = favoriteJSON[WOEID_ID];
				result.push(new LocationItem(name, woeid, region));
			}
			return result;
		}

		public static function fromYahooGeoYQLJSON(json:Object, result:Vector.<LocationItem> = null):Vector.<LocationItem>
		{
			if(json.hasOwnProperty(ERROR_ID))
			{
				var jsonError:Object = json[ERROR_ID];
				var errorDescription:String = jsonError[DESCRIPTION_ID];
				var errorStatus:String = jsonError[STATUS_ID];
				throw new Error(errorDescription, errorStatus);
			}
			if(result)
			{
				result.length = 0;
			}
			else
			{
				result = new <LocationItem>[];
			}
			if(json.query.count > 0)
			{
				var placesJSON:Object = json.query.results.place;
				if(placesJSON is Array)
				{
					var count:int = placesJSON.length;
					for(var i:int = 0; i < count; i++)
					{
						var placeJSON:Object = placesJSON[i];
						var item:LocationItem = parsePlace(placesJSON[i]);
						result.push(item);
					}
				}
				else
				{
					item = parsePlace(placesJSON);
					result.push(item);
				}
			}

			return result;
		}

		private static function parsePlace(json:Object):LocationItem
		{
			var name:String = json[NAME_ID];
			var woeid:String = json[WOEID_ID];
			var region:String = "";
			if(STATE_ID in json)
			{
				region += json[STATE_ID] + ", ";
			}
			region += json[COUNTRY_ID];
			return new LocationItem(name, woeid, region)
		}

		public function LocationItem(name:String, woeid:String, region:String)
		{
			this.name = name;
			this.woeid = woeid;
			this.region = region;
		}

		public var name:String;
		public var woeid:String;
		public var region:String;
	}
}
