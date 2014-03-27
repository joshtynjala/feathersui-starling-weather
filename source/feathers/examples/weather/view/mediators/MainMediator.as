package feathers.examples.weather.view.mediators
{
	import feathers.examples.weather.Main;
	import feathers.examples.weather.events.ForecastEventType;

	import org.robotlegs.starling.mvcs.Mediator;

	import starling.events.Event;

	public class MainMediator extends Mediator
	{
		[Inject]
		public var main:Main;

		override public function onRegister():void
		{
			this.addContextListener(ForecastEventType.SELECTED_LOCATION_CHANGE, context_selectedLocationChangeHandler);
		}

		private function context_selectedLocationChangeHandler(event:Event):void
		{
			this.main.closeDrawers();
		}
	}
}
