class ApplicationController < ActionController::Base
  
  def static_map
  
  	logger.debug params.to_yaml
  	
  	# get params
  	command = params["text"] # something like "map Rome"
  	trigger = params["trigger_word"] # something like "map"

  	# set param defaults
  	# docs: 
  	# https://developers.google.com/maps/documentation/staticmaps/?csw=1#MapTypes
  	# https://developers.google.com/maps/documentation/staticmaps/?csw=1#Zoomlevels
  	zoom = 13
  	maptype = "roadmap"
  	
  	# regex params
  	zoom_regex = /zoom=\d+/
  	maptype_regex = /maptype=[a-z]+/
  	
		# match zoom=[0..21], where 0 is the entire Earth and 21 is an individual building
  	if command.match(zoom_regex)
  		zoom = command[zoom_regex]
  		zoom.gsub!("zoom=", "")
  		command.gsub!(zoom_regex, "")
  		logger.debug "Zoom level detected: " + zoom
  	end

		# match maptype=[roadmap, satellite, terrain, hybrid]  	
  	if command.match(maptype_regex)
  		maptype = command[maptype_regex]
  		maptype.gsub!("maptype=", "")
  		command.gsub!(maptype_regex, "")
  		logger.debug "Maptype detected: " + maptype
  	end
  	
  	# strip trigger and assign to location
  	location = command.gsub!(trigger+" ", "")
  	
  	# format payload
  	payload = {
  		"channel" => "#mapbot", 
  		"username" => "mapbot", 
  		"text" => "A map of <https://www.google.com/maps/place/#{CGI.escape(location)}|#{location}> (<https://www.google.com/maps/place/#{CGI.escape(location)}|View on Google Maps>): <http://maps.googleapis.com/maps/api/staticmap?center=#{CGI.escape(location)}&zoom=#{zoom}&size=800x800&sensor=false&maptype=#{maptype}| >",
  		"icon_emoji" => ":earth_americas:"
  	}
  	
  	post_to_slack(payload)
  	
  	render :nothing => true
  
  end
  
  # posts a pre-formatted message to your Slack instance
	def post_to_slack(payload)

		# set your Slack incoming webhook URL here
		# in the form: https://[team].slack.com/services/hooks/incoming-webhook?token=[token]
		url = "https://give.slack.com/services/hooks/incoming-webhook?token=j6dqfsoMThqXeBkp8jUD8M2s"

		# post to slack
		begin
			response = HTTParty.post(url, :body => { "payload" => payload.to_json })
		rescue Timeout::Error => e
			logger.info "Unable to post to Slack due to a Timeout"
		rescue Exception => e
			logger.info "Unable to post to Slack:"
			logger.info e.inspect
		end

	end
  
end