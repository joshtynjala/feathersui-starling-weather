package feathers.examples.weather.controller
{
	import feathers.examples.weather.services.IFavoriteLocationsService;

	import org.robotlegs.starling.mvcs.Command;

	public class StartupCommand extends Command
	{
		[Inject]
		public var favoriteLocationsService:IFavoriteLocationsService;

		override public function execute():void
		{
			this.favoriteLocationsService.loadFavoriteLocations();
		}
	}
}
