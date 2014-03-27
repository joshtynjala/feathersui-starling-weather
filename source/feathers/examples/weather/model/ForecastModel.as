package feathers.examples.weather.model
{
	import feathers.data.ListCollection;
	import feathers.examples.weather.events.ForecastEventType;

	import org.robotlegs.starling.mvcs.Actor;

	public class ForecastModel extends Actor
	{
		public function ForecastModel()
		{
		}

		private var _forecasts:ListCollection = new ListCollection();

		public function get forecasts():ListCollection
		{
			return this._forecasts;
		}

		public function replaceForecasts(forecasts:Vector.<ForecastItem>):void
		{
			if(this._forecasts.data == forecasts)
			{
				return;
			}
			this._forecasts.data = forecasts;
		}

		private var _selectedLocation:LocationItem;

		public function get selectedLocation():LocationItem
		{
			return this._selectedLocation;
		}

		public function selectLocation(location:LocationItem):void
		{
			if(this._selectedLocation == location)
			{
				return;
			}
			this._selectedLocation = location;
			this.dispatchWith(ForecastEventType.SELECTED_LOCATION_CHANGE);
		}
	}
}
