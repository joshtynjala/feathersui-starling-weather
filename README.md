# "Feathers Weather" Example App

A mobile app for displaying weather forecasts built with [Starling Framework](http://gamua.com/starling/), [Feathers](http://feathersui.com/), and Josh Tynjala's [port of Robotlegs 1.x to Starling Framework](https://github.com/joshtynjala/robotlegs-framework-starling). Uses the [Yahoo! GeoPlanet API](http://developer.yahoo.com/geo/geoplanet/) to search for locations around the world and the [Yahoo! Weather API](http://developer.yahoo.com/weather/) to load forecast data.

## Requirements

The following libraries are required.

* [Starling Framework 1.4.1](http://gamua.com/starling/)
* [Feathers 1.3.0](http://feathersui.com/)
* [Robotlegs 1.x for Starling Framework](https://github.com/joshtynjala/robotlegs-framework-starling)

Additionally, you will need a [Yahoo! GeoPlanet API key](http://developer.yahoo.com/geo/geoplanet/). Pass in this API key by defining a conditional constant named `CONFIG::API_KEY`. If you are compiling with an IDE, conditional constants are usually defined somewhere in your project's settings. On the command line, you may use the `-define` compiler argument:

	-define+=CONFIG::API_KEY,'your flickr api key'
