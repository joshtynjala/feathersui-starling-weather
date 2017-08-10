package feathers.examples.weather
{
	import feathers.controls.DragGesture;
	import feathers.controls.Drawers;
	import feathers.examples.weather.theme.FeathersWeatherTheme;
	import feathers.examples.weather.view.components.ForecastView;
	import feathers.examples.weather.view.components.LocationView;

	import starling.display.Sprite;
	import starling.events.Event;

	public class Main extends Drawers
	{
		public function Main()
		{
			new FeathersWeatherTheme();
			super();
		}

		private var _context:FeathersWeatherContext;

		public function closeDrawers():void
		{
			if(!this.isLeftDrawerOpen)
			{
				return;
			}
			this.toggleLeftDrawer();
		}

		override protected function initialize():void
		{
			super.initialize();

			this._context = new FeathersWeatherContext(this);

			this.content = new ForecastView();
			this.leftDrawer = new LocationView();
			this.leftDrawerToggleEventType = ForecastView.EVENT_OPEN_MENU;

			this.openGesture = DragGesture.EDGE;
		}
	}
}
