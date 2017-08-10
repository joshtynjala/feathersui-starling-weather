package feathers.examples.weather
{
	import feathers.controls.Drawers;
	import feathers.examples.weather.theme.FeathersWeatherTheme;
	import feathers.examples.weather.view.components.ForecastView;
	import feathers.examples.weather.view.components.LocationView;

	import starling.display.Sprite;
	import starling.events.Event;
	import feathers.controls.DragGesture;

	public class Main extends Sprite
	{
		public function Main()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}

		private var _context:FeathersWeatherContext;
		private var _drawers:Drawers;

		public function closeDrawers():void
		{
			if(!this._drawers || !this._drawers.isLeftDrawerOpen)
			{
				return;
			}
			this._drawers.toggleLeftDrawer();
		}

		protected function addedToStageHandler(event:Event):void
		{
			new FeathersWeatherTheme();

			this._context = new FeathersWeatherContext(this);

			this._drawers = new Drawers();

			this._drawers.content = new ForecastView();
			this._drawers.leftDrawer = new LocationView();
			this._drawers.leftDrawerToggleEventType = ForecastView.EVENT_OPEN_MENU;

			this._drawers.openGesture = DragGesture.EDGE;

			this.addChild(this._drawers);
		}
	}
}
