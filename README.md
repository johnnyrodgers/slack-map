## slack-map: A slack webhook for the Google Static Maps API

slack-map lets you post static Google Maps images into your Slack instance. Request a map with a command like `map London` and an image of that location will be posted into your Slack channel along with a link to open the map in your browser.

### Examples 

![Rome](https://slack-files.com/files-pub/T024F5NQC-F028EB7BH-760726/map_rome.png)
![221B Baker Street](https://slack-files.com/files-pub/T024F5NQC-F028EB86D-d3082a/map_sherlock.png)
![Vatican City](https://slack-files.com/files-pub/T024F5NQC-F028F1X3L-f17bc9/map_vatican_city_satellite.png)
![Costa Rica](https://slack-files.com/files-pub/T024F5NQC-F028F1X4U-b02c7d/map_costa_rica_terrain.png)

### Setup

There are a few moving parts to get this integration set up for your Slack team. These steps assume some knowledge of Slack, git, and Heroku, though links to documentation have been provided where possible.

**1. Slack Incoming Webhook**

* Go to https://my.slack.com/services/new
* Add an Incoming Webhook.
* Expand the "Instructions for creating Incoming WebHooks" section.
* Copy the URL under "Sending Messages". It looks something like `https://hooks.slack.com/services/T12345678/B12345678/[token]`. You'll need this in the next step.
* Save Settings

**2. Heroku App**

* Clone this git repo
* Create a file in your local copy of the repo called `config/local_env.yml`
* Paste your Incoming Webhook URL (from the last step) in the following format: `SLACK_WEBHOOK_URL: "https://hooks.slack.com/services/T12345678/B12345678/[token]"`. Save this file.
* Deploy your copy as a new app to Heroku (https://devcenter.heroku.com/articles/git)
* Get your heroku app URL (something like `http://appname.herokuapp.com/`). You'll need this in the next step.
* Set your Heroku config variable for the Incoming Webhook URL (https://devcenter.heroku.com/articles/config-vars): `heroku config:add SLACK_WEBHOOK_URL=https://hooks.slack.com/services/T12345678/B12345678/[token]`
* You can test that the var was set correctly by running `heroku config`

_You could also host this Rails app anywhere web-accessible. There's no reason it needs to be on Heroku: it's just a free and easy place to host apps._

**3. Slack Outgoing Webhook**

* Go to https://my.slack.com/services/new
* Add an Outgoing Webhook with the following settings:
    - **Channel:** select a channel, (Any recommended)
    - **Trigger Words:** map
    - **URL(s):** `http://appname.herokuapp.com/map` (use your heroku app URL from step 2, making sure to add `/map` on to the end)
* Save Integration

**4. Use slack-map with the following commands and options**

    map [location]
	
Options:

    zoom=[0 to 21] # 0 is the whole Earth, 21 is a single building - default is 13 (roughly city-sized)
    maptype=[roadmap, satellite, hybrid, terrain] # default is roadmap

### Limitations

The Google Static Maps API (https://developers.google.com/maps/documentation/staticmaps) has some limitations for free apps:

* 1000 Static Maps image requests per IP address per 24 hour period
* 50 Static Maps image requests per IP address per minute

Also, keep in mind that Slack will not expand multiple images of the same map if the same link is posted into a channel within an hour.
