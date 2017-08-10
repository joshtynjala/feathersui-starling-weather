package feathers.examples.weather.view.components
{
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.data.ListCollection;

	import starling.events.Event;
	import feathers.data.IListCollection;
	import feathers.skins.IStyleProvider;

	public class FavoriteLocationItemRenderer extends DefaultListItemRenderer
	{
		public static var globalStyleProvider:IStyleProvider;

		public static const CHILD_STYLE_NAME_DELETE_BUTTON:String = "FeathersWeather-FavoriteLocationItem-DeleteButton";

		public static const EVENT_DELETE_LOCATION:String = "deleteLocation";

		public function FavoriteLocationItemRenderer()
		{
		}

		override protected function get defaultStyleProvider():IStyleProvider
		{
			return FavoriteLocationItemRenderer.globalStyleProvider;
		}

		protected var deleteButton:Button;

		protected var savedDataProvider:IListCollection;

		override public function set owner(value:List):void
		{
			if(this._owner == value)
			{
				return;
			}
			if(savedDataProvider)
			{
				savedDataProvider.removeEventListener(Event.CHANGE, dataProvider_changeHandler);
				savedDataProvider = null;
			}
			super.owner = value;
			if(this._owner)
			{
				savedDataProvider = value.dataProvider;
				if(savedDataProvider)
				{
					savedDataProvider.addEventListener(Event.CHANGE, dataProvider_changeHandler);
				}
			}
		}

		override protected function initialize():void
		{
			super.initialize();

			this.itemHasAccessory = false;
			this.deleteButton = new Button();
			this.deleteButton.styleNameList.add(CHILD_STYLE_NAME_DELETE_BUTTON);
			this.deleteButton.addEventListener(Event.TRIGGERED, deleteButton_triggeredHandler);
			this.replaceAccessory(this.deleteButton);
		}

		override protected function commitData():void
		{
			if(this._owner)
			{
				this.deleteButton.visible = List(this._owner).dataProvider.length > 1;
			}
			else
			{
				this.deleteButton.visible = false;
			}
			super.commitData();
		}

		private function deleteButton_triggeredHandler(event:Event):void
		{
			this.dispatchEventWith(EVENT_DELETE_LOCATION);
		}

		private function dataProvider_changeHandler(event:Event):void
		{
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
	}
}
