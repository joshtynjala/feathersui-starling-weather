# "Feathers Weather" Example App

A mobile app for displaying weather forecasts built with [Starling Framework](http://gamua.com/starling/), [Feathers](http://feathersui.com/), and [Robotlegs](https://github.com/joshtynjala/robotlegs-framework-starling). Uses the [Yahoo! GeoPlanet API](http://developer.yahoo.com/geo/geoplanet/) to search for locations around the world and the [Yahoo! Weather API](http://developer.yahoo.com/weather/) to load forecast data.

## Requirements

The following libraries are required. They should be placed in a folder named `libraries`.

* [Starling Framework 1.5.1](http://gamua.com/starling/)
* [Feathers 1.3.0](http://feathersui.com/)
* [Robotlegs for Starling Framework v0.9.1](https://github.com/joshtynjala/robotlegs-framework-starling)

Additionally, you will need a [Yahoo! GeoPlanet API key](http://developer.yahoo.com/geo/geoplanet/). Pass in this API key by defining a conditional constant named `CONFIG::API_KEY`. If you are compiling with an IDE, conditional constants are usually defined somewhere in your project's settings. On the command line, you may use the `-define` compiler argument:

	-define+=CONFIG::API_KEY,'your yahoo api key'
