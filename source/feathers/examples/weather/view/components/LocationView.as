package feathers.examples.weather.view.components
{
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.PanelScreen;
	import feathers.controls.TextInput;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import feathers.examples.weather.model.LocationItem;

	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import feathers.skins.IStyleProvider;
	import feathers.examples.weather.view.components.LocationView;

	[Event(name="change",type="starling.events.Event")]

	public class LocationView extends PanelScreen
	{
		public static var globalStyleProvider:IStyleProvider;

		public static const EVENT_SEARCH:String = "search";
		public static const EVENT_DELETE_FAVORITE_LOCATION:String = "deleteFavoriteLocation";
		public static const EVENT_SAVE_FAVORITE_LOCATION:String = "saveFavoriteLocation";

		public static const CHILD_STYLE_NAME_LIST:String = "FeathersWeather-LocationView-List";

		public static const CHILD_STYLE_NAME_STATUS_LABEL:String = "FeathersWeather-LocationView-StatusLabel";

		private static const SEARCH_DELAY:Number = 0.5;

		private static const NO_RESULTS_MESSAGE:String = "No locations found. Please try a different query.";

		public function LocationView()
		{
			this.headerFactory = customHeaderFactory;
		}

		override protected function get defaultStyleProvider():IStyleProvider
		{
			return LocationView.globalStyleProvider;
		}

		private var _statusLabel:Label;

		private var _searchInput:TextInput;

		private var _locationsList:List;

		private var _favoriteLocations:ListCollection;

		public function get favoriteLocations():ListCollection
		{
			return this._favoriteLocations;
		}

		public function set favoriteLocations(value:ListCollection):void
		{
			if(this._favoriteLocations == value)
			{
				return;
			}
			this._favoriteLocations = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		private var _selectedFavoriteLocation:LocationItem;

		public function get selectedFavoriteLocation():LocationItem
		{
			return this._selectedFavoriteLocation;
		}

		public function set selectedFavoriteLocation(value:LocationItem):void
		{
			if(this._selectedFavoriteLocation == value)
			{
				return;
			}
			this._selectedFavoriteLocation = value;
			this.dispatchEventWith(Event.CHANGE);
			this.invalidate(INVALIDATION_FLAG_SELECTED);
		}

		private var _searchResultLocations:ListCollection;

		public function get searchResultLocations():ListCollection
		{
			return this._searchResultLocations;
		}

		public function set searchResultLocations(value:ListCollection):void
		{
			if(this._searchResultLocations == value)
			{
				return;
			}
			this._searchResultLocations = value;
			if(this._searchResultLocations)
			{
				this.showResults();
			}
			else
			{
				this.showFavorites();
			}
		}

		private var _searchError:String;

		public function get searchError():String
		{
			return this._searchError;
		}

		public function set searchError(value:String):void
		{
			if(this._searchError == value)
			{
				return;
			}
			this._searchError = value;
			this.showError();
		}

		private var _searchQuery:String;

		public function get searchQuery():String
		{
			return this._searchQuery;
		}

		public function set searchQuery(value:String):void
		{
			if(this._searchQuery == value)
			{
				return;
			}
			this._searchQuery = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		private var _savedDelayedCall:DelayedCall;

		override protected function initialize():void
		{
			super.initialize();

			this._locationsList = new List();
			this._locationsList.styleNameList.add(CHILD_STYLE_NAME_LIST);
			this._locationsList.addEventListener(Event.CHANGE, locationsList_changeHandler);
			this._locationsList.addEventListener(FeathersEventType.RENDERER_ADD, locationsList_rendererAddHandler);
			this._locationsList.addEventListener(FeathersEventType.RENDERER_REMOVE, locationsList_rendererRemoveHandler);
			this.addChild(this._locationsList);

			this._searchInput = new TextInput();
			this._searchInput.styleNameList.add(TextInput.ALTERNATE_STYLE_NAME_SEARCH_TEXT_INPUT);
			this._searchInput.addEventListener(Event.CHANGE, searchInput_changeHandler);

			this._statusLabel = new Label();
			this._statusLabel.styleNameList.add(CHILD_STYLE_NAME_STATUS_LABEL);
			this._statusLabel.visible = false;
			this.addChild(this._statusLabel);

			this.headerFactory = this.customHeaderFactory;

			this.showFavorites();
		}

		override protected function draw():void
		{
			var dataInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_DATA);
			var selectedInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_SELECTED);

			if(dataInvalid)
			{
				this._searchInput.text = this._searchQuery;
				if(this._searchQuery)
				{
					this._locationsList.dataProvider = this._searchResultLocations;
				}
				else
				{
					this._locationsList.dataProvider = this._favoriteLocations;
				}
			}

			if(dataInvalid || selectedInvalid)
			{
				if(!this._searchQuery)
				{
					this._locationsList.selectedItem = this._selectedFavoriteLocation;
				}
			}

			super.draw();
		}

		private function savedLocationItemRendererFactory():DefaultListItemRenderer
		{
			var renderer:FavoriteLocationItemRenderer = new FavoriteLocationItemRenderer();
			renderer.labelField = "name";
			renderer.iconLabelField = "region";
			return renderer;
		}

		private function resultLocationItemRendererFactory():DefaultListItemRenderer
		{
			var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
			renderer.labelField = "name";
			renderer.accessoryLabelField = "region";
			renderer.itemHasIcon = false;
			return renderer;
		}

		private function customHeaderFactory():Header
		{
			var header:Header = new Header();
			header.centerItems = new <DisplayObject>[this._searchInput];
			return header;
		}

		private function showFavorites():void
		{
			this._statusLabel.visible = false;
			this._locationsList.visible = true;
			this._locationsList.itemRendererFactory = savedLocationItemRendererFactory;
			this._locationsList.dataProvider = null;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		private function showSearching():void
		{
			this._locationsList.visible = false;
			this._locationsList.dataProvider = null;
			this._statusLabel.text = "Searching...";
			this._statusLabel.visible = true;
		}

		private function showResults():void
		{
			if(this._searchResultLocations.length == 0)
			{
				this._statusLabel.text = NO_RESULTS_MESSAGE;
				this._statusLabel.visible = true;
				this._locationsList.visible = false;
			}
			else
			{
				this._statusLabel.visible = false;
				this._locationsList.visible = true;
				this._locationsList.itemRendererFactory = resultLocationItemRendererFactory;
				this._locationsList.dataProvider = null;
			}
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		private function showError():void
		{
			this._locationsList.visible = false;
			this._locationsList.dataProvider = null;
			this._statusLabel.text = this._searchError;
			this._statusLabel.visible = true;
		}

		private function updateSearch():void
		{
			this._savedDelayedCall = null;
			this._searchResultLocations = null;
			this._searchQuery = this._searchInput.text;
			this.dispatchEventWith(EVENT_SEARCH);
			this.showSearching();
		}

		private function locationsList_changeHandler(event:Event):void
		{
			var selectedLocation:LocationItem = LocationItem(this._locationsList.selectedItem);
			if(this._locationsList.dataProvider == this._favoriteLocations)
			{
				this.selectedFavoriteLocation = selectedLocation;
			}
			else if(selectedLocation)
			{
				this.dispatchEventWith(EVENT_SAVE_FAVORITE_LOCATION, false, selectedLocation);
			}
		}

		private function locationsList_rendererAddHandler(event:Event, renderer:IListItemRenderer):void
		{
			if(renderer is FavoriteLocationItemRenderer)
			{
				renderer.addEventListener(FavoriteLocationItemRenderer.EVENT_DELETE_LOCATION, favoriteLocationItemRenderer_deleteLocationHandler);
			}
		}

		private function locationsList_rendererRemoveHandler(event:Event, renderer:IListItemRenderer):void
		{
			if(renderer is FavoriteLocationItemRenderer)
			{
				renderer.removeEventListener(FavoriteLocationItemRenderer.EVENT_DELETE_LOCATION, favoriteLocationItemRenderer_deleteLocationHandler);
			}
		}

		private function favoriteLocationItemRenderer_deleteLocationHandler(event:Event):void
		{
			var renderer:FavoriteLocationItemRenderer = FavoriteLocationItemRenderer(event.currentTarget);
			this.dispatchEventWith(EVENT_DELETE_FAVORITE_LOCATION, false, renderer.data);
			if(this._locationsList.selectedIndex < 0)
			{
				this._locationsList.selectedIndex = 0;
			}
		}

		private function searchInput_changeHandler(event:Event):void
		{
			var newQuery:String = this._searchInput.text;
			if(newQuery.length == 0)
			{
				if(this._savedDelayedCall)
				{
					Starling.current.juggler.remove(this._savedDelayedCall);
					this._savedDelayedCall = null;
				}
				this._searchResultLocations = null;
				this._searchQuery = newQuery;
				this.dispatchEventWith(EVENT_SEARCH);
				this.showFavorites();
			}
			else
			{
				if(this._savedDelayedCall)
				{
					this._savedDelayedCall = this._savedDelayedCall.reset(updateSearch, SEARCH_DELAY)
				}
				else
				{
					this._savedDelayedCall = Starling.juggler.delayCall(updateSearch, SEARCH_DELAY) as DelayedCall;
				}
			}
		}
	}
}
