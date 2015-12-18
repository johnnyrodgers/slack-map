class ApplicationController < ActionController::Base

  def static_map
    # logger.info "Params: "
    # logger.info params

  	# get params
  	command = params["text"] # something like "map Rome"
  	# trigger = params["trigger_word"] # something like "map"

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
  	end

		# match maptype=[roadmap, satellite, terrain, hybrid]
  	if command.match(maptype_regex)
  		maptype = command[maptype_regex]
  		maptype.gsub!("maptype=", "")
  		command.gsub!(maptype_regex, "")
  	end

  	# format payload
    location_params = {
      center: command,
      zoom: zoom,
      size: '800x400',
      sensor: false,
      maptype: maptype
    }

    payload = {
      "text" => "",
      "attachments" => [{
        "fallback" => "A map of #{command}.",
        "title"=> "A map of #{command}",
        "title_link"=> "https://www.google.com/maps/place/#{CGI.escape(command)}",
        "image_url"=> "http://maps.googleapis.com/maps/api/staticmap?#{location_params.to_param}",
      }]
  	}

    # logger.info payload

    render json: payload
  end

end
