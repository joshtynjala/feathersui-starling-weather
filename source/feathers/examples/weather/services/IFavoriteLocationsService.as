package feathers.examples.weather.services
{
	public interface IFavoriteLocationsService
	{
		function get isActive():Boolean;
		function loadFavoriteLocations():void;
		function saveFavoriteLocations():void;
	}
}
