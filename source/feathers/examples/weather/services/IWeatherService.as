package feathers.examples.weather.services
{
	public interface IWeatherService
	{
		function loadForecastForLocation(woeid:String):void;
	}
}
