package feathers.examples.weather.services
{
	import feathers.examples.weather.events.LocationSearchEventType;
	import feathers.examples.weather.model.LocationItem;
	import feathers.examples.weather.model.LocationSearchModel;

	import flash.errors.IllegalOperationError;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;

	import org.robotlegs.starling.mvcs.Actor;

	public class ProductionLocationSearchService extends Actor implements ILocationSearchService
	{
		private static const BASE_URL_1:String = "http://where.yahooapis.com/v1/places.q('";
		private static const BASE_URL_2:String = "');count=10?format=json&appid=";

		private var _loader:URLLoader;

		[Inject]
		public var locationSearchModel:LocationSearchModel;

		public function get isSearching():Boolean
		{
			return this._loader != null;
		}

		public function cancelSearch():void
		{
			if(!this._loader)
			{
				return;
			}
			this._loader.removeEventListener(Event.COMPLETE, loader_completeHandler);
			this._loader.removeEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
			this._loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_errorHandler);
			this._loader.close();
			this._loader = null;
		}

		public function search(query:String):void
		{
			if(this.isSearching)
			{
				throw new IllegalOperationError("Cannot search when a search is already active.")
			}

			//CONFIG::API_KEY is a conditional constant that defines the Yahoo! GeoPlanet API key.
			//Get an API key from here: http://developer.yahoo.com/wsregapp/
			var apiKey:String = CONFIG::API_KEY;

			this._loader = new URLLoader();
			this._loader.dataFormat = URLLoaderDataFormat.TEXT;
			this._loader.addEventListener(Event.COMPLETE, loader_completeHandler);
			this._loader.addEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
			this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_errorHandler);
			this._loader.load(new URLRequest(BASE_URL_1 + encodeURIComponent(query) + BASE_URL_2 + apiKey));
		}

		private function loader_completeHandler(event:Event):void
		{
			var resultText:String = this._loader.data as String;
			this._loader.removeEventListener(Event.COMPLETE, loader_completeHandler);
			this._loader.removeEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
			this._loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_errorHandler);
			this._loader = null;
			try
			{
				var result:Object = JSON.parse(resultText);
				var locations:Vector.<LocationItem> = LocationItem.fromYahooGeoplanetJSON(result);
				this.locationSearchModel.replaceResultLocations(locations);
				this.dispatchWith(LocationSearchEventType.LOCATION_SEARCH_COMPLETE);
			}
			catch(error:Error)
			{
				this.dispatchWith(LocationSearchEventType.LOCATION_SEARCH_ERROR);
			}
		}

		private function loader_errorHandler(event:ErrorEvent):void
		{
			this._loader.removeEventListener(Event.COMPLETE, loader_completeHandler);
			this._loader.removeEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
			this._loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_errorHandler);
			this._loader = null;
			var error:Error = new Error(event.text, event.errorID);
			trace(error);
			this.dispatchWith(LocationSearchEventType.LOCATION_SEARCH_ERROR);
		}
	}
}
