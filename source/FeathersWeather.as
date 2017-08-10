package
{
	import feathers.examples.weather.Main;
	import feathers.utils.ScreenDensityScaleFactorManager;

	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageOrientation;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.utils.ByteArray;

	import starling.core.Starling;

	[SWF(width="960",height="640",frameRate="60",backgroundColor="#4d545e")]
	public class FeathersWeather extends Sprite
	{
		public function FeathersWeather()
		{
			if(this.stage)
			{
				this.stage.scaleMode = StageScaleMode.NO_SCALE;
				this.stage.align = StageAlign.TOP_LEFT;
			}
			this.mouseEnabled = this.mouseChildren = false;
			this.loaderInfo.addEventListener(Event.COMPLETE, loaderInfo_completeHandler);
		}

		private var _starling:Starling;
		private var _scaler:ScreenDensityScaleFactorManager;

		private function loaderInfo_completeHandler(event:Event):void
		{
			Starling.multitouchEnabled = true;
			this._starling = new Starling(Main, this.stage);
			this._starling.enableErrorChecking = false;
			this._starling.supportHighResolutions = true;
			//this._starling.showStats = true;
			//this._starling.showStatsAt(HAlign.LEFT, VAlign.BOTTOM);
			this._scaler = new ScreenDensityScaleFactorManager(this._starling);
			this._starling.start();

			this.stage.addEventListener(Event.DEACTIVATE, stage_deactivateHandler, false, 0, true);
		}

		private function stage_deactivateHandler(event:Event):void
		{
			this._starling.stop();
			this.stage.addEventListener(Event.ACTIVATE, stage_activateHandler, false, 0, true);
		}

		private function stage_activateHandler(event:Event):void
		{
			this.stage.removeEventListener(Event.ACTIVATE, stage_activateHandler);
			this._starling.start();
		}

	}
}