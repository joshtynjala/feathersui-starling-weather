package feathers.examples.weather.model
{
	public class LocationItem
	{
		private static const ERROR_ID:String = "error";
		private static const DESCRIPTION_ID:String = "description";
		private static const DETAIL_ID:String = "detail";

		private static const NAME_ID:String = "name";
		private static const STATE_ID:String = "admin1";
		private static const STATE_ATTRS_ID:String = "admin1 attrs";
		private static const STATE_ATTRS_TYPE_ID:String = "type";
		private static const STATE_ATTRS_TYPE_STATE:String = "State";
		private static const COUNTRY_ID:String = "country";
		private static const PLACE_TYPE_NAME_ATTRS_ID:String = "placeTypeName attrs";
		private static const PLACE_TYPE_NAME_CODE_ID:String = "code";
		private static const PLACE_TYPE_CODE_TOWN:int = 7;
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

		public static function fromYahooGeoplanetJSON(json:Object, result:Vector.<LocationItem> = null):Vector.<LocationItem>
		{
			if(json.hasOwnProperty(ERROR_ID))
			{
				var jsonError:Object = json[ERROR_ID];
				var error:Error = new Error(jsonError[DETAIL_ID]);
				error.name = jsonError[DESCRIPTION_ID];
				throw error;
			}
			if(result)
			{
				result.length = 0;
			}
			else
			{
				result = new <LocationItem>[];
			}

			var placesJSON:Array = json.places.place;
			var count:int = placesJSON.length;
			for(var i:int = 0; i < count; i++)
			{
				var placeJSON:Object = placesJSON[i];
				if(placeJSON[PLACE_TYPE_NAME_ATTRS_ID][PLACE_TYPE_NAME_CODE_ID] != PLACE_TYPE_CODE_TOWN)
				{
					continue;
				}
				var name:String = placeJSON[NAME_ID];
				var woeid:String = placeJSON[WOEID_ID];
				var region:String = "";
				if(placeJSON[STATE_ATTRS_ID][STATE_ATTRS_TYPE_ID] == STATE_ATTRS_TYPE_STATE)
				{
					region += placeJSON[STATE_ID] + ", ";
				}
				region += placeJSON[COUNTRY_ID];
				result.push(new LocationItem(name, woeid, region));
			}

			return result;
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
