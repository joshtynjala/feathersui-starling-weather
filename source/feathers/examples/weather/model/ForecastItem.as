package feathers.examples.weather.model
{
	public class ForecastItem
	{
		private static const yweather:Namespace = new Namespace(null, "http://xml.weather.yahoo.com/ns/rss/1.0");
		private static const ERROR_ELEMENT:String = "error";
		private static const DESCRIPTION_ELEMENT:String = "description";
		private static const RESULTS_ELEMENT:String = "results";
		private static const CHANNEL_ELEMENT:String = "channel";
		private static const ITEM_ELEMENT:String = "item";
		private static const CONDITION_ELEMENT:QName = new QName(yweather, "condition");
		private static const FORECAST_ELEMENT:QName = new QName(yweather, "forecast");
		private static const TEMP_ATTRIBUTE:QName = new QName(yweather, "temp");
		private static const DATE_ATTRIBUTE:QName = new QName(yweather, "date");
		private static const TEXT_ATTRIBUTE:QName = new QName(yweather, "text");
		private static const CODE_ATTRIBUTE:QName = new QName(yweather, "code");
		private static const HIGH_ATTRIBUTE:QName = new QName(yweather, "high");
		private static const LOW_ATTRIBUTE:QName = new QName(yweather, "low");
		private static const DAY_ATTRIBUTE:QName = new QName(yweather, "day");

		public static function fromYahooWeatherYQLXML(rss:XML, result:Vector.<ForecastItem> = null):Vector.<ForecastItem>
		{
			if(rss.localName() === ERROR_ELEMENT)
			{
				var errorDescription:String = rss.elements(DESCRIPTION_ELEMENT);
				throw new Error(errorDescription);
			}
			if(result)
			{
				result.length = 0;
			}
			else
			{
				result = new <ForecastItem>[];
			}
			var xmlList:XMLList = rss.elements(RESULTS_ELEMENT).elements(CHANNEL_ELEMENT);
			if(xmlList.length() == 0)
			{
				return result;
			}
			xmlList = xmlList[0].elements(ITEM_ELEMENT);
			if(xmlList.length() == 0)
			{
				return result;
			}
			rss = xmlList[0];
			xmlList = rss.elements(CONDITION_ELEMENT);
			var count:int = xmlList.length();
			for(var i:int = 0; i < count; i++)
			{
				var conditions:ForecastItem = ForecastItem.fromYahooWeatherRSSCondition(xmlList[i]);
				result.push(conditions);
			}
			xmlList = rss.elements(FORECAST_ELEMENT);
			count = xmlList.length();
			for(i = 0; i < count; i++)
			{
				conditions = ForecastItem.fromYahooWeatherRSSForecast(xmlList[i]);
				result.push(conditions);
			}
			return result;
		}

		public static function fromYahooWeatherRSSCondition(rss:XML):ForecastItem
		{
			var elementName:String = rss.localName();
			if(elementName != CONDITION_ELEMENT.localName)
			{
				throw new ArgumentError("Cannot parse condition element.");
			}
			var result:ForecastItem = new ForecastItem();
			result.temp = rss.attribute(TEMP_ATTRIBUTE).toString();
			result.code = rss.attribute(CODE_ATTRIBUTE).toString();
			result.text = rss.attribute(TEXT_ATTRIBUTE).toString();
			result.date = new Date(rss.attribute(DATE_ATTRIBUTE).toString());
			return result;
		}

		public static function fromYahooWeatherRSSForecast(rss:XML):ForecastItem
		{
			var elementName:String = rss.localName();
			if(elementName != FORECAST_ELEMENT.localName)
			{
				throw new ArgumentError("Cannot parse forecast element.");
			}

			var result:ForecastItem = new ForecastItem();
			result.day = rss.attribute(DAY_ATTRIBUTE).toString();
			result.high = rss.attribute(HIGH_ATTRIBUTE).toString();
			result.low = rss.attribute(LOW_ATTRIBUTE).toString();
			result.code = rss.attribute(CODE_ATTRIBUTE).toString();
			result.text = rss.attribute(TEXT_ATTRIBUTE).toString();
			result.date = new Date(rss.attribute(DATE_ATTRIBUTE).toString());
			return result;
		}

		public function ForecastItem()
		{
		}

		public var text:String;
		public var code:String;
		public var temp:String;
		public var date:Date;
		public var day:String;
		public var low:String;
		public var high:String;
	}
}
