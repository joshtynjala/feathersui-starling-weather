package feathers.examples.weather.services
{
	public interface ILocationSearchService
	{
		function get isSearching():Boolean;
		function cancelSearch():void;
		function search(query:String):void;
	}
}
