== slack-map: A slack webhook for the Google Static Maps API

slack-map lets you post static Google Maps images into your Slack instance. When you paste a link to a Google Map or request a map with a command like `map London`, an image of that location will be posted into your Slack channel along with a link to open the map in your browser.

=== Examples 

TODO: add screenshots

=== Setup

There are a few moving parts to get this integration set up for your Slack team.

==== 1. Slack Incoming Webhook

* Go to https://my.slack.com/services/new
* Add an Incoming Webhook.
* Expand the "Instructions for creating Incoming WebHooks" section.
* Copy the URL under "Sending Messages". It looks something like http://teamname.slack.com/services/hooks/incoming-webhook?token=token. You'll need this in the next step.
* Save Settings

==== 2. Heroku App

* Clone this git repo
* Open application_controller.rb and paste your Incoming Webhook URL (from the last step) in the post_to_slack method:

    url = [your webhook URL]
	
* Deploy to Heroku (https://devcenter.heroku.com/articles/git)
* Get your heroku app URL (something like http://appname.herokuapp.com/`). You'll need this in the next step.

You could also host this Rails app anywhere web-accessible. There's no reason it needs to be on Heroku: it's just a free and easy place to host apps.

==== 3. Slack Outgoing Webhook

* Go to https://my.slack.com/services/new
* Add an Outgoing Webhook with the following settings:
    Channel: select a channel, (Any recommended)
    Trigger Words: map
    URL(s): your heroku URL
* Save Integration

==== 4. Use slack-map with the following commands and options

    map [location]
	
Options:

    zoom=[0 to 21] # 0 is the whole Earth, 21 is a single building - default is 13 (roughly city-sized)
    maptype=[roadmap, satellite, hybrid, terrain] # default is roadmap

=== Limitations

The Google Static Maps API (https://developers.google.com/maps/documentation/staticmaps) has some limitations for free apps:

* 1000 Static Maps image requests per IP address per 24 hour period
* 50 Static Maps image requests per IP address per minute

Also, keep in mind that Slack will not expand multiple images of the same map if the same link is posted into a channel within an hour.
