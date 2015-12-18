## slack-map: A slack slash command for the Google Static Maps API

slack-map lets you post static Google Maps images into your Slack instance. Request a map with a command like `/map London` and an image of that location will be posted into your Slack channel along with a link to open the map in your browser.

### Examples

![Rome](https://slack-files.com/files-pub/T024F5NQC-F028EB7BH-760726/map_rome.png)
![221B Baker Street](https://slack-files.com/files-pub/T024F5NQC-F028EB86D-d3082a/map_sherlock.png)
![Vatican City](https://slack-files.com/files-pub/T024F5NQC-F028F1X3L-f17bc9/map_vatican_city_satellite.png)
![Costa Rica](https://slack-files.com/files-pub/T024F5NQC-F028F1X4U-b02c7d/map_costa_rica_terrain.png)

### Setup

There are a few moving parts to get this integration set up for your Slack team. These steps assume some knowledge of Slack, git, and Heroku, though links to documentation have been provided where possible.

**1. Heroku App**

* Clone this git repo
* Deploy your copy as a new app to Heroku (https://devcenter.heroku.com/articles/git)
* Get your heroku app URL (something like `http://appname.herokuapp.com/`). You'll need this in the next step.

_You could also host this Rails app anywhere web-accessible. There's no reason it needs to be on Heroku: it's just a free and easy place to host apps._

**2. Slack Slash Command**

* Go to https://slack.com/apps/A0F82E8CA-slash-commands
* Choose your team
* Click "Add Configuration"
  * _Command:_ /map
  * _URL:_ `http://appname.herokuapp.com/map` (the `/map` is important here. Don't forget it!)
  * _Method:_ `POST`
  * ... finish customizations to your liking
* Click "Save Integration"

**3. Use slack-map with the following commands and options**

    map [location]

Options:

    zoom=[0 to 21] # 0 is the whole Earth, 21 is a single building - default is 13 (roughly city-sized)
    maptype=[roadmap, satellite, hybrid, terrain] # default is roadmap

### Limitations

The Google Static Maps API (https://developers.google.com/maps/documentation/staticmaps) has some limitations for free apps:

* 1000 Static Maps image requests per IP address per 24 hour period
* 50 Static Maps image requests per IP address per minute

Also, keep in mind that Slack will not expand multiple images of the same map if the same link is posted into a channel within an hour.
